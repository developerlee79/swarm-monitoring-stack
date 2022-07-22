# Kafka Setup

## Description

Kafka is the open-source distributed event store and stream-processing platform.

It's perform as data pipeline that hands over log data sent from Filebeat to Logstash.

Based on wurstmeister's kafka docker image.

## Setup

You must change the external advertised listeners in docker-compose.yml to the IP of the run server.

```
# docker-compose.yml

KAFKA_ADVERTISED_LISTENERS: INTERNAL://kafka:9092,EXTERNAL://your_kafka_server_ip:9094
```

## Run

You can just use shell script monitor_service.sh to run the kafka easily.

```console
sh monitor_service.sh start
```

Or use docker compose command.

```console
docker compose up
```

You can also use shell scripts to stop, check status, and print logs.

```
sh monitor_service.sh stop
sh monitor_service.sh status
sh monitor_service.sh logs
```

## Commands

**List kafka topics**
```console
docker exec -ti kafka /opt/kafka/bin/kafka-topics.sh --describe --zookeeper zookeeper:2181
```


