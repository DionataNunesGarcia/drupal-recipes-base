# Drupal Recipes Starter

A modular Drupal starter project built with **DDEV** and **Drupal Recipes**.

This repository provides a clean and scalable foundation to quickly bootstrap new Drupal projects by composing reusable recipes.

---

## 🚀 Project Goals

- Provide a **minimal and clean Drupal installation**
- Enable **modular architecture using Recipes**
- Standardize common features across projects
- Improve development speed and consistency

---

## 🧱 Architecture

The project is organized around reusable **Drupal Recipes**, each responsible for a specific concern:

```
recipes/
  base_core/
  base_admin/
  base_i18n/
  base_pt_br/
  base_es/
  base_seo/
  base_theme/
  base_paragraphs/
  base_finish/
```

### Recipe Overview

| Recipe            | Responsibility                                              |
| ----------------- | ----------------------------------------------------------- |
| `base_core`       | Core Drupal setup (content, media, views, etc.)             |
| `base_admin`      | Admin UI and developer experience (Gin, toolbar)            |
| `base_i18n`       | Multilingual infrastructure (language, locale, translation) |
| `base_pt_br`      | PT-BR as the only language, removes others                  |
| `base_es`         | Spanish as the only language, removes others                |
| `base_seo`        | SEO tools (metatag, sitemap, redirects, robots.txt)         |
| `base_theme`      | Scaffolds custom frontend theme with Tailwind CSS           |
| `base_paragraphs` | Paragraphs and structured content                           |
| `base_finish`     | Final production features (cookies, security, etc.)         |

---

## ⚙️ Requirements

- Docker
- DDEV
- PHP 8.3+
- Composer
- Node.js 18+

---

## 🛠️ Setup

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd <project-folder>
```

### 2. Start DDEV

```bash
ddev start
```

### 3. Install dependencies

```bash
ddev composer install
```

---

## 🚀 Fresh Install

### PT-BR only

```bash
ddev drush sql-drop -y
ddev drush si standard -y
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_pt_br
ddev drush recipe ../recipes/base_seo
ddev drush locale-update --langcode=pt-br
ddev drush recipe ../recipes/base_theme
ddev theme-install
ddev theme-build
ddev drush cr
ddev drush uli
```

### ES only

```bash
ddev drush sql-drop -y
ddev drush si standard -y
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_es
ddev drush recipe ../recipes/base_seo
ddev drush locale-update --langcode=es
ddev drush recipe ../recipes/base_theme
ddev theme-install
ddev theme-build
ddev drush cr
ddev drush uli
```

### Multilingual (PT-BR + ES + EN)

```bash
ddev drush sql-drop -y
ddev drush si standard -y
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_seo
ddev drush locale-update --langcode=pt-br
ddev drush locale-update --langcode=es
ddev drush recipe ../recipes/base_theme
ddev theme-install
ddev theme-build
ddev drush cr
ddev drush uli
```

---

## 🔁 Development Workflow

### After every `git pull` or branch change

```bash
ddev local-update
```

This command handles everything: dependency install, database updates, config import, frontend build, and cache rebuild.

### Frontend development

| Command              | Description                        |
| -------------------- | ---------------------------------- |
| `ddev theme-watch`   | Watch mode — rebuilds on file save |
| `ddev theme-dev`     | Single dev build (no minification) |
| `ddev theme-build`   | Production build (minified)        |
| `ddev theme-install` | Install npm dependencies           |

### Other useful commands

```bash
# Export configuration
ddev drush cex

# Rebuild cache
ddev drush cr

# Update translations
ddev drush locale-update --langcode=pt-br
ddev drush locale-update --langcode=es

# Reset and reinstall from scratch
ddev drush sql-drop -y && ddev drush si standard -y
```

---

## 🧩 Applying Recipes Individually

```bash
ddev drush recipe ../recipes/base_core
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_seo
ddev drush recipe ../recipes/base_theme
ddev drush recipe ../recipes/base_paragraphs
ddev drush recipe ../recipes/base_finish
```

> ⚠️ `simple_sitemap` must be installed before `base_seo`:
>
> ```bash
> ddev drush en simple_sitemap -y
> ddev drush recipe ../recipes/base_seo
> ```

---

## 📦 Frontend (Theme)

The custom theme is located in:

```
web/themes/custom/front_theme/
```

Stack: Tailwind CSS v3, SCSS, esbuild, PostCSS.

```bash
# Install dependencies
ddev theme-install

# Development build
ddev theme-dev

# Watch mode
ddev theme-watch

# Production build
ddev theme-build
```

---

## 🔄 DDEV Custom Commands

| Command              | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| `ddev local-update`  | Full local update: deps, db, config, build, cache, login URL |
| `ddev theme-install` | Install npm dependencies inside the theme                    |
| `ddev theme-build`   | Production frontend build                                    |
| `ddev theme-dev`     | Development frontend build                                   |
| `ddev theme-watch`   | Watch mode for frontend development                          |

---

## ⚠️ Notes

- Recipes should be **independent and reusable**
- Avoid exporting unnecessary configuration
- Always test recipes on a **fresh Drupal install**
- Some contributed modules may not yet fully support Drupal 11
- `simple_sitemap` must be installed separately before `base_seo` due to entity initialization timing
- `locale-update` requires internet access to fetch `.po` files from drupal.org

---

## 📌 Roadmap

- [x] Base admin recipe (Gin theme)
- [x] Base i18n recipe (multilingual infrastructure)
- [x] Base SEO recipe (metatag, sitemap, redirects)
- [x] Base theme recipe (Tailwind scaffold)
- [ ] Base paragraphs recipe
- [ ] Base finish recipe
- [ ] Feature recipes (blog, courses, landing pages)
- [ ] Improve frontend tooling

---

## 🤝 Contributing

Feel free to open issues or submit pull requests to improve the base recipes and structure.

---

## 📄 License

MIT License
