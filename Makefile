
REDIS_VERSON=3.0.0
PHP_VERSON=5.6.8
YII_VERSON=dev-master


help:
	@echo "make test	- run phpunit tests using a docker environment"
	@echo "make clean	- stop docker and remove container"

test: adjust-config
	composer require "yiisoft/yii2:${YII_VERSION}" --prefer-dist
	composer install --prefer-dist
	docker run --rm=true -v $(shell pwd):/opt/test --link $(shell cat redis-dockerid):redis yiitest/php:${PHP_VERSION} phpunit --verbose

adjust-config: docker
#	echo "<?php \$$config['databases']['redis']['port'] = $(shell docker port $(shell cat redis-dockerid) | grep -Po ":(\d+)" | cut -b 2-); \$$config['databases']['redis']['hostname'] = 'redis';" > tests/data/config.local.php
	echo "<?php \$$config['databases']['redis']['port'] = 6379; \$$config['databases']['redis']['hostname'] = 'redis';" > tests/data/config.local.php

docker: build-docker
	docker run -d -P yiitest/redis:${REDIS_VERSION} > redis-dockerid

build-docker:
	test -d tests/tools || git clone https://github.com/cebe/jenkins-test-docker tests/tools
	cd tests/tools && git checkout -- . && git pull
	cd tests/tools/php && sh build.sh
	cd tests/tools/redis && sh build.sh


clean:
	docker stop $(shell cat redis-dockerid)
	docker rm $(shell cat redis-dockerid)
	rm redis-dockerid

