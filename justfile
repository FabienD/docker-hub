PATH_PHP := "php"
PATH_PYTHON := "python"
PATH_PG := "pg"
PATH_NODE := "node"

DOCKER_UID := if env_var("DOCKER_UID") != "" { env_var("DOCKER_UID") } else { "1000" }
DOCKER_GID := if env_var("DOCKER_GID") != "" { env_var("DOCKER_GID") } else { "1000" }

default: 
    just --list

# Build PHP 8.x FPM image
build_php_fpm BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PHP}}
	echo 'Build PHP:{{BUILD_VERSION}} fpm'
	docker build . -t myprod/php:{{BUILD_VERSION}}-fpm --rm --target=fpm --build-arg PHP_VERSION={{BUILD_VERSION}} --build-arg DOCKER_UID={{DOCKER_UID}} --build-arg DOCKER_GID={{DOCKER_GID}}

# Push PHP 8.x FPM image
push_php_fpm BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PHP}}
	echo 'Push PHP:{{BUILD_VERSION}} fpm'
	docker push myprod/php:{{BUILD_VERSION}}-fpm

# Build PHP 8.x Cli image
build_php_cli BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PHP}}
	echo 'Build PHP:{{BUILD_VERSION}} cli'
	docker build . -t myprod/php:{{BUILD_VERSION}}-cli --rm --target=cli --build-arg PHP_VERSION={{BUILD_VERSION}} --build-arg DOCKER_UID={{DOCKER_UID}} --build-arg DOCKER_GID={{DOCKER_GID}}

# Push PHP 8.x Cli image
push_php_cli BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PHP}}
	echo 'Push PHP:{{BUILD_VERSION}} cli'
	docker push myprod/php:{{BUILD_VERSION}}-cli

# Build PHP 8.x dev image
build_php_dev BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PHP}}
	echo 'Build PHP:{{BUILD_VERSION}} fpm dev'
	docker build . -t myprod/php:{{BUILD_VERSION}}-dev --rm --target=dev --build-arg PHP_VERSION={{BUILD_VERSION}} --build-arg DOCKER_UID={{DOCKER_UID}} --build-arg DOCKER_GID={{DOCKER_GID}}

# Push PHP 8.x dev image
push_php_dev BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PHP}}
	echo 'Push PHP:{{BUILD_VERSION}} dev'
	docker push myprod/php:{{BUILD_VERSION}}-dev

# Build Python 3.1x images
build_python BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PYTHON}}
	echo 'Build Python:{{BUILD_VERSION}}'
	docker build . -t myprod/py:{{BUILD_VERSION}} --rm --target=main --build-arg PYTHON_VERSION={{BUILD_VERSION}} --build-arg DOCKER_UID={{DOCKER_UID}} --build-arg DOCKER_GID={{DOCKER_GID}}

# Push Python 3.1x images
push_python BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PYTHON}}
	echo 'Push Python:{{BUILD_VERSION}}'
	docker push myprod/py:{{BUILD_VERSION}}

# Build PG 14x, 15x, 16x images
build_postgresql BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PG}}
	echo 'Build postgres:{{BUILD_VERSION}}'
	docker build . -t myprod/db:pg-{{BUILD_VERSION}} --rm --target=postgresql --build-arg PG_VERSION={{BUILD_VERSION}} --build-arg DOCKER_UID={{DOCKER_UID}} --build-arg DOCKER_GID={{DOCKER_GID}}

# Push PG 14x, 15x, 16x images
push_postgresql BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PG}}
	echo 'Push Pg:{{BUILD_VERSION}}'
	docker push myprod/db:pg-{{BUILD_VERSION}}

# Build Timescale DB 14x, 15x, 16x images
build_timescaledb BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PG}}
	echo 'Build Timescale:{{BUILD_VERSION}}'
	docker build . -t myprod/db:ts-{{BUILD_VERSION}} --rm --target=timescaledb --build-arg PG_VERSION={{BUILD_VERSION}} --build-arg DOCKER_UID={{DOCKER_UID}} --build-arg DOCKER_GID={{DOCKER_GID}}

# Push Timescale DB 14x, 15x, 16x images
push_timescaledb BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_PG}}
	echo 'Push Timescale:{{BUILD_VERSION}}'
	docker push myprod/db:ts-{{BUILD_VERSION}}

# Build Node  images
build_node BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_NODE}}
	echo 'Build node:{{BUILD_VERSION}}'
	docker build . -t myprod/node:{{BUILD_VERSION}} --rm --target=main --build-arg NODE_VERSION={{BUILD_VERSION}} --build-arg DOCKER_UID={{DOCKER_UID}} --build-arg DOCKER_GID={{DOCKER_GID}}

# Push Node  images
push_node BUILD_VERSION:
	#!/usr/bin/env bash
	cd {{PATH_NODE}}
	echo 'Push Node:{{BUILD_VERSION}}'
	docker push myprod/node:{{BUILD_VERSION}}
