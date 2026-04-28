# Contributing to Drupal Recipes Starter

## Getting Started

1. Fork the repository
2. Clone your fork
3. Create a feature branch

```bash
git checkout -b feature/my-feature
```

## Development Workflow

```bash
# Start environment
ddev start

# Install dependencies
ddev composer install

# Create your feature
# ... make changes ...

# Test
ddev local-update
ddev drush cr

# Commit changes
git add .
git commit -m "Add my feature"
```

## Code Standards

- Follow PSR-12 code style
- Use dependency injection
- Avoid legacy hooks when possible
- Test on clean install before submitting

## Submitting Changes

1. Push to your fork
2. Create pull request
3. Describe your changes
4. Link related issues

## Recipe Guidelines

When creating new recipes:

```yaml
# recipe.yml must have:
name: Recipe Name
description: What it does
type: site

install:
  - module_name

config:
  strict: false
  actions:
    # config changes
```

---

## Questions?

Open an issue for discussion before submitting large changes.