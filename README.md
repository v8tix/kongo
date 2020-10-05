![kongo image](./resources/kongo-github.png)

# Welcome

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="display: block; border-width:0; float: right" align="left" src="https://i.creativecommons.org/l/by/4.0/88x31.png"/></a><br/>

Welcome to the Kongo project. Kongo is a development environment compose by the [Confluent Kafka streaming platform](https://www.confluent.io/) and the [MongoDB flexible schema database](https://www.mongodb.com/). 

#### Prerequisites
* Docker Engine installed.
* Docker Compose installed.

## What this guide covers
1. How to set up the environment.
2. How to build and run the environment.
### 1. How to set up the environment.
* In order to interact with this environment from your local environment:  
  * Open the file ./shared/hosts and copy the hosts registries:
  ````
    172.10.10.50     zookeeper.confluentmongo.local
    ...
    172.10.10.61     mongo3.confluentmongo.local
  ````    
  * Then, add them to your local environment /etc/hosts file.
  * You can connect to the MongoDB replica set using the connection URL:
  ````
    "mongodb://172.10.10.59:27017,172.10.10.60:27017,172.10.10.61:27017/test?replicaSet=rs0"
  ````    
### 2. How to build and run the environment.
* Under the project root directory you will find the following scripts:
  * up.sh: This script build, run and configure Confluent Kafka and a MongoDB replica set.
  * stop.sh: Stop the running containers without deleting them (You can restart it using the up.sh script).
  * down.sh: Stop the running containers and deleting the development environment resources including its volumes.
  * example.sh: This script uses the [mongo-kafka](https://github.com/mongodb/mongo-kafka/blob/master/docker/run.sh) example to test the environment.
  * cleanup.sh: Deletes the resources created by the example.sh script.
## Authors
* Initial work

![v8tix logo](resources/v8tix-logo.jpg) <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Contact us](mailto:info@v8tix.com)</p>
## License  
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="display: block; border-width:0; float: right" align="left" src="https://i.creativecommons.org/l/by/4.0/88x31.png"/>&nbsp;</a>This work is licensed under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).  
  













 