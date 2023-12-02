php_path := "php"
python_path := "python"
pg_path := "pg"
node_path := "node"

default: 
    just --list

# Build PHP 8.x FPM image
build_php_fpm BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Build PHP:{{BUILD_VERSION}} fpm'
	docker build . -t myprod/php:{{BUILD_VERSION}}-fpm --rm --target=fpm --build-arg PHP_VERSION={{BUILD_VERSION}}

push_php_fpm BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Push PHP:{{BUILD_VERSION}} fpm'
	docker push myprod/php:{{BUILD_VERSION}}-fpm

# Build PHP 8.x Cli image
build_php_cli BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Build PHP:{{BUILD_VERSION}} cli'
	docker build . -t myprod/php:{{BUILD_VERSION}}-cli --rm --target=cli --build-arg PHP_VERSION={{BUILD_VERSION}}

push_php_cli BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Push PHP:{{BUILD_VERSION}} cli'
	docker push myprod/php:{{BUILD_VERSION}}-cli

# Build PHP 8.x dev image
build_php_dev BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Build PHP:{{BUILD_VERSION}} fpm dev'
	docker build . -t myprod/php:{{BUILD_VERSION}}-dev --rm --target=dev --build-arg PHP_VERSION={{BUILD_VERSION}}

push_php_dev BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{php_path}}
	echo 'Push PHP:{{BUILD_VERSION}} dev'
	docker push myprod/php:{{BUILD_VERSION}}-dev

# Build Python 3.1x images
build_python BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{python_path}}
	echo 'Build Python:{{BUILD_VERSION}}'
	docker build . -t myprod/py:{{BUILD_VERSION}} --rm --target=main --build-arg PYTHON_VERSION={{BUILD_VERSION}}

push_python BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{python_path}}
	echo 'Push Python:{{BUILD_VERSION}}'
	docker push myprod/py:{{BUILD_VERSION}}

# Build PG 14x, 15x, 16x images
build_pg BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{pg_path}}
	echo 'Build postgres:{{BUILD_VERSION}}'
	docker build . -t myprod/db:pg-{{BUILD_VERSION}} --rm --target=postgres --build-arg PG_VERSION={{BUILD_VERSION}}

push_pg BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{pg_path}}
	echo 'Push Pg:{{BUILD_VERSION}}'
	docker push myprod/db:pg-{{BUILD_VERSION}}

# Build Timescale DB 14x, 15x, 16x images
build_timescaledb BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{pg_path}}
	echo 'Build Timescale:{{BUILD_VERSION}}'
	docker build . -t myprod/db:ts-{{BUILD_VERSION}} --rm --target=timescale --build-arg PG_VERSION={{BUILD_VERSION}}

push_timescaledb BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{pg_path}}
	echo 'Push Timescale:{{BUILD_VERSION}}'
	docker push myprod/db:ts-{{BUILD_VERSION}}

build_node BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{node_path}}
	echo 'Build node:{{BUILD_VERSION}}'
	docker build . -t myprod/node:{{BUILD_VERSION}} --rm --target=main --build-arg NODE_VERSION={{BUILD_VERSION}}

push_node BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{node_path}}
	echo 'Push Node:{{BUILD_VERSION}}'
	docker push myprod/node:{{BUILD_VERSION}}