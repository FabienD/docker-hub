# Recipes for Docker images

## List of Docker images

 - PHP 8.1, 8.2, 8.3
 - Python 3.10, 3.11, 3.12
 - Node 18, 20
 - Pg (Postgres 16 or TimescaleDB 16 with [Replibyte](https://www.replibyte.com/))

Images can be found on [Docker Hub](https://hub.docker.com/u/myprod)

## How to use recipes

We use [just](https://just.systems/man/en/chapter_1.html) to build images.

All recipes are in the `justfile` file.


### Examples 

Build PHP FPM 8.2

```bash
just build_php_fpm 8.2
```

Build PHP Cli 8.3

```bash
just build_php_cli 8.3
```