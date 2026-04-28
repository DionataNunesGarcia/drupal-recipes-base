# AI Context

## Available Providers

| Provider | Type | Endpoint | Cost |
|----------|------|----------|------|
| OpenAI | Cloud | api.openai.com | Paid |
| Ollama | Local | host.docker.internal:11434 | Free |

## Quick Commands

```bash
# Test AI
ddev drush ai:chat "Hello"

# List providers
ddev ai ai-providers

# Set default provider
ddev drush config-set ai.settings default_provider openai
ddev drush config-set ai.settings default_provider ollama
```

## AI Modules Installed

- `ai` - Core
- `ai_provider_openai` - OpenAI
- `ai_provider_ollama` - Ollama
- `ai_api_explorer` - Testing UI
- `ai_content_suggestions` - Content suggestions
- `ai_translate` - Translation
- `ai_vdb_provider_postgres` - Vector database

## Use Cases

1. **Content generation** - AI Content Suggestions
2. **Translation** - AI Translate
3. **Semantic search** - AI Search + pgvector