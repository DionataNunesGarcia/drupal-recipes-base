# Skill: Create Event Subscriber

SKILL: create-event-subscriber

Context

Drupal 10+ with DDEV.

Task

Replace hook-based logic with Event Subscriber.

Event

```
{{event}}
```

Requirements
- Create class in src/EventSubscriber/
- Register in services.yml
- Use Symfony EventDispatcher
Rules
- Modern code
- Avoid legacy hooks
Output
- Complete class
- services.yml updated
- Explanation of the event used

---

## Event Subscriber Template

### `src/EventSubscriber/MyEventSubscriber.php`

```php
<?php

namespace Drupal\{{module}}\EventSubscriber;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Event subscriber description.
 */
class MyEventSubscriber implements EventSubscriberInterface {

  /**
   * {@inheritdoc}
   */
  public static function getSubscribedEvents(): array {
    return [
      // Event::EVENT_NAME => ['methodName', priority]
      KernelEvents::REQUEST => ['onRequest', 0],
    ];
  }

  /**
   * Handle the request event.
   */
  public function onRequest($event): void {
    // Handle event
  }

}
```

### `services.yml`

```yaml
services:
  {{module}}.event_subscriber:
    class: Drupal\{{module}}\EventSubscriber\MyEventSubscriber
    tags:
      - { name: event_subscriber }
```

---

## Common Events

| Event | When |
|-------|------|
| `KernelEvents::REQUEST` | Every HTTP request |
| `KernelEvents::RESPONSE` | Before response sent |
| `KernelEvents::VIEW` | Building render array |
| `EntityTypeEvents::CREATE` | Entity created |
| `config_translation_init_options` | Translation loading |
| `router.build` | Router rebuilt |

---

## Tips

- Use priority to control order (higher = earlier)
- Always implement getSubscribedEvents()
- Use dependency injection for services