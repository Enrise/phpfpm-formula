{% from "phpfpm/map.jinja" import phpfpm as phpfpm_map with context %}

# Ensure the FPM-Pool directory exists
{{ phpfpm_map.dirs.config }}:
  file.directory:
    - require:
      - pkg: php5-fpm

# Ensure the socket directory exists: (xxx todo: this may need to be configurable)
{{ phpfpm_map.dirs.socket }}:
  file.directory:
    - require_in:
      - service: php5-fpm

{%- if salt['pillar.get']('phpfpm:config:cleanup', True) %}
# Cleanup default fpm pool(s)
{%- for filename in ['www.conf'] %}
{{ phpfpm_map.dirs.config }}/{{ filename }}:
  file.absent
{%- endfor %}
{%- endif %}
