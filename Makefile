.PHONY: run dev build clean install

# Variables (personalizables)
VENV = venv
PYTHON = $(VENV)/bin/python
APP = main.py

# Tareas principales
run:  ## Ejecutar la aplicación normalmente
	@echo "▶ Running app..."
	@$(PYTHON) $(APP)

dev:  ## Modo desarrollo con hot reload
	@echo "🔥 Running dev mode..."
	@$(PYTHON) -m flet run $(APP) -d

build:  ## Crear ejecutable (--name opcional)
	@echo "📦 Creating app..."
	@$(PYTHON) -m flet pack $(APP) --name "MiApp"

install:  ## Instalar dependencias
	@echo "📌 Installing dependencies..."
	@$(PYTHON) -m pip install -r requirements.txt

clean:  ## Limpiar cachés y entorno virtual
	@echo "🧹 Cleaning..."
	@rm -rf __pycache__ .pytest_cache $(VENV)

help:  ## Mostrar ayuda
	@echo "Options:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)