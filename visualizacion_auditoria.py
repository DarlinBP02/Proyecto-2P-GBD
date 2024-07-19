import tkinter as tk
from tkinter import filedialog
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD
from generation_report.gestion_consulta import generar_reporte_pdf

def visualizar_logs_auditoria():
    root = tk.Tk()
    root.withdraw()  
    try:
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM auditoria")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        # Aquí se puede generar un reporte en PDF con los datos obtenidos
        columnas = [desc[0] for desc in cursor.description]
        generar_reporte_pdf("reporte_auditoria", columnas, rows)

        print("Consulta de auditoría realizada correctamente.")

    except Exception as e:
        print(f"Error al ejecutar consulta de auditoría: {str(e)}")

    root.destroy()  # Cerrar la ventana después de seleccionar el archivo

if __name__ == "__main__":
    visualizar_logs_auditoria()
