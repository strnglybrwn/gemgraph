.PHONY: install start stop dev-frontend dev-backend help

# Set up Python virtual environment and install backend and frontend dependencies
install:
	@if [ ! -f .env ] || ! grep -q '^VITE_EXTERNAL_URL=' .env || [ -z "$$(grep '^VITE_EXTERNAL_URL=' .env | cut -d'=' -f2)" ]; then \
	echo "VITE_EXTERNAL_URL not set. Please enter the LAN hostname (e.g. jarvis.local):"; \
	read host; \
	sed -i '' '/^VITE_EXTERNAL_URL=/d' .env; \
	echo "VITE_EXTERNAL_URL=$$host" >> .env; \
	fi

	python3 -m venv .venv && \
	source .venv/bin/activate && \
	cd backend && pip install -e . && \
	cd ../frontend && npm install

	@read -p "Would you like to start the application server now? [Y/n] " answer; \
	if [ "$$answer" = "Y" ] || [ "$$answer" = "y" ] || [ -z "$$answer" ]; then \
		make start; \
	fi

# Start both backend and frontend concurrently
start:
	@echo "Starting both frontend and backend development servers..."
	set -a && source .env && set +a && @make dev-frontend & make dev-backend

stop:
	@echo "Stopping frontend and backend servers..."
	@pkill -f "npm run dev" || true
	@pkill -f "langgraph dev" || true

# Start just the frontend
dev-frontend:
	@echo "Starting frontend development server..."
	@cd frontend && npm run dev

# Start just the backend
dev-backend:
	@echo "Starting backend development server..."
	@bash -c "source .venv/bin/activate && cd backend && langgraph dev --host 0.0.0.0"

# Display available commands
help:
	@echo "Available commands:"
	@echo "  make install        - Set up virtualenv and install backend/frontend dependencies"
	@echo "  make start          - Start both frontend and backend dev servers in parallel"
	@echo "  make stop           - Stop both frontend and backend dev servers"
	@echo "  make dev-frontend   - Start the frontend dev server (Vite)"
	@echo "  make dev-backend    - Start the backend dev server (LangGraph + FastAPI)"