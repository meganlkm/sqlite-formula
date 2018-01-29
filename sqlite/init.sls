{% from "sqlite/map.jinja" import sqlite with context %}

include:
  - sqlite/pkg
{% if sqlite.src or grains.os == 'Windows' %}
  - sqlite/src
{% endif %}
{% if sqlite.create_mode %}
  - sqlite/create_table
{% endif %}
{% if sqlite.delete_mode %}
  - sqlite/delete_table
{% endif %}
