#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No color

echo -e "${CYAN}=================================================${NC}"
echo -e "${CYAN}      Drupal Recipes Installer                   ${NC}"
echo -e "${CYAN}=================================================${NC}\n"

# ─── Detect environment ───────────────────────────────────────────────────────
if command -v ddev >/dev/null 2>&1 && ddev describe >/dev/null 2>&1; then
	CMD="ddev"
	echo -e "${GREEN}DDEV environment detected.${NC}\n"
elif command -v lando >/dev/null 2>&1 && lando info >/dev/null 2>&1; then
	CMD="lando"
	echo -e "${GREEN}Lando environment detected.${NC}\n"
else
	if [ -d ".ddev" ]; then
		CMD="ddev"
		echo -e "${YELLOW}DDEV config (.ddev) found, but environment is not running.${NC}"
		echo -e "${YELLOW}Assuming 'ddev'. Run 'ddev start' first.${NC}\n"
	elif [ -f ".lando.yml" ]; then
		CMD="lando"
		echo -e "${YELLOW}Lando config (.lando.yml) found, but environment is not running.${NC}"
		echo -e "${YELLOW}Assuming 'lando'. Run 'lando start' first.${NC}\n"
	else
		CMD=""
		echo -e "${YELLOW}No DDEV or Lando detected. Running drush commands directly.${NC}\n"
	fi
fi

# ─── Helper: run drush ────────────────────────────────────────────────────────
run_drush() {
	if [ -n "$CMD" ]; then
		$CMD drush "$@"
	else
		drush "$@"
	fi
}

# ─── Helper: copy recipe templates to theme ─────────────────────────────
copy_recipe_templates() {
	local recipe_path=$1
	local theme_dir=$(ls -d web/themes/custom/*/ 2>/dev/null | head -1)

	if [ -z "$theme_dir" ]; then
		echo -e "${YELLOW}No custom theme found. Skipping template copy.${NC}"
		return
	fi

	local templates_dir="$recipe_path/templates"
	if [ ! -d "$templates_dir" ]; then
		return
	fi

	echo -e "${CYAN}Templates found in $recipe_path${NC}"
	while true; do
		read -p "Copy templates to $theme_dir? [Y/n]: " choice
		choice=${choice:-y}

		case "$choice" in
			[yY][eE][sS]|[yY])
				mkdir -p "$theme_dir/templates"
				cp -r "$templates_dir"/* "$theme_dir/templates/" 2>/dev/null
				echo -e "${GREEN}Templates copied to $theme_dir/templates/${NC}"
				break
				;;
			[nN][oO]|[nN])
				echo -e "${YELLOW}Skipping template copy.${NC}"
				break
				;;
			*)
				echo -e "${YELLOW}Please answer 'y' or 'n'.${NC}"
				;;
		esac
	done
}

# ─── Helper: prompt and install a recipe ─────────────────────────────────────
install_recipe() {
	local recipe_path=$1
	local description=$2
	local copy_templates=${3:-false}

	echo -e "${CYAN}Recipe: ${YELLOW}$recipe_path${NC}"
	echo -e "Description: $description"

	while true; do
		read -p "Do you want to install this recipe? [Y/n]: " choice
		choice=${choice:-y}

		case "$choice" in
			[yY][eE][sS]|[yY])
				echo -e "${GREEN}Installing $recipe_path...${NC}"
				run_drush recipe "$recipe_path"

				if [ "$copy_templates" = "true" ]; then
					copy_recipe_templates "$recipe_path"
				fi

				echo ""
				break
				;;
			[nN][oO]|[nN])
				echo -e "${YELLOW}Skipping $recipe_path.${NC}\n"
				break
				;;
			*)
				echo -e "${YELLOW}Please answer 'y' for yes or 'n'.${NC}"
				;;
		esac
	done
}

# ─── base_admin ───────────────────────────────────────────────────────────────
install_recipe "../recipes/base_admin" "Admin UI (Gin theme, toolbar improvements)"

# ─── Multilingual ─────────────────────────────────────────────────────────────
echo -e "${CYAN}─── Multilingual Setup ──────────────────────────${NC}"
echo -e "Description: Choose an extra language to install alongside base_i18n."
echo -e "             Leave blank (None) to keep English — Drupal's default."
echo ""
echo "  1) Portuguese BR  (base_i18n + base_pt_br)"
echo "  2) Spanish        (base_i18n + base_es)"
echo "  3) Both PT-BR and Spanish"
echo "  4) None           (English only — Drupal default, no recipe needed)"
echo ""

LANG_INSTALLED=false

while true; do
	read -p "Choose an option [4]: " lang_choice
	lang_choice=${lang_choice:-4}

	case "$lang_choice" in
		1)
			echo -e "${GREEN}Installing base_i18n + base_pt_br...${NC}"
			run_drush recipe ../recipes/base_i18n
			run_drush recipe ../recipes/base_pt_br
			LANG_INSTALLED=true
			break
			;;
		2)
			echo -e "${GREEN}Installing base_i18n + base_es...${NC}"
			run_drush recipe ../recipes/base_i18n
			run_drush recipe ../recipes/base_es
			LANG_INSTALLED=true
			break
			;;
		3)
			echo -e "${GREEN}Installing base_i18n + base_pt_br + base_es...${NC}"
			run_drush recipe ../recipes/base_i18n
			run_drush recipe ../recipes/base_pt_br
			run_drush recipe ../recipes/base_es
			LANG_INSTALLED=true
			break
			;;
		4)
			echo -e "${YELLOW}Keeping English only (Drupal default). No language recipes installed.${NC}"
			break
			;;
		*)
			echo -e "${YELLOW}Invalid option. Choose 1, 2, 3 or 4.${NC}"
			;;
	esac
done

# Run locale-update only when at least one language was installed
if [ "$LANG_INSTALLED" = true ]; then
	echo -e "${GREEN}Updating language translations...${NC}"
	run_drush locale-update
fi
echo ""

# ─── base_seo ─────────────────────────────────────────────────────────────────
install_recipe "../recipes/base_seo" "SEO (metatag, sitemap and other SEO tools)"

# ─── Frontend Theme ───────────────────────────────────────────────────────────
echo -e "${CYAN}─── Frontend Theme ──────────────────────────────${NC}"
echo -e "Description: Custom theme scaffold (Tailwind or Bootstrap)"
echo ""

# Read values from .env
THEME_NAME=$(grep -E "^CUSTOM_THEME_NAME=" .env 2>/dev/null | cut -d'=' -f2 | tr -d '\r')
THEME_FRAMEWORK=$(grep -E "^THEME_FRAMEWORK=" .env 2>/dev/null | cut -d'=' -f2 | tr -d '\r' | tr '[:upper:]' '[:lower:]')

[ -z "$THEME_NAME" ] && THEME_NAME="front_theme"
[ -z "$THEME_FRAMEWORK" ] && THEME_FRAMEWORK="tailwind"

printf "  Theme name : ${GREEN}%s${NC}\n" "$THEME_NAME"
printf "  Framework  : ${GREEN}%s${NC}\n" "$THEME_FRAMEWORK"
echo ""
echo "Select CSS framework:"
echo "  1) Tailwind (default)"
echo "  2) Bootstrap"
echo ""

THEME_INSTALLED=false

while true; do
	read -p "Choose framework [1]: " fw_choice
	fw_choice=${fw_choice:-1}

	case "$fw_choice" in
		1) THEME_FRAMEWORK="tailwind"; break ;;
		2) THEME_FRAMEWORK="bootstrap"; break ;;
		*) echo -e "${YELLOW}Invalid option. Choose 1 or 2.${NC}" ;;
	esac
done

# Persist selected framework to .env
if grep -qE "^THEME_FRAMEWORK=" .env 2>/dev/null; then
	sed -i "s/^THEME_FRAMEWORK=.*/THEME_FRAMEWORK=$THEME_FRAMEWORK/" .env
else
	echo "THEME_FRAMEWORK=$THEME_FRAMEWORK" >> .env
fi

echo ""
printf "Framework selected: ${GREEN}%s${NC}\n" "$THEME_FRAMEWORK"
echo ""

# Warn about Bootstrap + Dart Sass deprecation warnings
if [ "$THEME_FRAMEWORK" = "bootstrap" ]; then
	echo -e "${YELLOW}Note: Bootstrap 5.3 emits Sass deprecation warnings with Dart Sass 1.70+.${NC}"
	echo -e "${YELLOW}These are warnings from inside Bootstrap's own source — the build still succeeds.${NC}"
	echo -e "${YELLOW}They will be fixed in Bootstrap 6. You can safely ignore them.${NC}\n"
fi

while true; do
	read -p "Generate theme '$THEME_NAME' with $THEME_FRAMEWORK? [Y/n]: " th_choice
	th_choice=${th_choice:-y}

	case "$th_choice" in
		[yY][eE][sS]|[yY])
			if [ "$THEME_FRAMEWORK" = "bootstrap" ]; then
				echo -e "${GREEN}Installing base_theme_bootstrap recipe...${NC}"
				run_drush recipe ../recipes/base_theme_bootstrap
			else
				echo -e "${GREEN}Installing base_theme recipe...${NC}"
				run_drush recipe ../recipes/base_theme
			fi
			THEME_INSTALLED=true
			break
			;;
		[nN][oO]|[nN])
			echo -e "${YELLOW}Skipping theme generation.${NC}"
			echo -e "${CYAN}To install later: edit CUSTOM_THEME_NAME / THEME_FRAMEWORK in .env, then run:${NC}"
			if [ "$THEME_FRAMEWORK" = "bootstrap" ]; then
				echo -e "${YELLOW}  $CMD drush recipe ../recipes/base_theme_bootstrap${NC}"
			else
				echo -e "${YELLOW}  $CMD drush recipe ../recipes/base_theme${NC}"
			fi
			break
			;;
		*)
			echo -e "${YELLOW}Please answer 'y' or 'n'.${NC}"
			;;
	esac
done
echo ""

# ─── base_lp ───────────────────────────────────────────────────────────────
install_recipe "../recipes/base_lp" "Landing pages (Content Type, views and paragraph components)" "true"
install_recipe "../recipes/base_contents" "Contents (Content Type, views and paragraph components)" "true"
install_recipe "../recipes/base_courses" "Courses (Content Type, views and paragraph components)" "true"
install_recipe "../recipes/base_ai" "AI Core (OpenAI / Ollama integrations)"
install_recipe "../recipes/base_ai_contents" "AI Content automation (AI-powered content generation tools)"

# ─── Final steps ─────────────────────────────────────────────────────────────
echo -e "${CYAN}=================================================${NC}"
echo -e "${CYAN}Final Processes...                               ${NC}"
echo -e "${CYAN}=================================================${NC}\n"

if [ "$THEME_INSTALLED" = true ]; then
	if [ "$CMD" = "ddev" ]; then
		echo -e "${GREEN}Installing theme dependencies (npm)...${NC}"
		ddev theme-install

		echo -e "${GREEN}Building production theme...${NC}"
		ddev theme-build
	elif [ "$CMD" = "lando" ]; then
		echo -e "${YELLOW}Note: 'theme-install' and 'theme-build' are custom DDEV commands.${NC}"
		echo -e "${YELLOW}With Lando, build the theme manually:${NC}"
		echo -e "${YELLOW}  cd web/themes/custom/$THEME_NAME && npm install && npm run build${NC}\n"
	else
		echo -e "${YELLOW}Build the theme manually:${NC}"
		echo -e "${YELLOW}  cd web/themes/custom/$THEME_NAME && npm install && npm run build${NC}\n"
	fi

# Create menu links for base_menus (dependency of theme recipes)
	echo -e "${GREEN}Creating menu links...${NC}"
	run_drush eval "
\$menus = ['menus-cta' => '/', 'menu-footer-about' => '/', 'menu-footer-programs' => '/', 'menu-footer-privacy-terms' => '/'];
foreach (\$menus as \$menu => \$path) {
  \$existing = \Drupal::entityTypeManager()->getStorage('menu_link_content')->loadByProperties(['menu_name' => \$menu, 'link' => 'internal:' . \$path]);
  if (empty(\$existing)) {
    \$link = \Drupal::entityTypeManager()->getStorage('menu_link_content')->create([
      'title' => 'Home',
      'link' => 'internal:' . \$path,
      'menu_name' => \$menu,
      'expanded' => false,
      'enabled' => true,
    ]);
    \$link->save();
    print 'Created link in ' . \$menu . \"\\n\";
  }
}
"
fi

echo -e "${GREEN}Clearing Drupal caches...${NC}"
run_drush cr

echo -e "${GREEN}Generating admin login link...${NC}"
run_drush uli

echo -e "\n${CYAN}=================================================${NC}"
echo -e "${GREEN}All requested processes completed!${NC}"
echo -e "${CYAN}=================================================${NC}\n"