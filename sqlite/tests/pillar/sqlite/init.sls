sqlite:
  prefix: /usr/local
  tmpdir: /tmp/sqlite_tmp
  os: Linux
  uri: https://www.sqlite.org/2017
  archive_name: sqlite-autoconf-3210000.tar.gz
  archive_type: tar
  opts: -s -L
  hashsum: sha1=f56fe3407d8297fc0a68a058f4c9e6b77e83575c
  interval: 30
  retries: 2
  create_mode: True
  delete_mode: False
  table_name: 'users'
  db_location: '/tmp/users.db'
  sql_statement: "CREATE TABLE `users` (`username` TEXT COLLATE NOCASE UNIQUE NOT NULL, `password` BLOB NOT NULL, `salt` BLOB NOT NULL, `last_login` INT)"
