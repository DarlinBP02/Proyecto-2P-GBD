import tkinter as tk
from tkinter import messagebox
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def delete_user(username):
    try:
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        cur = conn.cursor()
        cur.execute(f"DROP ROLE IF EXISTS {username};")
        conn.commit()
        cur.close()
        conn.close()
        messagebox.showinfo("Éxito", "Se ha eliminado el usuario correctamente.")
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo eliminar el usuario. Error: {str(e)}")

if __name__ == "__main__":
    username = input("Ingrese el nombre del usuario: ")
    delete_user(username)
