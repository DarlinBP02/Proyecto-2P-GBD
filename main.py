import os
import tkinter as tk
from tkinter import filedialog
from manage_roles_users.create_role import create_role
from manage_roles_users.create_user import create_user
from manage_roles_users.delete_role import delete_role
from manage_roles_users.delete_user import delete_user
from manage_roles_users.grant_role import grant_role
from manage_roles_users.list_roles import list_roles
from manage_roles_users.list_users import list_users
from manage_roles_users.update_user import update_user
from backup_restore.backup import backup_database, select_backup_path
from backup_restore.restore import restore_database
from generation_report.gestion_consulta import listar_entidades, listar_atributos, generar_reporte_pdf, obtener_datos_atributos
from generate_procedures.generate_procedures import generar_procedimientos_crud # Importa la función
from visualizacion_auditoria import visualizar_logs_auditoria  # Importar función de auditoría
from generation_report.audit_triggers import crear_tabla_auditoria, generar_archivos_disparadores, listar_entidades_y_atributos


import threading
import time
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

# Función para ejecutar una consulta y mostrar los resultados y el tiempo de respuesta
def ejecutar_consulta(consulta):
    start_time = time.time()
    try:
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        cursor = conn.cursor()
        cursor.execute(consulta)
        rows = cursor.fetchall()  # Obtener resultados de la consulta
        conn.commit()
        cursor.close()
        conn.close()
        elapsed_time = time.time() - start_time
        print(f"\nConsulta '{consulta}' ejecutada en {elapsed_time:.4f} segundos:")
        for row in rows:
            print(row)  # Imprimir cada fila de resultados
    except Exception as e:
        print(f"Error al ejecutar consulta: {str(e)}")

# Función para ejecutar consultas en hilos
def comparar_consultas_con_hilos():
    consultas = []
    while True:
        consulta = input("Ingrese una consulta (o 'fin' para terminar): ")
        if consulta.lower() == 'fin':
            break
        consultas.append(consulta)

    threads = []
    for consulta in consultas:
        thread = threading.Thread(target=ejecutar_consulta, args=(consulta,))
        threads.append(thread)
        thread.start()

    # Esperar a que todos los hilos terminen
    for thread in threads:
        thread.join()

def select_restore_file():
    root = tk.Tk()
    root.withdraw()  # Ocultar la ventana principal
    backup_file = filedialog.askopenfilename(filetypes=[("Archivos SQL", "*.sql")])
    root.destroy()  # Cerrar la ventana después de seleccionar el archivo
    return backup_file

def main():
    while True:
        print("\nMenú de Opciones:")
        print("1. Administrar Roles, Usuarios y Permisos")
        print("2. Respaldo y Restauración de Base de Datos")
        print("3. Gestión de Consulta y generación de reportes")
        print("4. Generación de procedimientos almacenados")
        print("5. Comparación de consultas aplicando hilos")  
        print("6. Generar disparadores de auditoría")
        print("7. Visualizador de eventos y auditoría (Logs)")
        print("8. Salir")

        opcion = input("Ingrese una opción: ")

        if opcion == "1":
            print("\nAdministrar Roles, Usuarios y Permisos:")
            print("1. Crear usuario")
            print("2. Crear rol")
            print("3. Listar usuarios")
            print("4. Listar roles")
            print("5. Eliminar usuario")
            print("6. Eliminar rol")
            print("7. Conceder rol a usuario")
            print("8. Actualizar contraseña de usuario")
            sub_opcion = input("Ingrese una opción: ")
            if sub_opcion == "1":
                username = input("Ingrese el nombre del usuario: ")
                password = input("Ingrese la contraseña del usuario: ")
                create_user(username, password)
            elif sub_opcion == "2":
                role_name = input("Ingrese el nombre del rol: ")
                create_role(role_name)
            elif sub_opcion == "3":
                users = list_users()
                for user in users:
                    print(user)
            elif sub_opcion == "4":
                roles = list_roles()
                for role in roles:
                    print(role)
            elif sub_opcion == "5":
                username = input("Ingrese el nombre del usuario a eliminar: ")
                delete_user(username)
            elif sub_opcion == "6":
                role_name = input("Ingrese el nombre del rol a eliminar: ")
                delete_role(role_name)
            elif sub_opcion == "7":
                username = input("Ingrese el nombre del usuario: ")
                role_name = input("Ingrese el nombre del rol: ")
                grant_role(username, role_name)
            elif sub_opcion == "8":
                username = input("Ingrese el nombre del usuario: ")
                new_password = input("Ingrese la nueva contraseña del usuario: ")
                update_user(username, new_password)
            else:
                print("Opción no válida. Por favor, intente de nuevo.")

        elif opcion == "2":
            print("\nRespaldo y Restauración de Base de Datos:")
            print("1. Respaldar base de datos")
            print("2. Restaurar base de datos")
            sub_opcion = input("Ingrese una opción: ")
            if sub_opcion == "1":
                backup_file = select_backup_path()
                backup_database(backup_file)
            elif sub_opcion == "2":
                backup_file = select_restore_file()
                restore_database(backup_file)
            else:
                print("Opción no válida. Por favor, intente de nuevo.")

        elif opcion == "3":
            print("\nGestión de Consulta y generación de reportes:")
            print("1. Listar entidades")
            print("2. Listar atributos por entidad")
            print("3. Generar reporte en PDF seleccionando atributos de varias entidades")
            sub_opcion = input("Ingrese una opción: ")
            if sub_opcion == "1":
                entidades = listar_entidades()
                if entidades:
                    print("Entidades (tablas) en la base de datos:")
                    for entidad in entidades:
                        print(entidad)
                else:
                    print("No se encontraron entidades.")
            elif sub_opcion == "2":
                entidad = input("Ingrese el nombre de la entidad: ")
                atributos = listar_atributos(entidad)
                if atributos:
                    print(f"Atributos de la entidad {entidad}:")
                    for atributo in atributos:
                        print(atributo)
                else:
                    print(f"No se encontraron atributos para la entidad {entidad}.")
            elif sub_opcion == "3":
                entidades_atributos = {}
                while True:
                    entidad = input("Ingrese el nombre de la entidad (o 'fin' para terminar): ")
                    if entidad.lower() == 'fin':
                        break
                    atributos = listar_atributos(entidad)
                    if atributos:
                        print(f"Atributos de la entidad {entidad}:")
                        for atributo in atributos:
                            print(atributo)
                        atributos_seleccionados = input("Ingrese los atributos seleccionados separados por coma: ").split(',')
                        entidades_atributos[entidad] = [attr.strip() for attr in atributos_seleccionados]
                    else:
                        print(f"No se encontraron atributos para la entidad {entidad}.")
                if entidades_atributos:
                    columnas, datos = obtener_datos_atributos(entidades_atributos)
                    if datos:
                        generar_reporte_pdf("reporte", columnas, datos)
                    else:
                        print("No se encontraron datos para las entidades y atributos seleccionados.")
            else:
                print("Opción no válida. Por favor, intente de nuevo.")

        elif opcion == "4":
            print("\nGeneración de procedimientos almacenados:")
            print("1. Generar procedimientos almacenados CRUD")
            sub_opcion = input("Ingrese una opción: ")
            if sub_opcion == "1":
                generar_procedimientos_crud()
            else:
                print("Opción no válida. Por favor, intente de nuevo.")
                
        elif opcion == "5":
            comparar_consultas_con_hilos() 
            
        elif opcion == "6":
            # Generar disparadores de auditoría
            crear_tabla_auditoria()
            entidades = listar_entidades_y_atributos()
            generar_archivos_disparadores(entidades)
            
        elif opcion == "7":
            # Visualizador de eventos y auditoría (Logs)
            visualizar_logs_auditoria()        

        elif opcion == "8":
            print("Saliendo del programa...")
            break

        else:
            print("Opción no válida. Por favor, intente de nuevo.")

if __name__ == "__main__":
    main()
