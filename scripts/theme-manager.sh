#!/bin/bash

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

CUSTOM_THEME_NAME=${CUSTOM_THEME_NAME:-front_theme}
BASE_THEME="front_theme"
THEME_PATH="web/themes/custom/$CUSTOM_THEME_NAME"
BASE_THEME_PATH="web/themes/custom/$BASE_THEME"

case "$1" in
  setup)
    echo "Setting up theme: $CUSTOM_THEME_NAME"
    if [ "$CUSTOM_THEME_NAME" != "$BASE_THEME" ] && [ -d "$BASE_THEME_PATH" ]; then
      echo "Renaming $BASE_THEME to $CUSTOM_THEME_NAME..."
      mv "$BASE_THEME_PATH" "$THEME_PATH"
      
      # Rename files
      find "$THEME_PATH" -name "*$BASE_THEME*" -exec bash -c 'mv "$1" "${1//'$BASE_THEME'/'$CUSTOM_THEME_NAME'}"' -- {} \;
      
      # Replace logic inside files
      grep -rl "$BASE_THEME" "$THEME_PATH" | xargs sed -i "s/$BASE_THEME/$CUSTOM_THEME_NAME/g"
    fi
    
    # Copy templates from base_lp recipe if they exist
    if [ -d "recipes/base_lp/templates" ]; then
      echo "Copying templates from base_lp recipe to $CUSTOM_THEME_NAME..."
      mkdir -p "$THEME_PATH/templates"
      cp -r recipes/base_lp/templates/* "$THEME_PATH/templates/"
    fi

    # Set as default theme in Drupal if drush is available
    if command -v drush &> /dev/null; then
      drush theme:install $CUSTOM_THEME_NAME -y
      drush config-set system.theme default $CUSTOM_THEME_NAME -y
    fi
    ;;
esac
