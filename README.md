# phpfpm-formula

[![Travis branch](https://img.shields.io/travis/Enrise/phpfpm-formula/master.svg?style=flat-square)](https://travis-ci.org/Enrise/phpfpm-formula)

This formula will install PHP-FPM.

## Compatibility

This formula currently only works on Debian-based systems (Debian, Ubuntu etc).

## Contributing

Pull requests for other OSes and bug fixes are more than welcome.

## Usage

Include "phpfpm" in your project for the "full stack". Optionally you can select which states you require.

You can use the provided macro in lib.sls to generate the required configuration file.

### Usage with Zend Server module
The lookup part (commented in pillar.example) is **required** when using non-default PHP stacks such as Zend Server.

## PHP-FPM Versions

The phpfpm formula recognizes either the vanilla PHP-FPM installation (5.5 on Ubuntu 14.04), or any combination of PHP-FPM 5.6 and PHP-FPM 7, provided by Ondřej Surý via the PPA.
When specified, either PHP 5.6, PHP-FPM 7.0, or a combination of both will be installed.

Ubuntu 16.04 has not been tested yet, because at the time of writing, it hasn't been released yet.

Since Ubuntu 16.04 will ship with PHP 7.0 by default, the PPA is not needed anyway for PHP 7.

Specify the PHP-FPM versions like so:

```yaml
phpfpm:
  php_versions:
    - '5.6'
    - '7.0'
```
If this configuration is omitted, the distro default PHP-FPM (5.5 on Ubuntu 14.04) will be used instead.

### Some warnings
* It is not possible to use PHP-FPM 5.5 together with either 5.6 or 7.0, as 5.6 will remove 5.5 and the formula does not manage 7.0 alongside 5.5.
* If other packages depend on either the package or service php5-fpm, it is not possible to use PHP-FPM 5.6 or 7.0, because of the init script being renamed.
