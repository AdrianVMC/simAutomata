# simautomata/src/__init__.py

def saludar(nombre: str) -> str:
    if not nombre.strip():
        return "⚠️ Por favor, escribe tu nombre."
    return f"👋 Hola, {nombre}. Bienvenido al simulador de autómatas."
