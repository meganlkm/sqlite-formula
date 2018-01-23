{% from "sqlite/map.jinja" import sqlite with context %}

'{{ sqlite.table_name }}':
  sqlite3.table_present:
    - db: '{{ sqlite.db_location }}'
    - schema: '{{ sqlite.sql_statement }}'
