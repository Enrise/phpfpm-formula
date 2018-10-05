# PHP Configuration
{%- set php_version = '7.3' %}
phpfpm:
  php_versions:
    - {{ php_version }}
  modules:
    - php{{ php_version }}-curl
    - php{{ php_version }}-gd
    - php{{ php_version }}-json
