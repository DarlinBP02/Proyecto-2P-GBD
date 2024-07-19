import psycopg2
from config.config import DB_NAME, DB_USER, DB_PASSWORD

# Crear tabla de auditoría
def crear_tabla_auditoria():
    create_table_query = '''
    CREATE TABLE IF NOT EXISTS Auditoria (
        ID SERIAL PRIMARY KEY,
        Tabla VARCHAR(50) NOT NULL,
        Fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        Usuario VARCHAR(50) NOT NULL,
        Accion VARCHAR(50) NOT NULL,
        Detalle JSONB  NULL
    );
    '''
    try:
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        cursor = conn.cursor()
        cursor.execute(create_table_query)
        conn.commit()
        cursor.close()
        conn.close()
        print("Tabla de auditoría creada correctamente.")
    except Exception as e:
        print(f"Error al crear la tabla de auditoría: {str(e)}")

# Generar disparadores de auditoría para una entidad
def generar_disparadores(entidad, atributos):
    triggers = []
    trigger_template = '''
    CREATE OR REPLACE FUNCTION audit_{table}_{action}() RETURNS trigger AS $$
    BEGIN
        INSERT INTO Auditoria (Tabla, Usuario, Accion, Detalle)
        VALUES ('{table}', current_user, '{action}', row_to_json(NEW)::jsonb);
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;

    CREATE TRIGGER {table}_{action}_trigger
    AFTER {action_upper} ON {table}
    FOR EACH ROW EXECUTE FUNCTION audit_{table}_{action}();
    '''

    actions = ['insert', 'update', 'delete']
    for action in actions:
        trigger_sql = trigger_template.format(
            table=entidad,
            action=action,
            action_upper=action.upper()
        )
        triggers.append(trigger_sql)
    
    return triggers

# Guardar los disparadores en archivos .sql
def generar_archivos_disparadores(entidades):
    for entidad, atributos in entidades.items():
        triggers = generar_disparadores(entidad, atributos)
        file_path = f"triggers_{entidad}.sql"
        try:
            with open(file_path, 'w') as file:
                file.write('\n'.join(triggers))
            print(f"Disparadores para la entidad {entidad} generados en {file_path}.")
        except Exception as e:
            print(f"Error al guardar los disparadores para {entidad}: {str(e)}")

# Función para listar entidades y sus atributos
def listar_entidades_y_atributos():
    entidades = {}
    try:
        conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        cursor = conn.cursor()
        cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';")
        tablas = cursor.fetchall()
        
        for tabla in tablas:
            cursor.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name = '{tabla[0]}';")
            columnas = cursor.fetchall()
            entidades[tabla[0]] = [col[0] for col in columnas]
        
        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Error al listar entidades y atributos: {str(e)}")
    
    return entidades
