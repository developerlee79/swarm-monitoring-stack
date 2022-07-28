# Docker Swarm Monitoring Stack

All-in-one monitoring stack with docker swarm

### Stack

- Docker Swarm
- Elastic Stack (Elasticsearch, Logstash, Kibana, Filebeat, Fleet)
- Kafka & Zookeeper
- Prometheus & Grafana
- Node exporter & cAdvisor
- Nginx

### Feature

- "Elastic" log monitoring pipeline with Elastic Stack and Kafka
  - Full support for global deploy Elasticsearch cluster without any hard coding
  - Full support for Elasticsearch security
  - Integrate with Elastic Agent & Fleet
  - Logstash configuration example
  - Nginx Proxy for Elasticsearch
- Monitor Docker Swarm nodes & services with Prometheus & Grafana
  - Collect Swarm metrics with Node exporter & cAdvisor
  - Two AWESOME basic dashboard
- Shell Script for easy use of monitoring stack

## Setup

> Require: Linux with Docker & Docker Compose installed and Docker Swarm cluster
>          
> If you don't know how, BASIC_GUIDE.md will help you.

### 1. Increase vm.max_map_count for Elasticsearch

```console
vi /etc/sysctl.conf

# systemctl.conf
vm.max_map_count=262144

sysctl -p
```

### 2. Set daemon.json to expose docker daemon metrics for monitor container 

```console
vi /etc/docker/daemon.json

# daemon.json
{
  "metrics-addr" : "0.0.0.0:9323",
  "experimental" : true
}
```

### 3. Run Filebeat at server to be monitored

> Read filebeat/README.md

### 4. Run Kafka server

> Read kafka/README.md

### 5. Set Logstash input to Kafka server

You must change the kafka bootstrap_servers in logstash.yml to the IP of the kafka server.

```
# logstash/config/logstash.yml

input {
    kafka {
        bootstrap_servers => "your_kafka_server_ip:9094"
        topics => ["test_topic"]
        codec => json
        decorate_events => true
    }
}
```

### 6. Set up security for Elasticsearch

Basic security must be set to use all the features of Elasticsearch.

Follow these [minimal security](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-minimal-setup.html) and [basic security](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-basic-setup.html) docs to complete the security settings and transfer the issued certificate to ./elasticsearch/config.

If you don't need security, turn off the security at elasticsearch/config/elasticsearch.yml.

### 7. Setup security for fleet server

After set up the basic security, you should create certificates for fleet server.

Follow this [self-managed setup guide](https://www.elastic.co/guide/en/fleet/current/add-a-fleet-server.html) to set up server and [create the certificates](https://www.elastic.co/guide/en/fleet/current/secure-connections.html) and transfer it to ./fleet-server.

It's not essential. If you don't want to use it, you can remove the Fleet server setting.

## Run

You can just use shell script monitor_service.sh to run the monitoring system easily.

```console
sh monitor_service.sh start
sh monitor_service.sh stop
sh monitor_service.sh restart
sh monitor_service.sh status
sh monitor_service.sh logs {service name}
sh monitor_service.sh update {service name}
```
