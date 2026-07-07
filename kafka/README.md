# Kafka Setup

## Description

Kafka is an open-source distributed event store and stream processing platform.

In this stack, Kafka acts as a data pipeline, transferring log data from Filebeat to Logstash.

This setup is based on the official `apache/kafka` Docker image, running a
single-node cluster in KRaft mode — Zookeeper is no longer required
(support for it was removed in Kafka 4.0).

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

**Create the topic used by the pipeline** (optional — topics are auto-created
with default settings; create it manually if you need specific partitioning):

```bash
docker exec -ti kafka /opt/kafka/bin/kafka-topics.sh --create --topic test_topic --partitions 3 --replication-factor 1 --bootstrap-server localhost:9092
```

**List Kafka topics:**

```bash
docker exec -ti kafka /opt/kafka/bin/kafka-topics.sh --describe --bootstrap-server localhost:9092
```
