# Omni Pulse

Omni Pulse is a monolithic Rails 8 app that fuses:

* **Hotwire UI** – snappy SPA-like UX.
* **JSON API** – `/api/v1/*` endpoints for automation.
* **LLM adapters** – OpenAI/Dhan integrations (to be added).

## Getting Started

```bash
cp .env.example .env
bin/setup      # loads DB, seeds, installs hooks
bin/dev        # runs foreman with CSS & JS watchers