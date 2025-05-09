.PHONY: run dev build clean install docker-build docker-run docker-run-gui docker-push docker-clean help

VENV = venv
PYTHON = $(VENV)/bin/python
APP = main.py
DOCKER_IMAGE = simautomata
DOCKER_REGISTRY = tu-registro 
PORT = 8550

run:  
	@echo "▶ Running app..."
	@$(PYTHON) $(APP)

dev:  
	@echo "🔥 Running dev mode..."
	@$(PYTHON) -m flet run $(APP) -d

build:  
	@echo "📦 Creating app..."
	@$(PYTHON) -m flet pack $(APP) --name "MiApp"

install:  
	@echo "📌 Installing dependencies..."
	@$(PYTHON) -m pip install -r requirements.txt

clean:
	@echo "🧹 Cleaning..."
	@rm -rf __pycache__ .pytest_cache $(VENV)


docker-build:
	@echo "🐳 Building Docker image..."
	docker build \
		-t $(DOCKER_IMAGE):latest \
		-t $(DOCKER_IMAGE):$(shell date +%Y%m%d) \
		--label maintainer=$(DOCKER_IMAGE) \
		.

docker-run: docker-build
	@echo "🚀 Running container (web mode)..."
	docker run -it --rm \
		-p $(PORT):$(PORT) \
		-e FLET_SERVER_PORT=$(PORT) \
		$(DOCKER_IMAGE):latest

docker-run-gui:
	@echo "🖥️  Running with GUI support..."
	xhost +local:docker && \
	docker run -it --rm \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		$(DOCKER_IMAGE):latest

docker-push: docker-build
	@echo "📤 Pushing to $(DOCKER_REGISTRY)..."
	docker tag $(DOCKER_IMAGE):latest $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest
	docker push $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest

docker-clean: 
	@echo "🧼 Cleaning Docker artifacts..."
	docker system prune -f --filter "label=maintainer=$(DOCKER_IMAGE)"

help:
	@echo "Usage: make [target]\n"
	@echo "Local targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-z_-]+:.*?## / && !/docker-/ {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo "\nDocker targets:"
	@awk 'BEGIN {FS = ":.*?## "} /^docker-+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)