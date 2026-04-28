# Skill: Create Drupal Plugin

SKILL: create-drupal-plugin

Context

Drupal project with DDEV.

Task

Create a Drupal plugin for: `{{plugin_type}}`

Requirements
- Plugin type: {{plugin_type}} (e.g., action, condition, formatter, widget)
- Module: {{module_name}}
- Plugin ID: {{plugin_id}}
Rules
- Follow plugin conventions
- Use annotations
- Register properly
Output
- Complete plugin class
- Explanation

---

## Plugin Template

```php
<?php

namespace Drupal\{{module}}\Plugin\{{plugin_namespace}};

use Drupal\Core\Plugin\PluginBase;

/**
 * Plugin description.
 *
 * @Plugin(
 *   id = "{{plugin_id}}",
 *   label = @Translation("Label"),
 *   provider = "{{module}}",
 * )
 */
class MyPlugin extends PluginBase {

  /**
   * {@inheritdoc}
   */
  public function buildConfigurationForm(array $form, array $form_state): array {
    // Configuration form
    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function submitConfigurationForm(array &$form, array $form_state): void {
    // Save configuration
  }

  /**
   * {@inheritdoc}
   */
  public function defaultConfiguration(): array {
    return [
      'setting' => 'default_value',
    ] + parent::defaultConfiguration();
  }

}
```

---

## Plugin Types

| Type | Namespace | Common Use |
|------|----------|-----------|
| Action | `Plugin\Action` | Webform actions |
| Condition | `Plugin\Condition` | Access control |
| Block | `Plugin\Block` | Custom blocks |
| FieldFormatter | `Plugin\Field\FieldFormatter` | Display fields |
| FieldWidget | `Plugin\Field\FieldWidget` | Form widgets |
| SearchPlugin | `Plugin\Search` | Search backends |
| REST | `Plugin\rest\resource` | API endpoints |

---

## Tips

- Always extend PluginBase
- Use annotations for definition
- Implement defaultConfiguration()
- Use dependency injection if needed