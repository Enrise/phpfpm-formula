# phpfpm-formula

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

The phpfpm module recognizes either the vanilla PHP-FPM 5.5 installation, or any combination of PHP-FPM 5.6 and PHP-FPM 7, provided by Ondřej Surý via the PPA.
When specified, either PHP 5.6, PHP-FPM 7.0, or a combination of both will be installed.

```yaml
phpfpm:
  php_versions:
    - '5.6'
    - '7.0'
```
If this configuration is omitted, PHP 5.5 will be used instead.

### Some warnings
* It is not possible to use PHP-FPM 5.5 together with either 5.6 or 7.0, as this will break things.
* If other packages rely on either the package or service php5-fpm, it is not possible to use PHP-FPM 5.6 or 7.0

## Todo
- More configs
