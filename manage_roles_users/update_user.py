# manage_roles_users/update_user.py
import psycopg2
import tkinter as tk
from tkinter import messagebox
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def update_user(username, new_password):
    try:
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        cur = conn.cursor()
        cur.execute(f"ALTER ROLE {username} WITH PASSWORD '{new_password}';")
        conn.commit()
        cur.close()
        conn.close()
        messagebox.showinfo("Éxito", "¡Usuario actualizado correctamente!")
    except psycopg2.Error as e:
        messagebox.showerror("Error", f"Error al actualizar el usuario: {e}")

if __name__ == "__main__":
    username = input("Ingrese el nombre del usuario: ")
    new_password = input("Ingrese la nueva contraseña del usuario: ")
    update_user(username, new_password)
