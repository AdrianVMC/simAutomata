# tests/test_saludar.py

from simautomata import saludar

def test_saludar():
    assert saludar("Carlos") == "Hola, Carlos"