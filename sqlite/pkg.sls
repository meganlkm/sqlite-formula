{% from "sqlite/map.jinja" import sqlite with context %}

sqlite:
  pkg.installed:
    - name: {{ sqlite.package }}
