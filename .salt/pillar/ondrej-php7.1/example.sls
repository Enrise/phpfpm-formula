phpfpm:
  ## Required for Zend Server:
  lookup:
    dirs:
      config: /usr/local/zend/etc/fpm.d
      socket: /usr/local/zend/tmp

  config:
    # Do not remove default configs (required for Zend Server)
    cleanup: False

  # Install additional PHP modules (for non-Zend Server installs)
  modules:
    - php5-gd
    - php5-mcrypt
