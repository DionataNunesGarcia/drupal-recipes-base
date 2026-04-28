# Skill: Create Drupal Module

SKILL: generate-drupal-module

Context

You are in a Drupal project running with DDEV.

Task

Create a Drupal 10 module called: `{{module_name}}`

Requirements
- Follow PSR-12
- Use namespace Drupal\{{module_name}}
- Create structure:
  - {{module_name}}.info.yml
  - {{module_name}}.module
  - {{module_name}}.routing.yml
  - {{module_name}}.services.yml
  - src/Controller/
  - src/Form/
Rules
- Clean, modern code (Drupal 10+)
- Avoid legacy hooks when possible
- Use dependency injection
Extra
- Create a controller with route /{{module_name}}
- Return a simple render array
Output
- All complete files
- Briefly explain each file

---

## Example Output

### `mymodule.info.yml`

```yaml
name: My Module
description: 'Provides custom functionality for...'
core_version_requirement: ^10 || ^11
type: module
package: Custom
version: 1.0.0

dependencies:
  - drupal:type
```

### `mymodule.module`

```php
<?php

/**
 * @file
 * Module hooks.
 */

use Drupal\Core\Routing\RouteMatchInterface;

/**
 * Implements hook_help().
 */
function mymodule_help($route_name, RouteMatchInterface $route_match) {
  switch ($route_name) {
    case 'mymodule.settings':
      return t('Configure my module settings.');
  }
}
```

### `mymodule.routing.yml`

```yaml
mymodule.settings:
  path: '/admin/config/mymodule'
  defaults:
    _form: '\Drupal\mymodule\Form\SettingsForm'
    _title: 'My Module Settings'
  requirements:
    _permission: 'administer mymodule'
```

---

## Tips

- Always use dependency injection for services
- Prefer plugins over hooks when possible
- Use Symfony conventions where possible
- Register routes in `routing.yml`, not `_menu()`