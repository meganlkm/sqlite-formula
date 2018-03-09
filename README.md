[![Build Status](https://travis-ci.org/intuitivetechnologygroup/sqlite-formula.svg?branch=master)](https://travis-ci.org/intuitivetechnologygroup/sqlite-formula)

# Sqlite

Formulas to set up sqlite3 on both Linux and Windows systems.

* [Testing](#testing)
* [Available States](#states)
* [Pillar Customizations](#pillar)

---

**Note:**

See the full Salt Formulas installation and usage instructions
<http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>.


**Assumptions:**

`make` is on your system and available. If it is not or you are not sure what
`make` is, [this](https://www.gnu.org/software/make/) is a good place to start.


## <a name='testing'></a> Testing

### <a name='run-tests'></a> Run Tests

Tests will be run on the following base images:

* `simplyadrian/allsalt:centos_master_2017.7.2`
* `simplyadrian/allsalt:debian_master_2017.7.2`
* `simplyadrian/allsalt:opensuse_master_2017.7.2`
* `simplyadrian/allsalt:ubuntu_master_2016.11.3`
* `simplyadrian/allsalt:ubuntu_master_2017.7.2`

##### Start a virtualenv

```bash
pip install -U virtualenv
virtualenv .venv
source .venv/bin/activate
```

##### Install local requirements

```bash
make setup
```

#### Run tests

* `make test-centos_master_2017.7.2`
* `make test-debian_master_2017.7.2`
* `make test-opensuse_master_2017.7.2`
* `make test-ubuntu_master_2016.11.3`
* `make test-ubuntu_master_2017.7.2`

### <a name='run-containers'></a> Run Containers

* `make local-centos_master_2017.7.2`
* `make local-debian_master_2017.7.2`
* `make local-opensuse_master_2017.7.2`
* `make local-ubuntu_master_2016.11.3`
* `make local-ubuntu_master_2017.7.2`


## <a name='states'></a> Available States

### `sqlite`

Install sqlite3 from the source or a pre-compiled binary in the case of windows.

### `sqlite.create_table`

Creates a named table using a sql statement.

#### `required variables`

```yaml
sqlite.table_name: string
    example: users
sqlite.db_location: string
    example: /var/www/data
sqlite.db_file: string
    example: app.sqlite
sqlite.sql_statement: string
    example:
      CREATE TABLE `users` (`username` TEXT COLLATE NOCASE UNIQUE NOT NULL, `password` BLOB NOT NULL, `salt` BLOB NOT NULL, `last_login` INT)
```

### `sqlite.delete_table`

Deletes a named table.

#### `required variables`

```yaml
sqlite.table_name: string
    example: users
sqlite.db_location: string
    example: /var/www/data
sqlite.db_file: string
    example: app.sqlite
```


## <a name='pillar'></a> Pillar Customizations

Any of these values can be overwritten in a pillar file but most of the Windows
deviations are handled in the map.jinja file. If you do find yourself needing
more overrides follow the example below.

[pillar.example](sqlite/tests/pillar/sqlite/init.sls)
