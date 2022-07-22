# Swarm Setup Guide

Basic guide to setup docker swarm for monitoring system.

You **BETTER** read [Docker official docs](https://docs.docker.com/get-started/) than to read this.

This document is basically copy of official docs.

## Install

> Based on over CentOS 8

```console
sudo yum install -y yum-utils

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

Install the yum-utils package (which provides the yum-config-manager utility) and set up the repository.

```console
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

Install the latest version of Docker Engine, containerd, and Docker Compose.

```console
yum list docker-ce --showduplicates | sort -r

sudo yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io docker-compose-plugin
```

Or list the available versions in the repo, then select and install.

```console
sudo systemctl start docker
```

Start Docker.

```console
sudo systemctl status docker

● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled; vendor preset: disabled)
   Active: active (running) since...
```

If status is active (running), the installation is successful.

## Run

> The following ports must be available. On some systems, these ports are open by default.
> - TCP port 2377 : cluster management communications
> - TCP/UDP port 7946 : communication among nodes
> - UDP port 4789 : overlay network traffic

```console
docker swarm init --advertise-addr <MANAGER-IP>
```

Create a new swarm with advertise address (IP of Manager Node).

```console
docker swarm join-token worker

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-<WORKER-TOKEN> <MANAGER-IP>:2377
```

Run output commands in worker server to join the swarm.

```console
docker node ls

ID       HOSTNAME     STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
ID_1 *   HOSTNAME_1   Ready     Active         Leader           20.10.17
ID_2     HOSTNAME_2   Ready     Active                          20.10.17
ID_3     HOSTNAME_3   Ready     Active                          20.10.17
```

Run the docker node ls command to view information about nodes.