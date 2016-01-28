{%- set php_versions = salt['pillar.get']('phpfpm:php_versions', []) %}

# Vanilla PHP 5.5 bundled with Ubuntu 14.04
{% if php_versions|length == 0 %}

php5-fpm:
  pkg.installed: []

# Alternative PHP versions as provided by Ondřej Surý
{% else %}

# Workaround for adding PPA repositories with high level characters in their name.
# Because of a bug in add-apt-repository we cannot use pkgrepo.managed here,
# see https://github.com/oerdnj/deb.sury.org/issues/56 for more info.
ondrej-php-ppa:
  cmd.run:
    - name: LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && apt-get update
    - creates: /etc/apt/sources.list.d/ondrej-php-trusty.list

{%- for php_version in php_versions %}

# Ensure the FPM service is installed and running for this particular version (and used for watching)
php{{ php_version }}-fpm:
  pkg.installed:
    - require:
      - cmd: ondrej-php-ppa
  service.running:
    - require:
      - pkg: php{{ php_version }}-fpm
{%- endfor %}

{% endif %}
