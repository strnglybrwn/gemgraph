# GemGraph

**GemGraph** is a research-driven AI synthesis tool combining a FastAPI backend and a Vite/React frontend. It enables agentic workflows over web and local documents, designed for experimentation with LLMs, semantic analysis, and modular pipeline orchestration.
(forked from https://github.com/google-gemini/gemini-fullstack-langgraph-quickstart and updated to clean up depencency installs, local LAN run)

---

## Features

- FastAPI REST API with auto-generated documentation
- Modular agent and graph reasoning pipeline  
- Vite + React + TypeScript frontend  
- Web and document ingestion workflows  
- Supports LLM-driven synthesis  

---

## Prerequisites

- Assumes macOS 12+ (tested on macOS Tahoe26)  
- Python 3.11+  
- Node.js 18+
- You will need to get a Gemini_API_Key and Langsmith_API_Key which should be updated in your .env at the root of the project 
- - GEMINI_API_KEY=<your_gemini_api_key>
- - LANGSMITH_API_KEY=<your_langsmith_api_key
- `make`, `pip`, and optionally `pipx`  

---

## Setup

```bash
git clone https://github.com/strnglybrwn/gemgraph.git
cd whereever you did the git clone to eg ~/projects/gemgraph
make help            # lists available actions in make
make install         # creates virtualenv and installs backend deps and asks for a friendly 
                     # name (uses localhost as default) if you're testing locally on machine 
                     # also prompts to optionally start the servers 
make start           # starts FastAPI backend
make stop            # stops all services cleanly and frees ports
make dev-frontend    # starts the frontend dev server (Vite)
make dev-backend     # starts the backend dev server (LangGraph + FastAPI)"
```
- Access API docs: [http://localhost:8000/docs](http://localhost:8000/docs)  
- Access app UI: [http://localhost:5173](http://localhost:5173)  
---

## Architecture

```
[React UI (Vite)] ← HTTP → [FastAPI REST API] ← LLMs, Graph Workflows, Ingestors
```

- **Backend**: `/backend`  
  - Ingestion, agent orchestration, APIs  
- **Frontend**: `/frontend`  
  - Query interface, result visualization  

---

## Development Workflow

- Add new services under `backend/services/`  
- Register endpoints in `backend/apis/`  
- Wire up frontend calls in `frontend/src/`  
- Run tests:

```bash
cd backend && make help to view test options
cd frontend && npm run to view runnable scripts 
```

---

## Troubleshooting

| Problem                          | Fix                                           |
|----------------------------------|-----------------------------------------------|
| `make install` fails             | Use Python 3.11+, check `pip`, `venv`         |
| 5173 UI not loading              | Ensure backend is up and CORS is allowed      |
| `thread.append` error in UI      | Validate response JSON format from backend in |
|                                  | browser console                               |

---

## Deployment

- Designed for LAN deployment via local homelab/server  
- Use static IP or Bonjour address (e.g. `http://server.local:5173` or `http://x.x.x.x:5173`)  
- At 'make install' step above you will be prompted for an external hostname, this is stored in the root of your project eg ~/projects/gemgraph/.env 
- Optionally configure nginx or Caddy as reverse proxy  

---

## License

Licensed under the [Apache-2.0 License](LICENSE).
