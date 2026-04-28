#!/bin/bash
# AI Development Helper Scripts
# Place in scripts/ai.sh or use directly

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Project root (assumes script is in project root)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check DDEV
check_ddev() {
    if ! command -v ddev &> /dev/null; then
        log_error "DDEV not found. Install from https://ddev.com"
        exit 1
    fi
}

# Generate module
ai_generate_module() {
    local NAME="$1"
    if [ -z "$NAME" ]; then
        echo "Usage: $0 generate-module <module_name>"
        exit 1
    fi
    
    log_info "Creating module: $NAME"
    
    mkdir -p "$PROJECT_ROOT/web/modules/custom/$NAME/src/Controller"
    mkdir -p "$PROJECT_ROOT/web/modules/custom/$NAME/src/Form"
    mkdir -p "$PROJECT_ROOT/web/modules/custom/$NAME/src/Service"
    
    cat > "$PROJECT_ROOT/web/modules/custom/$NAME/${NAME}.info.yml" <<EOF
name: $(echo $NAME | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g')
description: 'Custom module created via AI'
core_version_requirement: ^10 || ^11
type: module
package: Custom
version: 1.0.0
EOF

    touch "$PROJECT_ROOT/web/modules/custom/$NAME/${NAME}.module"
    touch "$PROJECT_ROOT/web/modules/custom/$NAME/${NAME}.routing.yml"
    touch "$PROJECT_ROOT/web/modules/custom/$NAME/${NAME}.services.yml"
    
    log_info "Module created: web/modules/custom/$NAME/"
    log_info "Run: ddev drush en $NAME"
}

# Debug project
ai_debug() {
    log_info "Running debug diagnostics..."
    echo ""
    
    echo "=== Cache ==="
    cd "$PROJECT_ROOT"
    ddev drush cr
    echo ""
    
    echo "=== Routes (top 20) ==="
    ddev drush core:route | head -20
    echo ""
    
    echo "=== Enabled Modules ==="
    ddev drush pm:list --status=enabled | grep -E "^  .*AI" | head -10
    echo ""
    
    echo "=== Database Status ==="
    ddev drush core:status | grep -i "db"
    echo ""
    
    log_info "Debug complete!"
}

# Test AI
ai_test() {
    log_info "Testing AI..."
    
    cd "$PROJECT_ROOT"
    
    if ddev drush ai:chat "Say 'AI is working!' in exactly 3 words" --provider=openai 2>/dev/null; then
        log_info "OpenAI working!"
    elif ddev drush ai:chat "Say 'AI is working!' in exactly 3 words" --provider=ollama 2>/dev/null; then
        log_info "Ollama working!"
    else
        log_error "No AI provider configured"
        log_info "Run: ddev drush config-set ai.settings default_provider openai"
    fi
}

# Install AI
ai_install() {
    log_info "Installing AI..."
    
    cd "$PROJECT_ROOT"
    
    ddev drush recipe ../recipes/base_ai
    ddev drush recipe ../recipes/base_ai_contents
    
    log_info "AI recipes installed!"
}

# Show help
ai_help() {
    echo "AI Development Helper"
    echo ""
    echo "Usage: $0 <command> [args]"
    echo ""
    echo "Commands:"
    echo "  generate-module <name>   Create new module"
    echo "  debug                  Debug project"
    echo "  test                   Test AI connection"
    echo "  install                Install AI"
    echo "  help                   Show this help"
    echo ""
}

# Main
COMMAND="${1:-help}"

case "$COMMAND" in
    generate-module)
        check_ddev
        ai_generate_module "$2"
        ;;
    debug)
        check_ddev
        ai_debug
        ;;
    test)
        check_ddev
        ai_test
        ;;
    install)
        check_ddev
        ai_install
        ;;
    help|*)
        ai_help
        ;;
esac