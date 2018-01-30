{% from "sqlite/map.jinja" import sqlite with context %}

{{ sqlite.table_name }}:
  sqlite3.table_present:
    - db: '{{ sqlite.db_location }}'
    - schema: '{{ sqlite.sql_statement }}'

verify-{{ sqlite.table_name }}:
  module.run:
    - name: sqlite3.modify
    - db: {{ sqlite.db_location }}
    - sql: "SELECT name FROM sqlite_master WHERE type='table' AND name='{{ sqlite.table_name }}'"
    - require:
      - sqlite3: {{ sqlite.table_name }}
