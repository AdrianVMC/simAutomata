from simautomata import saludar

def test_saludo_nombre_valido():
    assert saludar("Ana") == "👋 Hola, Ana. Bienvenido al simulador de autómatas."

def test_saludo_vacio():
    assert saludar("") == "⚠️ Por favor, escribe tu nombre."
