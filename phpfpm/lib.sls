# Create a PHP-FPM pool for the given user
{%- macro create_pool(salt, domain, owner, pool_dir, socket_dir, template='salt://phpfpm/templates/pool.conf.jinja', fpm_params={}, php_version=None) %}
{{ pool_dir }}/{{domain}}.conf:
  file.managed:
    - source: {{ template }}
    - template: jinja
    - pool_name: {{ domain }}
    - pool_user: {{ owner }}
    - pool_group: {{ owner }}
    - fpm_params: {{ fpm_params }}
    - socket_dir: {{ socket_dir }}
    - require:
      - file: {{ pool_dir }}
      - file: {{ socket_dir }}
      - user: {{ owner }}
    - watch_in:
    {%- if php_version %}
      - service: php{{ php_version }}-fpm
    {%- else %}
      - service: php-fpm
    {%- endif %}
{% endmacro -%}
