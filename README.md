Case 1 : Windows config
# 1. Crear y activar venv
python -m venv venv
venv\Scripts\activate

# 2. Instalar dependencias
pip install -r requirements.txt

# 3. Docker (requiere Docker Desktop instalado)
docker build -t mi-app .
docker run -p 8550:8550 mi-app

# 4. Opciones GUI en Windows:
#    a) Usar modo web (http://localhost:8550)
#    b) Configurar WSL2 + XServer como VcXsrv:
#       - Instalar VcXsrv y ejecutar con configuración "Disable access control"
#       - En WSL2:
         export DISPLAY=$(awk '/nameserver / {print $2}' /etc/resolv.conf):0
         make docker-run-gui





aso 2: UNIX config
# 1. Clonar repositorio (o crear estructura)
git clone tu-repo.git && cd tu-repo

# 2. Configurar entorno (Linux/macOS)
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 3. Construir y ejecutar con Docker
docker build -t mi-app .
docker run -p 8550:8550 mi-app

# 4. Para desarrollo local con Makefile
make install
make dev






Caso 3: Desarrollo

# Activar entorno virtual (opcional pero recomendado)
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

# Ejecutar en modo desarrollo con hot-reload (Flet)
make dev

# O si prefieres Docker (con montado de volumen para cambios en caliente)
docker build -t mi-app .
docker run -it --rm -p 8550:8550 -v $(pwd):/app mi-app