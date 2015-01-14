# Extend the php-fpm and ensure the service is running
extend:
  php5-fpm:
    service.running:
      - enable: True
      #- reload: True # disabled due to php-fpm upstream issues
      - watch:
        - pkg: php5-fpm
      - require:
        - pkg: php5-fpm
