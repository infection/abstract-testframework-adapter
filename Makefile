# See https://tech.davis-hansson.com/p/make/
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.DEFAULT_GOAL := help

.PHONY: help
help:
	@printf "\033[33mUsage:\033[0m\n  make TARGET\n\n\033[32m#\n# Commands\n#---------------------------------------------------------------------------\033[0m\n\n"
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//' | awk 'BEGIN {FS = ":"}; {printf "\033[33m%s:\033[0m%s\n", $$1, $$2}'

.PHONY: check
check:		## Runs all checks
check: cs-lint test-unit

.PHONY: cs
cs:		## Applies coding standard fixes
cs: vendor/autoload.php
	vendor/bin/php-cs-fixer fix --diff --verbose
	composer normalize --no-check-lock --diff

.PHONY: cs-lint
cs-lint:	## Runs coding standard checks
cs-lint: vendor/autoload.php
	vendor/bin/php-cs-fixer fix --diff --dry-run --verbose
	composer normalize --no-check-lock --diff --dry-run
	composer validate --strict

.PHONY: test-unit
test-unit:	## Runs the unit tests
test-unit: vendor/autoload.php
	vendor/bin/phpunit

vendor/autoload.php:
	composer install --prefer-dist
	touch -c $@
