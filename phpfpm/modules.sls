{%- set php_modules = salt['pillar.get']('phpfpm:modules', []) %}

{%- for php_module in php_modules %}
{{ php_module }}:
  pkg.installed: []
{%- endif %-}
