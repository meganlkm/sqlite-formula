{% from "sqlite/map.jinja" import sqlite with context %}

creates_db_location:
  file.directory:
    - names:
      - '{{ sqlite.db_location }}'
    - makedirs: True
    - require_in:
      - {{ sqlite.table_name }}

{{ sqlite.table_name }}:
  sqlite3.table_present:
    - db: '{{ sqlite.db_location }}/{{ sqlite.db_file }}'
    - schema: '{{ sqlite.sql_statement }}'

verify-{{ sqlite.table_name }}:
  module.run:
    - name: sqlite3.modify
    - db: '{{ sqlite.db_location }}/{{ sqlite.db_file }}'
    - sql: "SELECT name FROM sqlite_master WHERE type='table' AND name='{{ sqlite.table_name }}'"
    - require:
      - sqlite3: {{ sqlite.table_name }}
