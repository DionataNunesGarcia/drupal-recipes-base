# Skill: Create Drupal Form

SKILL: create-drupal-form

Context

Drupal project with DDEV.

Task

Create a Drupal form for: `{{form_id}}`

Requirements
- Form class in src/Form/
- Route in routing.yml
- Use modern form API
- Include validation
Rules
- Extend ConfigFormBase for config forms
- Extend FormBase for regular forms
- Use dependency injection
Output
- Complete form class
- Routing configuration

---

## Config Form Template

```php
<?php

namespace Drupal\{{module}}\Form;

use Drupal\Core\Form\ConfigFormBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Configuration form.
 */
class MySettingsForm extends ConfigFormBase {

  /**
   * {@inheritdoc}
   */
  public function getFormId(): string {
    return '{{module}}_settings';
  }

  /**
   * {@inheritdoc}
   */
  protected function getEditableConfigNames(): array {
    return ['{{module}}.settings'];
  }

  /**
   * {@inheritdoc}
   */
  public function buildForm(array $form, FormStateInterface $form_state): array {
    $form['example'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Example'),
      '#default_value' => $this->config('{{module}}.settings')->get('example'),
    ];
    return parent::buildForm($form, $form_state);
  }

  /**
   * {@inheritdoc}
   */
  public function submitForm(array &$form, FormStateInterface $form_state): void {
    $this->config('{{module}}.settings')
      ->set('example', $form_state->getValue('example'))
      ->save();
    parent::submitForm($form, $form_state);
  }

}
```

### Routing

```yaml
{{module}}.settings:
  path: '/admin/config/{{module}}'
  defaults:
    _form: '\Drupal\{{module}}\Form\MySettingsForm'
    _title: 'Settings'
  requirements:
    _permission: 'administer site configuration'
```

---

## Entity Form Template

```php
<?php

namespace Drupal\{{module}}\Form;

use Drupal\Core\Entity\EntityForm;

/**
 * Entity form.
 */
class MyEntityForm extends EntityForm {

  /**
   * {@inheritdoc}
   */
  public function form(array $form, FormStateInterface $form_state): array {
    $form = parent::form($form, $form_state);
    $form['label'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Label'),
      '#maxlength' => 255,
      '#default_value' => $this->entity->label(),
    ];
    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function save(array $form, FormStateInterface $form_state): void {
    $this->entity->save();
    $form_state->setRedirectUrl($this->entity->toUrl('collection'));
  }

}
```

---

## Tips

- Use ConfigFormBase for configuration
- Use EntityForm for entities
- Always implement getFormId()
- Validate with #element_validate
- Use $form_state->setError() for errors