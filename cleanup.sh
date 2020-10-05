#!/usr/bin/env bash

curl --output /dev/null -X DELETE http://localhost:8083/connectors/datagen-pageviews || true
curl --output /dev/null -X DELETE http://localhost:8083/connectors/mongo-sink || true
curl --output /dev/null -X DELETE http://localhost:8083/connectors/mongo-source || true
docker exec mongo-rs-1 /usr/bin/mongo --eval "db.dropDatabase()"
