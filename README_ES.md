# simAutomata

**simAutomata** es un simulador de autómatas desarrollado como parte de un proyecto de Teoría de la Computación. Permite visualizar y ejecutar autómatas de manera interactiva. Ideal para estudiantes, docentes o cualquier persona interesada en la computación teórica.

> 🐳 Recomendado: Ejecutar con **Docker** para evitar configuraciones locales.

---

## 🚀 Características

- Simulación de autómatas (finito determinista, no determinista, etc.)
- Interfaz interactiva con [Flet](https://flet.dev/)
- Modo desarrollo y empaquetado
- Compatible con Linux, macOS y Windows

---

## 📦 Requisitos

### Opción 1: Usar Docker (recomendado)

- [Docker](https://www.docker.com/get-started) instalado

### Opción 2: Instalar localmente

- [Python 3.10+](https://www.python.org/downloads/)
- Git
- Make (en Linux/macOS; en Windows puedes usar Git Bash)

---

## 🐳 Uso con Docker (recomendado)

Docker permite ejecutar la aplicación **sin necesidad de instalar Python, dependencias ni configurar nada localmente**. Solo necesitas tener Docker instalado.

### 1. Clonar el repositorio

```bash
git clone https://github.com/AdrianVMC/simAutomata.git
cd simAutomata
```

### 2. Construir el contenedor

```bash
make docker-build
```
```bash
make docker-run
```
Esto hará lo siguiente:
- Construirá una imagen Docker con todo lo necesario
- Iniciará la aplicación en el puerto `8550`

### 3. Acceder a la aplicación

Abre tu navegador y visita:

👉 [http://localhost:8550](http://localhost:8550)

### 4. Limpiar recursos (opcional)

```bash
make docker-clean
```

---

## 💻 Instalación local (con Python)

Si prefieres instalarlo localmente:

### 1. Clonar el repositorio

```bash
git clone https://github.com/AdrianVMC/simAutomata.git
cd simAutomata
```

### 2. Crear y activar entorno virtual

```bash
python -m venv venv

# Activar entorno virtual:
# En Linux/macOS:
source venv/bin/activate

# En Windows:
venv\Scripts\activate
```

### 3. Instalar dependencias

```bash
make install
```

### 4. Ejecutar la aplicación

```bash
make run
```

---

## 🔧 Modo desarrollo

Para correr en modo desarrollador con recarga interactiva:

```bash
make dev
```

---

## 📦 Empaquetar la app (Flet Desktop)

Para crear una versión de escritorio ejecutable:

```bash
make build
```

---

## 🧼 Otros comandos útiles

```bash
make clean           # Limpia archivos temporales y el entorno virtual
make docker-clean    # Limpia imágenes/recursos Docker no utilizados
make docker-push     # Sube la imagen a un registro (si aplica)
make help            # Lista todos los comandos disponibles
```

---

## ❓¿Problemas o dudas?

Asegúrate de:
- Tener Docker corriendo correctamente
- Usar el puerto `8550` libre (puedes cambiarlo en el Makefile)
- Tener conexión a internet si instalas dependencias

---

## 📄 Licencia

Este proyecto está bajo la licencia [MIT](LICENSE).
