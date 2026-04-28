# Lando Support

This project supports both **DDEV** and **Lando** for local development.

## Quick Start (Lando)

```bash
# Start environment
lando start

# Install Drupal
lando composer install
lando drush si standard -y

# Apply recipes
lando drush recipe ../recipes/base_admin
lando drush recipe ../recipes/base_i18n
lando drush recipe ../recipes/base_seo
lando drush recipe ../recipes/base_theme
lando drush recipe ../recipes/base_lp
lando drush recipe ../recipes/base_ai

# Build theme
lando theme-install
lando theme-build

# Finalize
lando drush cr
lando drush uli
```

## Available Commands

### DDEV
```bash
ddev start
ddev ai new-module my_module
ddev ai test
ddev ai debug
ddev theme-install
ddev theme-build
ddev theme-watch
ddev theme-dev
ddev local-update
```

### Lando
```bash
lando start
lando ai new-module my_module
lando ai test
lando ai debug
lando theme-install
lando theme-build
lando theme-watch
lando theme-dev
lando local-update
```

## DDEV vs Lando Comparison

| Feature | DDEV | Lando |
|---------|------|------|
| Start | `ddev start` | `lando start` |
| AI commands | `ddev ai ...` | `lando ai ...` |
| Theme build | `ddev theme-build` | `lando theme-build` |
| Theme watch | `ddev theme-watch` | `lando theme-watch` |
| Local update | `ddev local-update` | `lando local-update` |
| Drush | `ddev drush ...` | `lando drush ...` |
| MySQL client | `ddev mysql` | `lando mysql` |

## Environment Variables

Both environments support `.env` file:

```bash
CUSTOM_THEME_NAME=front_theme
```

## Troubleshooting

### Lando not recognized
```bash
# Install Lando
curl -fsSL https://get.lando.dev | sh

# Start
lando start
```

### Permission issues
```bash
# Fix permissions
sudo chown -R $(whoami):$(whoami) .
```

## Notes

- Scripts in `scripts/` work with both environments
- AI commands delegate to `scripts/ai.sh`
- Theme commands use CUSTOM_THEME_NAME from .env