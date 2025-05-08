import flet as ft

def main(page: ft.Page):
    # Configuración mínima de la página
    page.title = "App Sencilla"
    page.vertical_alignment = "center"
    page.horizontal_alignment = "center"
    
    # Componentes
    texto = ft.Text("Haz clic en el botón:", size=20)
    boton = ft.ElevatedButton("Saludar", on_click=lambda e: saludar())
    mensaje = ft.Text(size=24, color="green")  # Aquí aparecerá el saludo

    # Función para el botón
    def saludar():
        mensaje.value = "¡Hola, Flet!"
        page.update()  # Actualiza la pantalla

    # Agregar todo a la página
    page.add(
        ft.Column([texto, boton, mensaje], 
        alignment="center",
        horizontal_alignment="center")
    )

ft.app(target=main)