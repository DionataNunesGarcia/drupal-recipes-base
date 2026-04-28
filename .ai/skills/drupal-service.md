# Skill: Refactor to Service

SKILL: refactor-to-service

Context

Drupal project with DDEV.

Task

Refactor the code below to use a Drupal Service:

```
{{code}}
```

Requirements
- Create class in src/Service/
- Register in services.yml
- Use dependency injection
- Remove \Drupal:: when possible
Rules
- Follow Drupal 10+ best practices
- Testable code
- Separation of concerns
Output
- Complete Service class
- Updated services.yml
- Usage example

---

## Service Template

### `src/Service/MyService.php`

```php
<?php

namespace Drupal\{{module}}\Service;

use Drupal\Core\Logger\LoggerChannelInterface;

/**
 * Service description.
 */
class MyService {

  /**
   * Logger channel.
   */
  protected LoggerChannelInterface $logger;

  /**
   * Constructor.
   */
  public function __construct(LoggerChannelInterface $logger) {
    $this->logger = $logger;
  }

  /**
   * Method description.
   */
  public function doSomething(): void {
    $this->logger->info('Doing something');
  }

}
```

### `services.yml`

```yaml
services:
  {{module}}.my_service:
    class: Drupal\{{module}}\Service\MyService
    arguments: ['@logger.channel.{{module}}']
    tags:
      - { name: logger.channel }
```

### Usage in Controller

```php
// Inject service via constructor
$myService = \Drupal::service('{{module}}.my_service');
$myService->doSomething();

// Or with DI in controller
$myService = $this->getMyService();
```

---

## Tips

- Always use dependency injection over \Drupal::service()
- Use logging for debugging
- Keep services focused and single-responsibility
- Use plugins for extendable functionality