# Extend the php-fpm and ensure the service is running
extend:
  php5-fpm:
    service.running:
      - enable: True
      - reload: True
      - watch:
        - pkg: php5-fpm      
      - require:
        - pkg: php5-fpm
