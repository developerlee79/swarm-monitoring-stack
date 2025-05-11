# Kafka Setup

## Description

Kafka is an open-source distributed event store and stream processing platform.

In this stack, Kafka acts as a data pipeline, transferring log data from Filebeat to Logstash.

This setup is based on the `wurstmeister/kafka` Docker image.

<br>

## Setup

You must update the advertised external listener IP address in `docker-compose.yml` to match the host server's IP:

```yaml
# docker-compose.yml

KAFKA_ADVERTISED_LISTENERS: INTERNAL://kafka:9092,EXTERNAL://your_kafka_server_ip:9094
```

<br>

## Run

To run Kafka using the provided shell script:

```bash
sh monitor_service.sh start
```

Alternatively, use Docker Compose directly:

```bash
docker compose up
```

To stop Kafka, check its status, or view logs:

```bash
sh monitor_service.sh stop
sh monitor_service.sh status
sh monitor_service.sh logs
```

<br>

## Commands

**List Kafka topics:**

```bash
docker exec -ti kafka /opt/kafka/bin/kafka-topics.sh --describe --zookeeper zookeeper:2181
```
