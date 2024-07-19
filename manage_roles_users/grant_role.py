# manage_roles_users/grant_role.py
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def grant_role(username, role_name):
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
    cur = conn.cursor()
    cur.execute(f"GRANT {role_name} TO {username};")
    conn.commit()
    cur.close()
    conn.close()

if __name__ == "__main__":
    username = input("Ingrese el nombre del usuario: ")
    role_name = input("Ingrese el nombre del rol: ")
    grant_role(username, role_name)
