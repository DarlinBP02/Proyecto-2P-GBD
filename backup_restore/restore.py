# restore.py
import os
import subprocess
from tkinter import Tk, filedialog
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def restore_database(backup_file):
    # Construye el comando psql correctamente
    restore_command = [
        "psql",
        "-U", DB_USER,
        "-d", DB_NAME,
        "-f", backup_file
    ]

    # Ejecuta el comando psql con la contraseña como entrada
    subprocess.run(restore_command, input=DB_PASSWORD.encode('utf-8'), check=True)

if __name__ == "__main__":
    root = Tk()
    root.withdraw()  # Ocultar la ventana principal
    backup_file = filedialog.askopenfilename(filetypes=[("Archivos SQL", "*.sql")])
    root.destroy()  # Cerrar la ventana después de seleccionar el archivo

    if not backup_file:
        print("No se seleccionó ningún archivo de respaldo.")
    else:
        restore_database(backup_file)
