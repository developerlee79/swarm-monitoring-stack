# Filebeat Setup

Download and install the public signing key

```console
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
```

Create a file with a .repo extension (for example, elastic.repo) in your /etc/yum.repos.d/ directory and add the following lines:

```
# vi /etc/yum.repos.d/elastic.repo

[elastic-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

Install & enable filebeat

```console
yum install filebeat
systemctl enable filebeat
chkconfig filebeat
```

Replace filebeat.yml with provided file and use 'setup' command to apply settings

```console
vi /etc/filebeat/filebeat.yml

# filebeat.yml

## Set the log path to the log path of your application
filebeat.inputs:
- type: log
  paths:
    - /directory/of/target/logs/*.log
    
## Set kafka hosts to your kafka server ip
output.kafka:
    hosts: ['your_kafka_server_ip:9094']

filebeat setup -e
```

Use Start / Stop / Status commands with systemctl to manipulate filebeat

```console
systemctl start filebeat
systemctl status filebeat
systemctl stop filebeat
```
