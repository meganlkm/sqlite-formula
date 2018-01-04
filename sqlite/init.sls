{% from "sqlite/map.jinja" import sqlite with context %}

# Cleanup first
sqlite-remove-prev-archive:
  file.absent:
    - name: '{{ sqlite.tmpdir }}/{{ sqlite.archive_name }}'
    - require_in:
      - sqlite-extract-dirs

sqlite-extract-dirs:
  file.directory:
    - names:
      - '{{ sqlite.tmpdir }}'
      - '{{ sqlite.home }}'
{% if grains.os not in ('Windows',) %}
      - '{{ sqlite.realhome }}'
    - user: root
    - group: root
    - mode: 755
{% endif %}
    - makedirs: True
    - require_in:
      - sqlite-download-archive

sqlite-download-archive:
  cmd.run:
    - name: curl {{ sqlite.opts }} -o '{{ sqlite.tmpdir }}/{{ sqlite.archive_name }}' {{ sqlite.src_url }}
      {% if grains['saltversioninfo'] >= [2017, 7, 0] %}
    - retry:
        attempts: {{ sqlite.retries }}
        interval: {{ sqlite.interval }}
      {% endif %}
{%- if sqlite.src_hashsum %}
   # Check local archive using hashstring for older Salt / MacOS.
   # (see https://github.com/saltstack/salt/pull/41914).
  {%- if grains['saltversioninfo'] <= [2016, 11, 6] %}
sqlite-check-archive-hash:
   module.run:
     - name: file.check_hash
     - path: '{{ sqlite.tmpdir }}/{{ sqlite.archive_name }}'
     - file_hash: {{ sqlite.src_hashsum }}
     - onchanges:
       - cmd: sqlite-download-archive
     - require_in:
       - archive: sqlite-package-install
  {%- endif %}
{%- endif %}
sqlite-package-install:
  archive.extracted:
    - source: 'file://{{ sqlite.tmpdir }}/{{ sqlite.archive_name }}'
    - name: '{{ sqlite.realhome }}'
    - archive_format: {{ sqlite.archive_type }}
       {% if grains['saltversioninfo'] >= [2016, 11, 0] %}
    - enforce_toplevel: False
       {% endif %}
       {%- if sqlite.dl.src_hashsum and grains['saltversioninfo'] > [2016, 11, 6] %}
    - source_hash: {{ sqlite.src_hashsum }}
       {%- endif %}
    - onchanges:
      - cmd: sqlite-download-archive
    - require_in:
      - sqlite-remove-archive
sqlite-remove-archive:
  file.absent:
    - name: '{{ sqlite.tmpdir }}'
    - onchanges:
{%- if grains.os in ('Windows',) %}
      - pkg: sqlite-package-install
{% else %}
      #Unix
      - archive: sqlite-package-install
{% endif %}
