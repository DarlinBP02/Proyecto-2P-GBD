import tkinter as tk
from tkinter import messagebox
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def create_role(role_name):
    try:
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        cur = conn.cursor()
        cur.execute(f"CREATE ROLE {role_name};")
        conn.commit()
        cur.close()
        conn.close()
        messagebox.showinfo("Éxito", "Se ha creado el rol correctamente.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo crear el rol. Error: {str(e)}")

if __name__ == "__main__":
    role_name = input("Ingrese el nombre del rol: ")
    create_role(role_name)
