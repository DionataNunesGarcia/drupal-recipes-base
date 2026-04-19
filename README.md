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
  base_seo/
  base_paragraphs/
  base_theme/
  base_finish/
```

### Recipe Overview

| Recipe            | Responsibility                                      |
| ----------------- | --------------------------------------------------- |
| `base_core`       | Core Drupal setup (content, media, views, etc.)     |
| `base_admin`      | Admin UI and developer experience                   |
| `base_seo`        | SEO tools (metatag, sitemap, redirects)             |
| `base_paragraphs` | Paragraphs and structured content                   |
| `base_theme`      | Theme setup and frontend pipeline                   |
| `base_finish`     | Final production features (cookies, security, etc.) |

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

---

### 2. Start DDEV

```bash
ddev start
```

---

### 3. Install dependencies

```bash
ddev composer install
```

---

### 4. Install Drupal

```bash
ddev drush si minimal -y
```

---

### 5. Access the project

```bash
ddev launch
```

---

## 🧩 Using Recipes

Apply recipes individually depending on your project needs:

```bash
ddev drush recipe web/recipes/base_core
ddev drush recipe web/recipes/base_admin
ddev drush recipe web/recipes/base_seo
ddev drush recipe web/recipes/base_paragraphs
ddev drush recipe web/recipes/base_theme
ddev drush recipe web/recipes/base_finish
```

---

## 🔁 Development Workflow

### Export configuration

```bash
ddev drush cex
```

---

### Test from scratch (recommended)

```bash
ddev drush si -y
ddev drush recipe web/recipes/base_core
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
- Some contributed modules may not yet support Drupal 11

---

## 📌 Roadmap

- [ ] Create base recipes
- [ ] Extract reusable configurations
- [ ] Add feature recipes (blog, courses, pages)
- [ ] Improve frontend tooling

---

## 🤝 Contributing

Feel free to open issues or submit pull requests to improve the base recipes and structure.

---

## 📄 License

MIT License
