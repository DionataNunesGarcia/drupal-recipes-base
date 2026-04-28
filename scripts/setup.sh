#!/bin/bash
# Setup Script - Automates new project setup
# Usage: ./scripts/setup.sh [options]

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

PROJECT_NAME="${1:-drupal-recipes-base}"
RECIPE="${2:-standard}"

log_info() { echo -e "${GREEN}[SETUP]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check requirements
check_requirements() {
    log_info "Checking requirements..."
    
    if ! command -v ddev &> /dev/null; then
        log_error "DDEV not found. Install: https://ddev.com"
        exit 1
    fi
    
    if ! command -v docker &> /dev/null; then
        log_error "Docker not found."
        exit 1
    fi
    
    log_info "All requirements met!"
}

# Start DDEV
start_ddev() {
    log_info "Starting DDEV..."
    ddev start
    log_info "DDEV started!"
}

# Install dependencies
install_deps() {
    log_info "Installing dependencies..."
    ddev composer install
    log_info "Dependencies installed!"
}

# Install Drupal
install_drupal() {
    log_info "Installing Drupal ($RECIPE)..."
    ddev drush site:install "$RECIPE" -y
    log_info "Drupal installed!"
}

# Apply all recipes
apply_recipes() {
    log_info "Applying recipes..."
    
    local recipes=(
        "../recipes/base_admin"
        "../recipes/base_i18n"
        "../recipes/base_seo"
        "../recipes/base_theme"
        "../recipes/base_lp"
        "../recipes/base_ai"
    )
    
    for recipe in "${recipes[@]}"; do
        log_info "Applying $recipe..."
        ddev drush recipe "$recipe" 2>/dev/null || log_warn "$recipe failed, continuing..."
    done
    
    log_info "Recipes applied!"
}

# Setup theme
setup_theme() {
    log_info "Setting up theme..."
    ddev theme-install
    ddev theme-build
    log_info "Theme ready!"
}

# Final steps
final_steps() {
    log_info "Final setup..."
    ddev drush cr
    ddev drush uli
    log_info "Setup complete!"
}

# Show help
show_help() {
    echo "Usage: $0 [project_name] [recipe]"
    echo ""
    echo "Examples:"
    echo "  $0                        # Standard setup"
    echo "  $0 my-project            # Custom project name"
    echo "  $0 my-project minimal   # Minimal profile"
    echo ""
    echo "Available recipes in recipes/"
}

# Main
main() {
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        show_help
        exit 0
    fi
    
    log_info "Starting setup for: $PROJECT_NAME"
    
    check_requirements
    start_ddev
    install_deps
    install_drupal
    apply_recipes
    setup_theme
    final_steps
    
    log_info "🎉 All done! Access: https://$PROJECT_NAME.ddev.site"
}

main "$@"