sqlite:
  interval: 30
  retries: 2
  table_name: 'users'
  db_location: '/tmp/users.db'
  sql_statement: "CREATE TABLE `users` (`username` TEXT COLLATE NOCASE UNIQUE NOT NULL, `password` BLOB NOT NULL, `salt` BLOB NOT NULL, `last_login` INT)"
