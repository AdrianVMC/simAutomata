# simautomata/main.py

import flet as ft
from simautomata import saludar

def main(page: ft.Page):
    page.title = "simAutomata - Inicio"
    page.theme_mode = ft.ThemeMode.LIGHT
    page.vertical_alignment = ft.MainAxisAlignment.CENTER

    nombre_input = ft.TextField(label="Escribe tu nombre")
    saludo_text = ft.Text()
    
    def saludar_click(e):
        saludo_text.value = saludar(nombre_input.value)
        page.update()

    page.add(
        nombre_input,
        ft.ElevatedButton("Saludar", on_click=saludar_click),
        saludo_text
    )

# Ejecutar como app Flet
if __name__ == "__main__":
    ft.app(target=main)
