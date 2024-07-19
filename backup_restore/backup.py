# backup_restore/backup.py
import os
import subprocess
from tkinter import Tk, filedialog
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def backup_database(backup_file):
    pg_dump_path = r"C:\Program Files\PostgreSQL\14\bin\pg_dump.exe"
    with open(backup_file, 'w') as f:
        subprocess.run([pg_dump_path, '-U', DB_USER, '-d', DB_NAME], stdout=f)

def select_backup_path():
    root = Tk()
    root.withdraw()  # Ocultar la ventana principal
    backup_file = filedialog.asksaveasfilename(defaultextension=".sql", filetypes=[("Archivos SQL", "*.sql")])
    root.destroy()  # Cerrar la ventana después de seleccionar el archivo
    return backup_file
