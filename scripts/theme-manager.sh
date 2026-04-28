#!/bin/bash

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

CUSTOM_THEME_NAME=${CUSTOM_THEME_NAME:-front_theme}
BASE_THEME="front_theme"
BASE_THEME_PATH="web/themes/custom/$BASE_THEME"

# Fallback support for typoed 'fornt_theme'
if [ ! -d "$BASE_THEME_PATH" ] && [ -d "web/themes/custom/fornt_theme" ]; then
  BASE_THEME="fornt_theme"
  BASE_THEME_PATH="web/themes/custom/$BASE_THEME"
fi

THEME_PATH="web/themes/custom/$CUSTOM_THEME_NAME"

case "$1" in
  setup)
    echo "Setting up theme: $CUSTOM_THEME_NAME"
    if [ "$CUSTOM_THEME_NAME" != "$BASE_THEME" ] && [ -d "$BASE_THEME_PATH" ]; then
      echo "Renaming $BASE_THEME to $CUSTOM_THEME_NAME..."
      mv "$BASE_THEME_PATH" "$THEME_PATH"
      
      # Rename files
      find "$THEME_PATH" -name "*$BASE_THEME*" -exec bash -c 'mv "$1" "${1//'$BASE_THEME'/'$CUSTOM_THEME_NAME'}"' -- {} \;
      
      # Replace logic inside files
      grep -rl "$BASE_THEME" "$THEME_PATH" | xargs sed -i "s/$BASE_THEME/$CUSTOM_THEME_NAME/g"
    fi
    
    # Copy templates from recipes if they exist
    RECIPES=("base_lp" "base_contents" "base_courses")
    for RECIPE in "${RECIPES[@]}"; do
      if [ -d "recipes/$RECIPE/templates" ]; then
        echo "Copying templates from $RECIPE recipe to $CUSTOM_THEME_NAME..."
        mkdir -p "$THEME_PATH/templates"
        cp -r recipes/$RECIPE/templates/* "$THEME_PATH/templates/"
      fi
    done

    # Set as default theme in Drupal if drush is available
    if command -v drush &> /dev/null; then
      drush theme:install $CUSTOM_THEME_NAME -y
      drush config-set system.theme default $CUSTOM_THEME_NAME -y
    fi
    ;;
esac
