# Skill: Create Drupal API

SKILL: create-drupal-api

Context

Drupal project with DDEV.

Task

Create an API for: `{{description}}`

Requirements
- Can use: REST Resource plugin OR Controller custom
- Endpoint: /api/{{endpoint}}
Rules
- Return JSON
- Validate input
- Handle errors correctly
- Follow Drupal conventions
- Security: check permissions, sanitize input
Output
- Complete code
- Routes/config needed
- Example request/response

---

## REST Resource Example

### `src/Plugin/rest/resource/MyEndpoint.php`

```php
<?php

namespace Drupal\{{module}}\Plugin\rest\resource;

use Drupal\rest\Plugin\ResourceBase;
use Drupal\rest\ResourceResponse;

/**
 * Provides a REST resource.
 *
 * @RestResource(
 *   id = "{{module}}_endpoint",
 *   label = @Translation("My Endpoint"),
 *   uri_paths = {
 *     "canonical" = "/api/{{endpoint}}",
 *     "https://www.drupal.org/entity={{module}}/endpoint"
 *   }
 * )
 */
class MyEndpoint extends ResourceBase {

  /**
   * GET endpoint.
   */
  public function get(): array {
    return new ResourceResponse([
      'data' => 'Hello World',
      'status' => 'ok',
    ]);
  }

  /**
   * POST endpoint.
   */
  public function post(array $data): ResourceResponse {
    // Validate
    if (empty($data['field'])) {
      return new ResourceResponse([
        'error' => 'Field required',
      ], 400);
    }

    // Process
    $result = $this->processData($data);

    return new ResourceResponse([
      'data' => $result,
      'status' => 'created',
    ], 201);
  }

}
```

### Register in `module.services.yml`

```yaml
services:
  {{module}}.rest:
    class: Drupal\{{module}}\Plugin\rest\resource\MyEndpoint
    parent: rest.plugin.resource.base
    tags:
      - { name: rest_resource }
```

---

## JSON Controller Example

### `src/Controller/ApiController.php`

```php
<?php

namespace Drupal\{{module}}\Controller;

use Drupal\Core\Controller\ControllerBase;

/**
 * API Controller.
 */
class ApiController extends ControllerBase {

  /**
   * JSON endpoint.
   */
  public function endpoint(): array {
    $data = [
      'items' => $this->getItems(),
    ];

    return $data;
  }

}
```

### `module.routing.yml`

```yaml
{{module}}.api:
  path: '/api/{{endpoint}}'
  defaults:
    _controller: '\Drupal\{{module}}\Controller\ApiController::endpoint'
    _title: 'API Endpoint'
  requirements:
    _permission: 'access content'
  methods: [GET]
```

---

## Security

```yaml
# Always require authentication
requirements:
  _permission: 'access content'
  _csrf_token: 'TRUE'
```

### Token validation in POST

```php
public function post(array $data): ResourceResponse {
  // Verify CSRF token
  $token = $this->getCsrfToken();
  if (!$this->tokenValidator->validate($data['token'], $request)) {
    return new ResourceResponse(['error' => 'Invalid token'], 403);
  }
}
```

---

## Example Request/Response

### GET

```
GET /api/my-endpoint HTTP/1.1
Authorization: Basic xxx

Response:
{
  "data": [...],
  "status": "ok"
}
```

### POST

```
POST /api/my-endpoint HTTP/1.1
Content-Type: application/json
Authorization: Basic xxx

{
  "field": "value"
}

Response (201):
{
  "data": {...},
  "status": "created"
}
```

---

## Tips

- Use REST UI module for testing during development
- Always return proper HTTP status codes
- Validate input before processing
- Use existing D8 serialization formats