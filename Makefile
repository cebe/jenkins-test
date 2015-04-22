
REDIS_VERSON=3.0.0

help:
	@echo "make test	- run phpunit tests using a docker environment"
	@echo "make clean	- stop docker and remove container"

test: adjust-config
	phpunit

adjust-config: docker
	echo "<?php \$$config['databases']['redis']['port'] = $(shell docker port $(shell cat redis-dockerid) | grep -Po ":(\d+)" | cut -b 2-);" > tests/data/config.local.php

docker:
	cd tests/docker/redis && sh build.sh
	docker run -d -P yiitest/redis:${REDIS_VERSION} > redis-dockerid


clean:
	docker stop $(shell cat redis-dockerid)
	docker rm $(shell cat redis-dockerid)
	rm redis-dockerid

