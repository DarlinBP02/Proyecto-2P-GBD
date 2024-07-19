# generate_procedures/generate_procedures.py
import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

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
        cur.execute(f"SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '{entidad}';")
        atributos = cur.fetchall()
        cur.close()
        conn.close()
        return atributos
    except Exception as e:
        print(f"Error al listar atributos de la entidad {entidad}:", e)
        return []

def generar_procedimientos_crud():
    entidades = listar_entidades()
    if not entidades:
        print("No se encontraron entidades.")
        return

    try:
        conn = obtener_conexion()
        cur = conn.cursor()

        for entidad in entidades:
            atributos = listar_atributos(entidad)
            columnas = [col[0] for col in atributos]
            tipos = [col[1] for col in atributos]

            # Procedimiento para INSERT
            insert_function = f"""
            CREATE OR REPLACE FUNCTION insert_{entidad}({', '.join([f'{col} {tipo}' for col, tipo in zip(columnas, tipos)])}) RETURNS void AS $$
            BEGIN
                INSERT INTO {entidad} ({', '.join(columnas)}) VALUES ({', '.join([f'${i+1}' for i in range(len(columnas))])});
            END;
            $$ LANGUAGE plpgsql;
            """
            cur.execute(insert_function)

            # Procedimiento para SELECT
            select_function = f"""
            CREATE OR REPLACE FUNCTION select_{entidad}() RETURNS TABLE({', '.join([f'{col} {tipo}' for col, tipo in zip(columnas, tipos)])}) AS $$
            BEGIN
                RETURN QUERY SELECT {', '.join(columnas)} FROM {entidad};
            END;
            $$ LANGUAGE plpgsql;
            """
            cur.execute(select_function)

            # Procedimiento para UPDATE
            id_col = columnas[0]  # Suponiendo que la primera columna es la llave primaria
            update_function = f"""
            CREATE OR REPLACE FUNCTION update_{entidad}({', '.join([f'{col} {tipo}' for col, tipo in zip(columnas, tipos)])}) RETURNS void AS $$
            BEGIN
                UPDATE {entidad} SET {', '.join([f'{col} = ${i+2}' for i, col in enumerate(columnas[1:])])} WHERE {id_col} = $1;
            END;
            $$ LANGUAGE plpgsql;
            """
            cur.execute(update_function)

            # Procedimiento para DELETE
            delete_function = f"""
            CREATE OR REPLACE FUNCTION delete_{entidad}({id_col} {tipos[0]}) RETURNS void AS $$
            BEGIN
                DELETE FROM {entidad} WHERE {id_col} = $1;
            END;
            $$ LANGUAGE plpgsql;
            """
            cur.execute(delete_function)

        conn.commit()
        cur.close()
        conn.close()
        print("Procedimientos almacenados CRUD generados y ejecutados correctamente en la base de datos.")
    except Exception as e:
        print("Error al generar procedimientos almacenados:", e)

if __name__ == "__main__":
    generar_procedimientos_crud()
