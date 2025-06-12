install:
	python3 -m venv .venv && \
	source .venv/bin/activate && \
	pip install -U pip && \
	pip install -r requirements.txt

start-api:
	source .venv/bin/activate && \
	uvicorn app.main:app --reload

start-ui:
	cd ui && npm install && npm run dev