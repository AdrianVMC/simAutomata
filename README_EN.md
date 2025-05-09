# simAutomata

**simAutomata** is an automaton simulator developed as part of a Theory of Computation project. It allows users to visualize and run automata interactively — ideal for students, educators, or anyone interested in formal languages and automata theory.

> 🐳 Recommended: Run with **Docker** to avoid local setup.

---

## 🚀 Features

- Automaton simulation (deterministic, non-deterministic, etc.)
- Interactive interface using [Flet](https://flet.dev/)
- Development and packaging modes
- Compatible with Linux, macOS, and Windows

---

## 📦 Requirements

### Option 1: Use Docker (recommended)

- [Docker](https://www.docker.com/get-started) installed

### Option 2: Install locally

- [Python 3.10+](https://www.python.org/downloads/)
- Git
- Make (on Linux/macOS; on Windows, use Git Bash)

---

## 🐳 Using Docker (recommended)

Docker allows you to run the app **without installing Python or any dependencies**. Just install Docker and follow these steps:

### 1. Clone the repository

```bash
git clone https://github.com/AdrianVMC/simAutomata.git
cd simAutomata
```

### 2. Build and run the app

```bash
make docker-run
```
```bash
make docker-build
```

This will:
- Build a Docker image with all required dependencies
- Launch the app on port `8550`

### 3. Open the app

Open your browser and visit:

👉 [http://localhost:8550](http://localhost:8550)

### 4. Clean Docker resources (optional)

```bash
make docker-clean
```

---

## 💻 Local installation (with Python)

If you prefer to install it locally:

### 1. Clone the repository

```bash
git clone https://github.com/AdrianVMC/simAutomata.git
cd simAutomata
```

### 2. Create and activate a virtual environment

```bash
python -m venv venv

# Activate the virtual environment:
# On Linux/macOS:
source venv/bin/activate

# On Windows:
venv\Scripts\activate
```

### 3. Install dependencies

```bash
make install
```

### 4. Run the app

```bash
make run
```

---

## 🔧 Development mode

To run the app in development mode with live reload:

```bash
make dev
```

---

## 📦 Package the app (Flet Desktop)

To create a standalone desktop version:

```bash
make build
```

---

## 🧼 Other useful commands

```bash
make clean           # Remove temp files and virtual environment
make docker-clean    # Remove unused Docker resources
make docker-push     # Push the image to a Docker registry (if needed)
make help            # Show all available commands
```

---

## ❓Troubleshooting

Make sure:
- Docker is running correctly on your system
- Port `8550` is available (you can change it in the Makefile)
- You have an internet connection if installing locally

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
