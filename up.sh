#!/usr/bin/env bash

echo "Starting docker ."
docker-compose up -d --build

echo -e "\nConfiguring the MongoDB ReplicaSet.\n"
docker exec mongo-rs-1 /usr/bin/mongo --eval '''if (rs.status()["ok"] == 0) {
    rsconf = {
      _id : "rs0",
      members: [
        { _id : 0, host : "mongo1.confluentmongo.local:27017", priority: 1.0 },
        { _id : 1, host : "mongo2.confluentmongo.local:27017", priority: 0.5 },
        { _id : 2, host : "mongo3.confluentmongo.local:27017", priority: 0.5 }
      ]
    };
    rs.initiate(rsconf);
}

rs.conf();'''

echo -e "\n"

echo -e "\nConnection test: connect -> mongo-rs-1 | using it's container name\n"
docker exec connect /bin/bash -c "ping -c1 mongo-rs-1"
echo -e "\n"

echo -e "\nConnection test: connect -> mongo-rs-1 | using it's DNS registry\n"
docker exec connect /bin/bash -c "ping -c1 mongo1.confluentmongo.local"
echo -e "\n"

echo -e "\nConnection test: connect -> mongo-rs-1 | using it's IP address\n"
docker exec connect /bin/bash -c "ping -c1 172.10.10.59"
echo -e "\n"

echo -e "\nConnection test: localhost -> mongo-rs-1 | using it's IP address\n"
ping -c1 172.10.10.59
echo -e "\n"

echo -e '''

==============================================================================================================
Examine the topics in the Kafka UI: http://localhost:9021

Examine the collections:
  - In your shell run: docker-compose exec mongo1 /usr/bin/mongo
==============================================================================================================

Use <ctrl>-c to quit'''

read -r -d '' _ </dev/tty
