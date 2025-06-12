.PHONY: help install dev dev-frontend dev-backend

# Set up Python virtual environment and install backend and frontend dependencies
install:
	python3 -m venv .venv && \
	source .venv/bin/activate && \
	cd backend && pip install -e . && \
	cd ../frontend && npm install

# Start both backend and frontend concurrently
dev:
	@echo "Starting both frontend and backend development servers..."
	@make dev-frontend & make dev-backend

# Start just the frontend
dev-frontend:
	@echo "Starting frontend development server..."
	@cd frontend && npm run dev

# Start just the backend
dev-backend:
	@echo "Starting backend development server..."
	@cd backend && langgraph dev

# Display available commands
help:
	@echo "Available commands:"
	@echo "  make install        - Set up virtualenv and install backend/frontend dependencies"
	@echo "  make dev            - Start both frontend and backend dev servers in parallel"
	@echo "  make dev-frontend   - Start the frontend dev server (Vite)"
	@echo "  make dev-backend    - Start the backend dev server (LangGraph + FastAPI)"

#start-api:
#	bash -c "source .venv/bin/activate && uvicorn app.main:app --reload"

#start-ui:
#	cd ui && npm install && npm run dev