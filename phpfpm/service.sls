{%- set php_versions = salt['pillar.get']('phpfpm:php_versions', []) %}

extend:
# Vanilla Ubuntu 14.04 packages
{% if php_versions|length == 0 or salt['pillar.get']('vhosting:server:webserver_edition','vanilla') == 'zendserver' %}
#
# Extend the php-fpm and ensure the service is running
  php5-fpm:
    service.running:
      - enable: True
      #- reload: True # disabled due to php-fpm upstream issues
      - watch:
        - pkg: php5-fpm
      - require:
        - pkg: php5-fpm
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
