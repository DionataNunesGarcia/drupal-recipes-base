# Code Style Guide

This project uses **tabs with 2 spaces width** for indentation.

## Configuration Files

- `.editorconfig` - Defines the code style for all editors
- `.prettierrc` - Prettier configuration (if applicable)

## Indentation Rules

- **Style**: Tab
- **Tab Width**: 2 spaces
- **Line Endings**: LF (Unix)
- **Charset**: UTF-8
- **Trailing Whitespace**: Trimmed on save
- **Final Newline**: Inserted on save

## Editor Setup

Most modern editors automatically read the `.editorconfig` file. If your editor doesn't support EditorConfig, you can install the plugin:

- **VS Code**: [EditorConfig for VS Code](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
- **JetBrains IDEs**: Built-in support
- **Vim**: `apt install editorconfig-vim`
- **Emacs**: `M-x package-install editorconfig`

## Applying to Existing Files

To apply the indentation style to existing files:

```bash
# Using Prettier (if configured)
npm run format

# Or manually reindent files in your editor
```

## Files with Different Indentation

- `composer.json`, `composer.lock`: 4 spaces (JSON standard)
