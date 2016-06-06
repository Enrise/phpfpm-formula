{%- set php_versions = salt['pillar.get']('phpfpm:php_versions', []) %}
{%- set webserver_edition = salt['pillar.get']('vhosting:server:webserver_edition','vanilla') %}
{% if webserver_edition == 'zendserver' %}
{%- set watch_pkg = 'zendserver' %}
{%- else %}
{%- set watch_pkg = 'php5-fpm' %}
{%- endif %}

extend:
# Vanilla Ubuntu 14.04 packages
{% if php_versions|length == 0 %}
# Extend the php-fpm and ensure the service is running
  php5-fpm:
    service.running:
      - enable: True
      #- reload: True # disabled due to php-fpm upstream issues
      - watch:
        - pkg: {{ watch_pkg }}
      - require:
        - pkg: {{ watch_pkg}}
{% endif %}

# Alternative PHP versions as provided by Ondřej Surý
{% if php_versions|length > 0 %}

{% for php_version in php_versions %}
  php{{ php_version }}-fpm:
    service.running:
      - enable: True
      - watch:
        - pkg: php{{ php_version }}-fpm
      - require:
        - pkg: php{{ php_version }}-fpm
{% endfor %}

{% endif %}
