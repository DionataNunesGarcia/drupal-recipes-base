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
  base_paragraphs/
  base_theme/
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
| `base_paragraphs` | Paragraphs and structured content                           |
| `base_theme`      | Theme setup and frontend pipeline                           |
| `base_finish`     | Final production features (cookies, security, etc.)         |

---

## ⚙️ Requirements

- Docker
- DDEV
- PHP 8.3+
- Composer

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

## 🚀 Quick Start

### Multilingual (PT-BR + ES + EN)

```bash
ddev drush sql-drop -y
ddev drush si standard -y
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_seo
ddev drush locale-update --langcode=pt-br
ddev drush locale-update --langcode=es
ddev drush cr
ddev drush uli
```

### Single language — PT-BR only

```bash
ddev drush sql-drop -y
ddev drush si standard -y
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_pt_br
ddev drush recipe ../recipes/base_seo
ddev drush locale-update --langcode=pt-br
ddev drush cr
ddev drush uli
```

### Single language — ES only

```bash
ddev drush sql-drop -y
ddev drush si standard -y
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_es
ddev drush recipe ../recipes/base_seo
ddev drush locale-update --langcode=es
ddev drush cr
ddev drush uli
```

---

## 🧩 Using Recipes

Apply recipes individually depending on your project needs:

```bash
ddev drush recipe ../recipes/base_core
ddev drush recipe ../recipes/base_admin
ddev drush recipe ../recipes/base_i18n
ddev drush recipe ../recipes/base_seo
ddev drush recipe ../recipes/base_paragraphs
ddev drush recipe ../recipes/base_theme
ddev drush recipe ../recipes/base_finish
```

> ⚠️ `simple_sitemap` must be installed before applying `base_seo`:
>
> ```bash
> ddev drush en simple_sitemap -y
> ddev drush recipe ../recipes/base_seo
> ```

---

## 🔁 Development Workflow

### Reset and reinstall from scratch

```bash
ddev drush sql-drop -y && ddev drush si standard -y
```

### Export configuration

```bash
ddev drush cex
```

### Rebuild cache

```bash
ddev drush cr
```

### Update translations

```bash
ddev drush locale-update --langcode=pt-br
ddev drush locale-update --langcode=es
```

---

## 📦 Frontend (Theme)

The custom theme is located in:

```
web/themes/custom/
```

Typical setup includes:

- Tailwind CSS
- PostCSS
- SCSS (optional)

Install dependencies inside the theme folder:

```bash
npm install
```

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
- [ ] Base paragraphs recipe
- [ ] Base theme recipe
- [ ] Base finish recipe
- [ ] Feature recipes (blog, courses, landing pages)
- [ ] Improve frontend tooling

---

## 🤝 Contributing

Feel free to open issues or submit pull requests to improve the base recipes and structure.

---

## 📄 License

MIT License
