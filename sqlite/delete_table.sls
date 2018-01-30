{% from "sqlite/map.jinja" import sqlite with context %}

'{{ sqlite.table_name }}':
  sqlite3.table_absent:
    - db: '{{ sqlite.db_location }}/{{ sqlite.db_file }}'
