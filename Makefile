UID ?= 1000
GID ?= 1000

THIS_FILE := $(lastword $(MAKEFILE_LIST))




# Shell access to app container.

.PHONY: agnopay-bash
agnopay-bash:
	docker-compose exec --user $(UID):$(GID) agnopay bash




# Container preparation routines.

.PHONY: agnopay-prepare
agnopay-prepare: agnopay-touch
	docker-compose exec --user $(UID):$(GID) agnopay /usr/src/aidock/build/prepare.sh


.PHONY: prepare-all
prepare-all: agnopay-prepare
	@echo "Post setup done for all application components."




# Bring up/down services.

.PHONY: up
up: agnopay-touch
	docker-compose up -d agnopay

.PHONY: down
down:
	docker-compose down




# Create required directories and files in host machine.

.PHONY: agnopay-touch
agnopay-touch:
	cp -n ./.env.example ./.env
	cp -n ./agnopay-dc/.env.example ./agnopay-dc/.env

	mkdir -p ./agnopay-dc/log
	touch ./agnopay-dc/log/php-error.log
	chmod 777 ./agnopay-dc/log/php-error.log




# Build image.

.PHONY: build
build: agnopay-touch
	docker-compose build agnopay