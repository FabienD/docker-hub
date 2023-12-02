php_path := "php"
python_path := "python"
pg_path := "pg"
node_path := "node"

default: 
    just --list

# Build PHP 8.x FPM image
build_php_fpm PHP_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Build PHP:{{PHP_VERSION}} fpm'
	docker build . -t myprod/php:{{PHP_VERSION}}-fpm --rm --target=fpm --build-arg PHP_VERSION={{PHP_VERSION}}

# Build PHP 8.x Cli image
build_php_cli PHP_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Build PHP:{{PHP_VERSION}} cli'
	docker build . -t myprod/php:{{PHP_VERSION}}-fpm --rm --target=cli --build-arg PHP_VERSION={{PHP_VERSION}}

# Build PHP 8.x dev image
build_php_dev PHP_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Build PHP:{{PHP_VERSION}} fpm dev'
	docker build . -t myprod/php:{{PHP_VERSION}}-dev --rm --target=dev --build-arg PHP_VERSION={{PHP_VERSION}}

# Build Python 3.1x images
build_python PYTHON_VERSION:
	#!/usr/bin/env bash
	cd {{python_path}}
	echo 'Build Python:{{PYTHON_VERSION}}'
	docker build .  -t myprod/py:{{PYTHON_VERSION}} --rm --target=main --build-arg PYTHON_VERSION={{PYTHON_VERSION}}

# Build PG 14x, 15x, 16x images
build_pg PG_VERSION:
	#!/usr/bin/env bash
	cd {{pg_path}}
	echo 'Build postgres:{{PG_VERSION}}'
	docker build .  -t myprod/pg:{{PG_VERSION}} --rm --target=postgres --build-arg PG_VERSION={{PG_VERSION}}

# Build Timescale DB 14x, 15x, 16x images
build_timescaledb PG_VERSION:
	#!/usr/bin/env bash
	cd {{pg_path}}
	echo 'Build timescale:{{PG_VERSION}}'
	docker build .  -t myprod/timescale:{{PG_VERSION}} --rm --target=timescale --build-arg PG_VERSION={{PG_VERSION}}

build_node NODE_VERSION:
	#!/usr/bin/env bash
	cd {{node_path}}
	echo 'Build node:{{NODE_VERSION}}'
	docker build .  -t myprod/node:{{NODE_VERSION}} --rm --target=main --build-arg NODE_VERSION={{NODE_VERSION}}