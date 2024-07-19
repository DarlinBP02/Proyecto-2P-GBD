import tkinter as tk
from tkinter import messagebox
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def create_user(username, password):
    try:
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        cur = conn.cursor()
        cur.execute(f"CREATE ROLE {username} WITH LOGIN PASSWORD '{password}';")
        conn.commit()
        cur.close()
        conn.close()
        messagebox.showinfo("Éxito", "Se ha creado el usuario correctamente.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo crear el usuario. Error: {str(e)}")

if __name__ == "__main__":
    username = input("Ingrese el nombre del usuario: ")
    password = input("Ingrese la contraseña del usuario: ")
    create_user(username, password)
