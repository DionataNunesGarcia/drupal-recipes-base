# Drupal Recipes Starter

A professional Drupal 11 starter project with AI capabilities, built on **DDEV** and **Drupal Recipes**.

---

## Features

- **Drupal 11** with PHP 8.4
- **PostgreSQL 18** database
- **DDEV** for local development
- **AI-Powered** (OpenAI, Ollama, Content Suggestions)
- **Recipes** system for modular setup

---

## Quick Start

```bash
# Clone and start
git clone <repo-url>
cd <project-folder>
ddev start

# Install
ddev composer install
ddev drush si standard -y

# Apply recipes
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_seo
ddev drush recipe ../recipes/base_theme
ddev drush recipe ../recipes/base_lp
ddev drush recipe ../recipes/base_ai
ddev theme-install
ddev theme-build
ddev drush cr
ddev drush uli
```

---

## Available Recipes

| Recipe | Purpose |
|--------|---------|
| `base_admin` | Admin UI (Gin, toolbar) |
| `base_i18n` | Multilingual setup |
| `base_seo` | SEO (metatag, sitemap) |
| `base_theme` | Frontend theme (Tailwind) |
| `base_lp` | Landing pages |
| `base_ai` | AI Core (OpenAI/Ollama) |
| `base_ai_contents` | AI Content automation |

---

## AI Commands

```bash
# Test AI
ddev drush ai:chat "Hello" --provider=openai

# Or use DDEV helper
ddev ai test
ddev ai ai-chat "Help me create a form"

# Install AI
ddev ai install
```

### DDEV AI Commands

```bash
ddev ai help                    # Show all commands
ddev ai new-module <name>     # Create module
ddev ai new-service <module> <name>  # Create service
ddev ai test                 # Test AI
ddev ai status              # AI status
ddev ai install           # Install AI recipes
ddev ai clear-cache        # Clear caches
```

---

## Development

```bash
# After git pull
ddev local-update

# Frontend
ddev theme-watch    # Watch mode
ddev theme-build  # Production build
```

---

## Environment

| Setting | Value |
|---------|-------|
| PHP | 8.4 |
| Database | PostgreSQL 18 |
| Web server | nginx-fpm |

---

## Documentation

- [AI Skills](.ai/skills/) - Code generation prompts
- [Context](.ai/context/) - Project context for AI
- [Recipes](recipes/) - Drupal recipes

---

## License

MIT