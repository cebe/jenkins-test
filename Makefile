
REDIS_VERSON=3.0.0

help:
	@echo "make test	- run phpunit tests using a docker environment"
	@echo "make docker	- run redis in docker and set the redis port in test config"
	@echo "make clean	- stop docker and remove container"

test: docker
	phpunit


docker:
	cd tests/docker/redis && sh build.sh
	docker run -d -P yiitest/redis:${REDIS_VERSION} > redis-dockerid
	sed -ri "s/^(\s*'port' => )[0-9]*,/\\1$(shell docker port $(shell cat redis-dockerid) | grep -Po ":(\d+)" | cut -b 2-),/" tests/data/config.php

clean:
	docker stop $(shell cat redis-dockerid)
	docker rm $(shell cat redis-dockerid)
	rm redis-dockerid

