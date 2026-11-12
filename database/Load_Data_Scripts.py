
import os
import sys
import psycopg2
from psycopg2 import sql
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

sys.stdout.reconfigure(encoding="utf-8")

# ----------------------------------
# STEP 1: DATABASE CONFIGURATION
# ----------------------------------

DB_NAME = "Health_DataBase"

DB_CONFIG = {
    "host": "127.0.0.1",
    "port": 5432,
    "user": "postgres",
    "password": "123456789"
}

# ----------------------------------
# STEP 2: PROJECT PATHS
# ----------------------------------

base_dir = os.path.dirname(os.path.abspath(__file__))

sql_file = os.path.join(base_dir, "defining_tables.sql")

clean_dir = os.path.abspath(
    os.path.join(base_dir, "../data/outputs/")
)

# ----------------------------------
# STEP 3: CREATE DATABASE
# ----------------------------------

conn = psycopg2.connect(
    **DB_CONFIG,
    dbname="postgres"
)

conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

cur = conn.cursor()

cur.execute(
    "SELECT 1 FROM pg_database WHERE datname = %s",
    (DB_NAME,)
)

if cur.fetchone() is None:
    cur.execute(
        sql.SQL("CREATE DATABASE {}").format(
            sql.Identifier(DB_NAME)
        )
    )
    print(f"✅ Database {DB_NAME} created")

else:
    print(f"ℹ️ Database {DB_NAME} already exists")

cur.close()
conn.close()

# ----------------------------------
# STEP 4: CONNECT TO TARGET DATABASE
# ----------------------------------

conn = psycopg2.connect(
    **DB_CONFIG,
    dbname=DB_NAME
)

cur = conn.cursor()

# ----------------------------------
# STEP 5: CREATE TABLES
# ----------------------------------

if not os.path.exists(sql_file):
    raise FileNotFoundError(
        f"SQL file not found: {sql_file}"
    )

with open(sql_file, "r", encoding="utf-8") as f:
    create_table_sql = f.read()

try:
    cur.execute(create_table_sql)
    conn.commit()

    print("✅ All tables created successfully")

except Exception as e:
    conn.rollback()
    print(f"❌ Table creation failed: {e}")
    cur.close()
    conn.close()
    sys.exit(1)

# ----------------------------------
# STEP 6: CSV FILE MAPPING
# ----------------------------------

file_to_table = {
    "cleaned_DimPatient.csv": "dimpatient",
    "cleaned_DimPhysician.csv": "dimphysician",
    "cleaned_DimSpeciality.csv": "dimspeciality",
    "cleaned_DimHospital.csv": "dimhospital",
    "cleaned_DimPayer.csv": "dimpayer",
    "cleaned_DimCptCode.csv": "dimcptcode",
    "cleaned_DimDiagnosisCode.csv": "dimdiagnosiscode",
    "cleaned_DimDate.csv": "dimdate",
    "cleaned_DimTransaction.csv": "dimtransaction",
    "cleaned_FactTable.csv": "facttable"
}

# ----------------------------------
# STEP 7: LOAD CSV DATA
# ----------------------------------

for file, table in file_to_table.items():

    file_path = os.path.join(clean_dir, file)

    print(f"\n🔎 Loading: {file}")

    if not os.path.exists(file_path):
        print(f"❌ File not found: {file_path}")
        continue

    try:
        with open(file_path, "r", encoding="utf-8-sig") as f:

            copy_query = sql.SQL(
                "COPY public.{} FROM STDIN WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',')"
            ).format(sql.Identifier(table))

            cur.copy_expert(copy_query.as_string(conn), f)

        conn.commit()

        print(f"✅ Successfully loaded into {table}")

    except Exception as e:

        conn.rollback()

        print(f"❌ Error loading {table}: {e}")

# ----------------------------------
# STEP 8: VERIFY RECORD COUNTS
# ----------------------------------

print("\n📊 DATABASE RECORD COUNTS")

for table in file_to_table.values():

    cur.execute(
        sql.SQL("SELECT COUNT(*) FROM public.{}").format(
            sql.Identifier(table)
        )
    )

    count = cur.fetchone()[0]

    print(f"{table}: {count} records")

# ----------------------------------
# STEP 9: CLOSE CONNECTION
# ----------------------------------

cur.close()
conn.close()

print("\n🚀 DATABASE SETUP AND DATA LOADING COMPLETED!")
