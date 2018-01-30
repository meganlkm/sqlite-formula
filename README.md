# Sqlite

Formulas to set up sqlite3 on both Linux and Windows systems.

**Note:**
See the full Salt Formulas installation and usage instructions
<http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>.

**Assumptions:**
`make` is on your system and available. If it is not or you are not sure what
`make` is, [this](https://www.gnu.org/software/make/) is a good place to start.

## Testing

Change to `state` file location in checked out repository.

- cd sqlite-formula/sqlite

This is where the ***Makefile*** is located.

- run: `bash make`
- test results will return to your screen.

## Available states

### `sqlite`

Install sqlite3 from the source or a pre-compiled binary in the case of windows.

### `sqlite.create_table`

Creates a named table using a sql statement.

#### `required variables`

````
sqlite.table_name: string
    example: users
sqlite.db_location: string
    example: /var/www/data
sqlite.db_file: string
    example: app.sqlite
sqlite.sql_statement: string
    example:
      CREATE TABLE `users` (`username` TEXT COLLATE NOCASE UNIQUE NOT NULL, `password` BLOB NOT NULL, `salt` BLOB NOT NULL, `last_login` INT)
````

### `sqlite.delete_table`

Deletes a named table.

#### `required variables`

````
sqlite.table_name: string
    example: users
sqlite.db_location: string
    example: /var/www/data
sqlite.db_file: string
    example: app.sqlite
````

## Pillar customizations

Any of these values can be overwritten in a pillar file but most of the Windows
deviations are handled in the map.jinja file. If you do find yourself needing
more overrides follow the example below.

[pillar.example](sqlite/tests/pillar/sqlite/init.sls)
