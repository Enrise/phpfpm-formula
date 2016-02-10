{%- set php_versions = salt['pillar.get']('phpfpm:php_versions', []) %}

# Vanilla PHP 5.5 bundled with Ubuntu 14.04
{% if php_versions|length == 0 %}

php5-fpm:
  pkg.installed: []

# Alternative PHP versions as provided by Ondřej Surý
{% else %}
{%- for php_version in php_versions %}

# Ensure the FPM service is installed and running for this particular version (and used for watching)
php{{ php_version }}-fpm:
  pkg.installed:
    - require:
      - cmd: ondrej-php-ppa
{%- endfor %}

{% endif %}
