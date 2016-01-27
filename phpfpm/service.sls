{%- set php_versions = salt['pillar.get']('phpfpm:php_versions', []) %}

# Vanilla Ubuntu 14.04 packages
{% if len(php_versions) == 0 %}

# Extend the php-fpm and ensure the service is running
extend:
  php5-fpm:
    service.running:
      - enable: True
      #- reload: True # disabled due to php-fpm upstream issues
      - watch:
        - pkg: php5-fpm
      - require:
        - pkg: php5-fpm

# Alternative PHP versions as provided by Ondřej Surý
{% else %}

extend:
{% for php_version in php_versions %}
  php{{ php_version }}-fpm:
    service.running:
      - enable: True
      #- reload: True # disabled due to php-fpm upstream issues
      - watch:
        - pkg: php{{ php_version }}-fpm
      - require:
        - pkg: php{{ php_version }}-fpm

{% endfor %}

{% endif %}
