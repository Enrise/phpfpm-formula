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

## Todo
- More configs
