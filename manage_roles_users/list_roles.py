# manage_roles_users/list_roles.py
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def list_roles():
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
    cur = conn.cursor()
    cur.execute("SELECT rolname FROM pg_roles;")
    roles = cur.fetchall()
    cur.close()
    conn.close()
    return roles

if __name__ == "__main__":
    roles = list_roles()
    for role in roles:
        print(role)
