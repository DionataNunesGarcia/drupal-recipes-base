# Skill: Debug Drupal

SKILL: debug-drupal

Context

Drupal project running via DDEV.

Problem

```
{{description}}
```

Task

Diagnose and propose solution.

Requirements
- Consider: Drupal Cache, Services, Hooks, Configuration, Database
Include
- Useful DDEV/Drush commands
- Relevant logs
- Possible causes
Output
- Clear diagnosis
- Step-by-step resolution

---

## Common Issues & Solutions

### 1. White Screen / WSOD

Diagnosis:
```bash
# Enable error display
ddev exec php -d display_errors=1 -d error_reporting=E_ALL web/index.php

# Check logs
ddev drush watchdog:show --count=50
ddev drush php:eval "error_reporting(E_ALL); ini_set('display_errors', 1);"
```

Causes:
- PHP fatal error
- Memory limit exhausted
- Missing module
- Database connection issues

Solution:
```bash
ddev drush cr
ddev composer install
ddev drush updatedb
```

---

### 2. Cache Issues

Diagnosis:
```bash
# Clear all caches
ddev drush cr

# Rebuild container
ddev drush container-rebuild

# List cache bins
ddev drush php:eval "print_r(\Drupal\Core\Cache\Cache::getBins());"
```

Solution:
```bash
# Force clear
ddev drush cache:clear --all

# Clear specific bin
ddev drush cc render
```

---

### 3. Module Not Enabling

Diagnosis:
```bash
# Check dependencies
ddev drush pm:info {{module_name}}

# Check log
ddev drush watchdog:show --type=php --count=10
```

Solution:
```bash
# Install dependencies first
ddev composer require drupal/{{dependency}}
ddev drush en {{module_name}}
```

---

### 4. Database Issues

Diagnosis:
```bash
# Check connection
ddev drush sql:connect

# Run updates
ddev drush updatedb:status
ddev drush updatedb
```

Solution:
```bash
# Import config
ddev drush config:import

# Sync database
ddev drush sql:sync @source @self
```

---

### 5. Routing/Route Not Found

Diagnosis:
```bash
# Clear router
ddev drush router:rebuild

# List routes
ddev drush core:route
```

Solution:
```bash
ddev drush cr all
```

---

### 6. Permission Issues

Diagnosis:
```bash
# Check permissions
ddev drush php:eval "print_r(\Drupal::currentUser()->getRoles());"

# Test route access
ddev drush core:router {{route_name}}
```

Solution:
```yaml
# In routing.yml
requirements:
  _permission: 'access content'
  _role: 'authenticated'
```

---

## Useful Commands

```bash
# Clear cache
ddev drush cr

# Rebuild
ddev drush router:rebuild
ddev drush container:di

# Watchdog
ddev drush watchdog:show --count=50
ddev drush watchdog:show --type=php

# Routes
ddev drush core:route

# Services
ddev drush container:di

# Config
ddev drush config:state
ddev drush config:import

# Database
ddev drush sql:query "SELECT * FROM {watchdog} LIMIT 10"
```

---

## Tips

1. Always clear cache after code changes
2. Use Devel module for debugging
3. Check watchdog table for errors
4. Enable Twig debug in development
5. Use Xdebug for step-by-step debugging