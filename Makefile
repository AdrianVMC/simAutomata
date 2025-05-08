.PHONY: run dev build clean install

# Variables (personalizables)
VENV = venv
PYTHON = $(VENV)/bin/python
APP = main.py

# Tareas principales
run:  ## Ejecutar la aplicación normalmente
	@echo "▶ Iniciando aplicación..."
	@$(PYTHON) $(APP)

dev:  ## Modo desarrollo con hot reload
	@echo "🔥 Iniciando en modo desarrollo..."
	@$(PYTHON) -m flet run $(APP) -d

build:  ## Crear ejecutable (--name opcional)
	@echo "📦 Empaquetando aplicación..."
	@$(PYTHON) -m flet pack $(APP) --name "MiApp"

install:  ## Instalar dependencias
	@echo "📌 Instalando dependencias..."
	@$(PYTHON) -m pip install -r requirements.txt

clean:  ## Limpiar cachés y entorno virtual
	@echo "🧹 Limpiando proyecto..."
	@rm -rf __pycache__ .pytest_cache $(VENV)

help:  ## Mostrar ayuda
	@echo "Opciones disponibles:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)