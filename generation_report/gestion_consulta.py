# consulta_reportes/gestion_consulta.py
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD
from reportlab.lib import colors
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle

def obtener_conexion():
    return psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)

def listar_entidades():
    try:
        conn = obtener_conexion()
        cur = conn.cursor()
        cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';")
        entidades = cur.fetchall()
        cur.close()
        conn.close()
        return [entidad[0] for entidad in entidades]
    except Exception as e:
        print("Error al listar entidades:", e)
        return []

def listar_atributos(entidad):
    try:
        conn = obtener_conexion()
        cur = conn.cursor()
        cur.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name = '{entidad}';")
        atributos = cur.fetchall()
        cur.close()
        conn.close()
        return [atributo[0] for atributo in atributos]
    except Exception as e:
        print(f"Error al listar atributos de la entidad {entidad}:", e)
        return []

def generar_reporte_pdf(titulo, columnas, datos):
    filename = f"{titulo}_reporte.pdf"
    doc = SimpleDocTemplate(filename, pagesize=letter)
    table_data = [columnas] + datos

    table_style = TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
        ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
        ('GRID', (0, 0), (-1, -1), 1, colors.black)
    ])

    table = Table(table_data)
    table.setStyle(table_style)
    doc.build([table])
    print("El reporte se ha generado correctamente en", filename)

def obtener_datos_atributos(entidades_atributos):
    try:
        conn = obtener_conexion()
        cur = conn.cursor()
        
        columnas = []
        datos = []

        # Generar el select clause y unificar los resultados
        for entidad, atributos in entidades_atributos.items():
            select_clause = ', '.join(atributos)
            query = f"SELECT {select_clause} FROM {entidad};"
            cur.execute(query)
            resultados = cur.fetchall()

            if not columnas:
                columnas.extend(atributos)
            else:
                for atributo in atributos:
                    if atributo not in columnas:
                        columnas.append(atributo)

            for fila in resultados:
                fila_ordenada = [None] * len(columnas)
                for idx, atributo in enumerate(atributos):
                    columna_idx = columnas.index(atributo)
                    fila_ordenada[columna_idx] = fila[idx]
                datos.append(fila_ordenada)

        cur.close()
        conn.close()

        # Asegurarse de que todas las filas tengan el mismo número de columnas
        for i in range(len(datos)):
            if len(datos[i]) < len(columnas):
                datos[i].extend([None] * (len(columnas) - len(datos[i])))

        return columnas, datos
    except Exception as e:
        print(f"Error al obtener datos de las entidades:", e)
        return [], []
