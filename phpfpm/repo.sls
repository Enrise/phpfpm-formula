{%- set php_versions = salt['pillar.get']('phpfpm:php_versions', []) %}

{% if php_versions|length > 0 %}
# Workaround for adding PPA repositories with high level characters in their name.
# Because of a bug in add-apt-repository we cannot use pkgrepo.managed here,
# see https://github.com/oerdnj/deb.sury.org/issues/56 for more info.
ondrej-php-ppa:
  cmd.run:
    - name: LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && apt-get update
    - creates: /etc/apt/sources.list.d/ondrej-php-trusty.list
{%- endif %}
