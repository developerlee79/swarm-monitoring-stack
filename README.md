# Docker Swarm Monitoring Stack

An all-in-one monitoring stack for Docker Swarm environments.

<br>

## Stack Components

* [Docker Swarm](https://github.com/topics/docker)
* [Elastic Stack](https://github.com/elastic) ([Elasticsearch](https://github.com/elastic/elasticsearch), [Logstash](https://github.com/elastic/logstash), [Kibana](https://github.com/elastic/kibana), [Filebeat](https://github.com/elastic/beats), [Fleet Server](https://github.com/elastic/fleet-server), and [Elastic Agent](https://github.com/elastic/elastic-agent))
* [Kafka](https://github.com/apache/kafka) & [Zookeeper](https://github.com/apache/zookeeper)
* [Prometheus](https://github.com/prometheus/prometheus) & [Grafana](https://github.com/grafana/grafana)
* [Node Exporter](https://github.com/prometheus/node_exporter) & [cAdvisor](https://github.com/google/cadvisor)
* [Nginx](https://github.com/nginx/nginx)
* [ElastAlert](https://github.com/jertel/elastalert2)

<br>

## Features

* **"Elastic"-based log monitoring pipeline using the Elastic Stack and Kafka**

  * Fully supports global Elasticsearch cluster deployment without hardcoding
  * Full Elasticsearch security integration
  * Integration with Elastic Agent and Fleet
  * Example Logstash configuration included
  * Nginx proxy for Elasticsearch
  * Real-time alerting via ElastAlert
* **Docker Swarm node and service monitoring using Prometheus and Grafana**

  * Collects Swarm metrics using Node Exporter and cAdvisor
  * Includes two pre-built dashboards
* **Shell script for easy monitoring stack control**

<br>

## Setup

> **Requirements**: A Linux environment with Docker, Docker Compose, and an active Docker Swarm cluster.
> If you're unsure how to set this up, refer to `BASIC_GUIDE.md`.

<br>

### 1. Increase `vm.max_map_count` for Elasticsearch

```bash
vi /etc/sysctl.conf

# Add or update the following line
vm.max_map_count=262144

# Apply the changes
sysctl -p
```

<br>

### 2. Configure `daemon.json` to expose Docker metrics for monitoring containers

```bash
vi /etc/docker/daemon.json

# Example configuration
{
  "metrics-addr" : "0.0.0.0:9323",
  "experimental" : true
}
```

<br>

### 3. Run Filebeat on the server to be monitored

> See `filebeat/README.md` for details.

<br>

### 4. Start the Kafka server

> Refer to `kafka/README.md`.

<br>

### 5. Configure Logstash to receive input from Kafka

Modify the `bootstrap_servers` setting in `logstash.yml` to point to your Kafka server's IP.

```ruby
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

<br>

### 6. Set up Elasticsearch security

To use all features, basic security must be enabled in Elasticsearch.
Follow the [minimal security](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-minimal-setup.html) and [basic security](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-basic-setup.html) guides.
Copy the generated certificate to `./elasticsearch/config`.

If you do not need security, you can disable it in `elasticsearch/config/elasticsearch.yml`.

<br>

### 7. Set up Fleet Server security

After enabling basic security, you can create certificates for Fleet Server.
Follow the [Fleet server setup guide](https://www.elastic.co/guide/en/fleet/current/add-a-fleet-server.html) and [certificate generation guide](https://www.elastic.co/guide/en/fleet/current/secure-connections.html).
Copy the certificates to `./fleet-server`.

> Fleet Server is optional. If not needed, you can remove the related configuration.

<br>

## Running the Monitoring Stack

Use the provided shell script to start, stop, or manage the monitoring stack:

```bash
sh monitor_service.sh start
sh monitor_service.sh stop
sh monitor_service.sh restart
sh monitor_service.sh status
sh monitor_service.sh logs {service_name}
sh monitor_service.sh update {service_name}
```

<br>

## Access Dashboards

Once all services are running, you can access the following dashboards:

|Service|URL|Description|
|---|---|---|
|Grafana|`http://<your_server_ip>:3000`|Default: admin/admin
|Kibana|`http://<your_server_ip>:5601`||

