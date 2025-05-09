.PHONY: run dev build clean install docker-build docker-run docker-run-gui docker-push docker-clean help

# Variables
VENV = venv
PYTHON = $(VENV)/bin/python
APP = main.py
DOCKER_IMAGE = simautomata
DOCKER_REGISTRY = tu-registro
PORT = 8550
DATE_TAG = $(shell date +%Y%m%d)

# -------------------------
# Local development targets
# -------------------------

run: ## Ejecuta la aplicación con el entorno virtual
	@echo "▶ Running app..."
	@$(PYTHON) $(APP)

dev: ## Ejecuta la app en modo desarrollo con Flet
	@echo "🔥 Running dev mode..."
	@flet run $(APP) -d

build: ## Empaqueta la app con Flet
	@echo "📦 Creating app..."
	@$(PYTHON) -m flet pack $(APP) --name "simAutomata"

install: ## Instala las dependencias desde requirements.txt
	@echo "📌 Installing dependencies..."
	@$(PYTHON) -m pip install -r requirements.txt

clean: ## Limpia archivos temporales y el entorno virtual
	@echo "🧹 Cleaning..."
	@rm -rf __pycache__ .pytest_cache $(VENV)

# ---------------------
# Docker-related targets
# ---------------------

docker-build: ## Construye la imagen Docker
	@echo "🐳 Building Docker image..."
	@docker build \
		-t $(DOCKER_IMAGE):latest \
		-t $(DOCKER_IMAGE):$(DATE_TAG) \
		--label maintainer=$(DOCKER_IMAGE) .

docker-run: docker-build ## Ejecuta el contenedor en modo web
	@echo "🚀 Running container (web mode)..."
	@docker run -it --rm \
		-p $(PORT):$(PORT) \
		-e FLET_SERVER_PORT=$(PORT) \
		$(DOCKER_IMAGE):latest

docker-run-gui: ## Ejecuta el contenedor con soporte GUI (X11)
	@echo "🖥️  Running with GUI support..."
	@xhost +local:docker
	@docker run -it --rm \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		$(DOCKER_IMAGE):latest

docker-push: docker-build ## Empuja la imagen al registro Docker
	@echo "📤 Pushing to $(DOCKER_REGISTRY)..."
	@docker tag $(DOCKER_IMAGE):latest $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest
	@docker push $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest

docker-clean: ## Elimina recursos no utilizados de Docker
	@echo "🧼 Cleaning Docker artifacts..."
	@docker system prune -f --filter "label=maintainer=$(DOCKER_IMAGE)"

# ---------------
# Ayuda del Makefile
# ---------------

help: ## Muestra esta ayuda
	@echo "📘 Available targets:\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
