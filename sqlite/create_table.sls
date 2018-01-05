{{ sqlite.table_name }}:
  sqlite3.table_present:
    - db: {{ sqlite.db.location }}
    - schema: {{ sqlite.sql_statement }}
