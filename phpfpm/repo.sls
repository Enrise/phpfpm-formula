{%- set php_versions = salt['pillar.get']('phpfpm:php_versions', []) %}

{% if php_versions|length > 0 %}

# The destinaton file format add-apt-repository writes to has seeingly changed since Xenial, act accordingly
{%- set repo_file = '/etc/apt/sources.list.d/ondrej-php-' ~ salt['grains.get']('oscodename') ~ '.list' %}
{%- if salt['grains.get']('osfullname') == 'Ubuntu' and salt['grains.get']('osrelease')|float() >= 16.04 %}
{%- set repo_file = '/etc/apt/sources.list.d/ondrej-ubuntu-php-' ~ salt['grains.get']('oscodename') ~ '.list' %}
{%- endif %}

# Workaround for adding PPA repositories with high level characters in their name.
# Because of a bug in add-apt-repository we cannot use pkgrepo.managed here,
# see https://github.com/oerdnj/deb.sury.org/issues/56 for more info.
ondrej-php-ppa:
  cmd.run:
    - name: LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && apt-get update
    - creates: {{ repo_file }}

# Since the abovementioned repository also includes certain packages we prefer
# not to be getting from that particukar repo (e.g. libzmq3, openssl) we're
# lowering its priority.
/etc/apt/preferences.d/apt-pin-ondrej-php:
  file.managed:
    - source: salt://phpfpm/files/apt-pin-ondrej-php
    - require:
      - cmd: ondrej-php-ppa
{%- endif %}
