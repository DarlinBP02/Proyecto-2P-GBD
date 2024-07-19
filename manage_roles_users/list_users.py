# manage_roles_users/list_users.py
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

def list_users():
    conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
    cur = conn.cursor()
    cur.execute("SELECT usename FROM pg_catalog.pg_user;")
    users = cur.fetchall()
    cur.close()
    conn.close()
    return users

if __name__ == "__main__":
    users = list_users()
    for user in users:
        print(user)
