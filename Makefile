.PHONY: run dev build clean full-clean install test \
        docker-build docker-run docker-run-detached docker-run-gui \
        docker-logs docker-stop docker-push docker-clean

# ---------------------
# Variables
# ---------------------
VENV = venv
PYTHON = $(VENV)/bin/python
PYTHONPATH = src
APP = -m simautomata.main
DOCKER_IMAGE = simautomata
DOCKER_REGISTRY = tu-registro
PORT = 8550
DATE_TAG = $(shell date +%Y%m%d)

# -------------------------
# Targets Local Dev
# -------------------------

run: ## Ejecuta la aplicación con el entorno virtual
	@echo "▶ Running app..."
	@PYTHONPATH=$(PYTHONPATH) $(PYTHON) $(APP)

dev: ## Ejecuta la app en modo desarrollo con Flet
	@echo "🔥 Running dev mode..."
	@PYTHONPATH=$(PYTHONPATH) flet run src/simautomata/main.py -d

build: ## Empaqueta la app con Flet Desktop
	@echo "📦 Creating app..."
	@PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m flet pack src/simautomata/main.py --name "simAutomata"

install: ## Instala las dependencias desde requirements.txt
	@echo "📌 Installing dependencies..."
	@$(PYTHON) -m pip install -r requirements.txt

test: ## Ejecuta los tests con pytest
	@echo "🧪 Running tests..."
	@PYTHONPATH=$(PYTHONPATH) $(PYTHON) -m pytest tests

clean: ## Limpia archivos temporales, cache de pruebas
	@echo "🧹 Cleaning project..."
	@rm -rf __pycache__ .pytest_cache .mypy_cache .cache

full-clean: clean ## Limpia también el entorno virtual
	@echo "💣 Removing virtual environment..."
	@rm -rf $(VENV)

# ---------------------
# Docker-related targets
# ---------------------

docker-build: ## Construye la imagen Docker con etiqueta por fecha y latest
	@echo "🐳 Building Docker image..."
	@docker build \
		-t $(DOCKER_IMAGE):latest \
		-t $(DOCKER_IMAGE):$(DATE_TAG) \
		--label maintainer=$(DOCKER_IMAGE) .

docker-run: docker-build ## Ejecuta el contenedor en modo interactivo (web mode)
	@echo "🚀 Running container interactively (web mode)..."
	@docker run -it --rm \
		-p $(PORT):$(PORT) \
		-e FLET_SERVER_PORT=$(PORT) \
		$(DOCKER_IMAGE):latest

docker-run-detached: docker-build ## Ejecuta el contenedor en background
	@echo "🛰 Running container in detached mode..."
	@docker rm -f simautomata_app 2>/dev/null || true
	@docker run -d \
		--name simautomata_app \
		-p $(PORT):$(PORT) \
		-e FLET_SERVER_PORT=$(PORT) \
		$(DOCKER_IMAGE):latest

docker-run-gui: docker-build ## Ejecuta el contenedor con soporte GUI (X11, Linux)
	@echo "🖥️  Running container with GUI support..."
	@xhost +local:docker
	@docker run -it --rm \
		-e DISPLAY=$(DISPLAY) \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		$(DOCKER_IMAGE):latest

docker-logs: ## Muestra los logs del contenedor simautomata_app
	@docker logs -f simautomata_app

docker-stop: ## Detiene el contenedor simautomata_app
	@docker stop simautomata_app

docker-push: docker-build ## Empuja la imagen al registro configurado
	@echo "📤 Pushing image to $(DOCKER_REGISTRY)..."
	@docker tag $(DOCKER_IMAGE):latest $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest
	@docker push $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):latest

docker-clean: ## Limpia contenedores e imágenes relacionadas con el proyecto
	@echo "🧹 Cleaning Docker artifacts..."
	-docker stop simautomata_app 2>/dev/null || true
	-docker rm simautomata_app 2>/dev/null || true
	-docker rmi $(DOCKER_IMAGE) 2>/dev/null || true
	docker system prune -f --filter "label=maintainer=$(DOCKER_IMAGE)"

# ---------------------
# Ayuda
# ---------------------

help:
	@echo "📘 Available targets:\n"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
