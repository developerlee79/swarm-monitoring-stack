# Filebeat Setup

### 1. Import the public signing key

```bash
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
```

<br>

### 2. Add the Elastic repository

Create a `.repo` file (e.g., `elastic.repo`) in your `/etc/yum.repos.d/` directory and add the following content:

```ini
# /etc/yum.repos.d/elastic.repo

[elastic-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

<br>

### 3. Install and enable Filebeat

```bash
yum install filebeat
systemctl enable filebeat
chkconfig filebeat on
```

<br>

### 4. Configure `filebeat.yml` and apply setup

Replace the existing `filebeat.yml` with the provided configuration file, then apply the setup.

```bash
vi /etc/filebeat/filebeat.yml
```

Example configuration:

```yaml
# filebeat.yml

# Define the path to your application's log files
filebeat.inputs:
  - type: log
    paths:
      - /directory/of/target/logs/*.log

# Define your Kafka server address
output.kafka:
  hosts: ['your_kafka_server_ip:9094']
```

Apply the setup:

```bash
filebeat setup -e
```

<br>

### 5. Manage Filebeat using systemctl

```bash
systemctl start filebeat
systemctl status filebeat
systemctl stop filebeat
```
