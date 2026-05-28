# See https://tech.davis-hansson.com/p/make/
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.DEFAULT_GOAL := help

.PHONY: help
help:
	@printf "\033[33mUsage:\033[0m\n  make TARGET\n\n\033[32m#\n# Commands\n#---------------------------------------------------------------------------\033[0m\n\n"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' | awk 'BEGIN {FS = ":"}; {printf "\033[33m%s:\033[0m%s\n", $$1, $$2}'

DOCKER_COMPOSE ?= docker compose
PHP_CS_FIXER=vendor/bin/php-cs-fixer
ZIZMOR ?= $(DOCKER_COMPOSE) run --rm zizmor

.PHONY: check
check:		## Runs all checks
check: cs-lint test-unit zizmor

.PHONY: cs
cs:		## Applies coding standard fixes
cs: composer-normalize gitsortignore vendor/autoload.php
	$(PHP_CS_FIXER) fix --diff --verbose

.PHONY: composer-normalize
# Normalizes composer.json
composer-normalize: vendor/autoload.php
	composer normalize --no-check-lock --diff

.PHONY: gitsortignore
# Sort .gitignore
gitsortignore:
	LC_ALL=C sort -u .gitignore -o .gitignore

.PHONY: cs-lint
cs-lint:	## Runs coding standard checks
cs-lint: composer-normalize-lint composer-validate vendor/autoload.php
	$(PHP_CS_FIXER) fix --diff --dry-run --verbose

.PHONY: composer-normalize-lint
# Checks composer.json normalization
composer-normalize-lint: vendor/autoload.php
	composer normalize --no-check-lock --diff --dry-run

.PHONY: composer-validate
# Validates composer.json
composer-validate:
	composer validate --strict

.PHONY: test-unit
test-unit:	## Runs the unit tests
test-unit: vendor/autoload.php
	vendor/bin/phpunit

.PHONY: zizmor
# Audits GitHub Actions workflows
zizmor:
	$(ZIZMOR) .github/workflows

vendor/autoload.php:
	composer install --prefer-dist
	touch -c $@
