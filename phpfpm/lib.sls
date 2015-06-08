# Create a PHP-FPM pool for the given user
{%- macro create_pool(salt, domain, owner, pool_dir, template='salt://phpfpm/templates/pool.conf.jinja', fpm_params={}) %}
{{ pool_dir }}/{{domain}}.conf:
  file.managed:
    - source: {{ template }}
    - template: jinja
    - pool_name: {{ domain }}
    - pool_user: {{ owner }}
    - pool_group: {{ owner }}
    - fpm_params: {{ fpm_params }}
    - require:
      - file: {{ pool_dir }}
      - user: {{ owner }}
    - watch_in:
      - service: php5-fpm
{% endmacro -%}
