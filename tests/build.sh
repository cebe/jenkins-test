
docker build -t yiitest/redis-$REDIS_VERSION docker/redis

docker run --name=redis-$REDIS_VERSION -d yiitest/redis-$REDIS_VERSION
