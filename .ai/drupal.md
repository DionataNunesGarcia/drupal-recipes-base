# Drupal Context

Project-specific context for AI interactions.

## Project Info

- **Drupal Version:** 11.3.8
- **PHP Version:** 8.4
- **Database:** PostgreSQL 18
- **DDEV:** Yes
- **Package Manager:** Composer

---

## 🏗️ Architecture

### Recipe System

This project uses Drupal Recipes for modular setup:

- `base_core` - Core setup
- `base_admin` - Admin UI (Gin theme)
- `base_i18n` - Multilingual infrastructure
- `base_seo` - SEO tools
- `base_theme` - Custom theme with Tailwind
- `base_lp` - Landing pages
- `base_ai` - AI Core (OpenAI, Ollama)
- `base_ai_contents` - AI Content automation
- `base_ai_search` - AI Semantic search

---

## 📦 Installed Contrib Modules

### AI
- `drupal/ai` - AI Core
- `drupal/ai_provider_openai` - OpenAI provider
- `drupal/ai_provider_ollama` - Ollama provider (local)
- `drupal/ai_api_explorer` - Development testing
- `drupal/ai_content_suggestions` - Content suggestions
- `drupal/ai_translate` - AI translation
- `drupal/ai_vdb_provider_postgres` - PostgreSQL vectors

### SEO
- `drupal/metatag` - Meta tags
- `drupal/schema_metatag` - Schema.org
- `drupal/simple_sitemap` - XML sitemap
- `drupal/redirect` - URL redirects
- `drupal/pathauto` - URL aliases

### Admin
- `drupal/gin` - Admin theme
- `drupal/admin_toolbar` - Admin toolbar

### Content
- `drupal/media` - Media library
- `drupal/paragraphs` - Paragraphs
- `drupal/webform` - Webforms

---

## 🎨 Theme

Custom theme: `web/themes/custom/front_theme/`

Stack:
- Tailwind CSS v3
- SCSS
- esbuild

---

## 📝 Code Standards

- PSR-12 code style
- Dependency injection preferred
- Modern Drupal 10+ patterns
- No legacy hooks when possible
- Use plugins over hooks

---

## 🧪 Local Development

```bash
# Start environment
ddev start

# Install dependencies
ddev composer install

# Clear cache
ddev drush cr

# Run updates
ddev drush updatedb

# Apply recipe
ddev drush recipe ../recipes/base_ai
```

---

## 🔗 Useful Links

- `/admin/config/ai` - AI settings
- `/admin/config/ai/providers` - AI providers
- `/admin/config/ai/suggestions` - Content suggestions
- `/admin/config/ai/ai-translate` - AI translation
- `/admin/config/search/simplesitemap` - Sitemap settings