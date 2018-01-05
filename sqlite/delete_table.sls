'{{ sqlite.table_name }}':
  sqlite3.table_absent:
    - db: '{{ sqlite.db_location }}'
