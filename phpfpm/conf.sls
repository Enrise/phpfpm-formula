{% set php_versions = salt['pillar.get']('phpfpm:php_versions', []) %}
{% set webserver_edition = salt['pillar.get']('vhosting:server:webserver_edition', 'vanilla') %}
{% if webserver_edition == 'zendserver' %}
{%- set req_pkg = 'zendserver' %}
{%- else %}
{%- set req_pkg = 'php-fpm' %}
{%- endif %}

# Vanilla Ubuntu 14.04 packages
{% if php_versions|length == 0 %}

{% from "phpfpm/map.jinja" import phpfpm as phpfpm_map with context %}

# Ensure the FPM-Pool directory exists
{{ phpfpm_map.dirs.config }}:
  file.directory:
    - require:
      - pkg: {{ req_pkg }}

# Ensure the socket directory exists: (xxx todo: this may need to be configurable)
{{ phpfpm_map.dirs.socket }}:
  file.directory:
    - require:
      - pkg: {{ req_pkg }}

{%- if salt['pillar.get']('phpfpm:config:cleanup', True) %}
# Cleanup default fpm pool(s)
{%- for filename in ['www.conf'] %}
{{ phpfpm_map.dirs.config }}/{{ filename }}:
  file.absent
{%- endfor %}
{%- endif %}

# Alternative PHP versions as provided by Ondřej Surý
{% else %}

{% for php_version in php_versions %}

# Create the pool folder (being used as dependency)
/etc/php/{{ php_version }}/fpm/pool.d:
  file.directory:
    - recursive: True
    - require:
      - pkg: php{{ php_version }}-fpm

/etc/php/{{ php_version }}/tmp:
  file.directory:
    - require:
      - pkg: php{{ php_version }}-fpm

{% endfor %}

{% endif %}
