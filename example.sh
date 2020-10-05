#!/usr/bin/env bash

echo -e "\nAdding datagen pageviews:"
curl -X POST -H "Content-Type: application/json" --data '
  { "name": "datagen-pageviews",
    "config": {
      "connector.class": "io.confluent.kafka.connect.datagen.DatagenConnector",
      "kafka.topic": "pageviews",
      "quickstart": "pageviews",
      "key.converter": "org.apache.kafka.connect.json.JsonConverter",
      "value.converter": "org.apache.kafka.connect.json.JsonConverter",
      "value.converter.schemas.enable": "false",
      "producer.interceptor.classes": "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor",
      "max.interval": 200,
      "iterations": 10000000,
      "tasks.max": "1"
}}' http://localhost:8083/connectors -w "\n"

sleep 5

echo -e "\nAdding MongoDB Kafka Sink Connector for the 'pageviews' topic into the 'test.pageviews' collection:"
curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongo-sink",
   "config": {
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"pageviews",
     "connection.uri":"mongodb://172.10.10.59:27017,172.10.10.60:27017,172.10.10.61:27017/test?replicaSet=rs0",
     "database":"test",
     "collection":"pageviews",
     "key.converter": "org.apache.kafka.connect.storage.StringConverter",
     "value.converter": "org.apache.kafka.connect.json.JsonConverter",
     "value.converter.schemas.enable": "false"
}}' http://localhost:8083/connectors -w "\n"

sleep 5

echo -e "\nAdding MongoDB Kafka Source Connector for the 'test.pageviews' collection:"
curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongo-source",
   "config": {
     "tasks.max":"1",
     "connector.class":"com.mongodb.kafka.connect.MongoSourceConnector",
     "connection.uri":"mongodb://172.10.10.59:27017,172.10.10.60:27017,172.10.10.61:27017/test?replicaSet=rs0",
     "topic.prefix":"mongo",
     "database":"test",
     "collection":"pageviews"
}}' http://localhost:8083/connectors -w "\n"

sleep 5

echo -e "\nKafka Connectors: \n"
curl -X GET "http://localhost:8083/connectors/" -w "\n"

echo -ne "\n"

echo "Looking at data in 'db.pageviews':"
docker exec mongo-rs-1 /usr/bin/mongo --eval 'db.pageviews.find()'
