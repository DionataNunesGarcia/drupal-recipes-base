# Skills for Drupal Development

This directory contains AI skills for Drupal development tasks.

## Available Skills

### 1. Create Drupal Module
File: `drupal-module.md`

SKILL: generate-drupal-module

Creates a complete Drupal 10+ module with modern best practices.

Variables:
- `{{module_name}}` - Machine name (e.g., `my_module`)
- `{{human_name}}` - Human readable name
- `{{description}}` - Module description

---

### 2. Create Drupal Service
File: `drupal-service.md`

SKILL: refactor-to-service

Refactors code to use Drupal Services with Dependency Injection.

Variables:
- `{{code}}` - Code to refactor

---

### 3. Create Drupal API
File: `drupal-api.md`

SKILL: create-drupal-api

Creates REST or JSON API endpoints in Drupal.

Variables:
- `{{description}}` - API description
- `{{endpoint}}` - API endpoint path

---

### 4. Debug Drupal
File: `drupal-debug.md`

SKILL: debug-drupal

Diagnoses and fixes common Drupal issues.

Variables:
- `{{description}}` - Problem description

---

## Usage

Include the skill file in your prompt:

```
Use the skill from .ai/skills/drupal-module.md to create a module called my_module
```

---

## Directory Structure

```
.ai/
├── drupal.md          # Project context
└── skills/
    ├── README.md
    ├── drupal-module.md
    ├── drupal-service.md
    ├── drupal-api.md
    └── drupal-debug.md
```