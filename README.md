# Docker based development environment for Agno Pay

## Prerequisite

1. Linux machine
2. Docker
3. Docker Compose
4. Git
5. make

## Setup

    git clone --recurse-submodules git@github.com:nazan/agnopay-dev.git
    cd agnopay-dev
    make checkout-masters
    make build
    make up

## Run unit tests

Do the following to gain shell access to application container and run the unit tests.

    cd agnopay-dev
    make agnopay-bash
    composer install
    ./vendor/bin/phpunit