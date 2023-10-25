# alertmanager
A high-availability alertmanager stack for Docker Swarm

## Getting Started

As a recommendation, you should only have Alertmanager deployed per Docker Swarm Cluster.

Before you start, you need to carefully plan your deployment.
- Consider how many instances you want to deploy.
- Node placement for each instance.
- etc...

You might need to create swarm-scoped overlay network called `dockerswarm_monitoring` for all the stacks to communicate if you haven't already.

```sh
$ docker network create --scope swarm --driver overlay --attachable dockerswarm_monitoring
```

We provided a base configuration file for Prometheus & Alertmanager. You can find it in the `config` folder.  
Please make a copy as `configs/alertmanager.yml`, and add any additional configuration you need.

## High Availability

This stack is designed to be highly available.

By default, it will deploy 3 replicas of Alertmanager. Having more than 3 replicas is way too much for a small cluster.  
If you want to change the number of replicas, you can do so by changing the `replicas` value in the `docker-compose.yml` file.

![image](https://github.com/YouMightNotNeedKubernetes/alertmanager/assets/4363857/af22bf22-affa-42b0-8c8a-8a93ae667ef3)

### Server placement

A `node.labels.alertmanager` label is used to determine which nodes the service can be deployed on.

The deployment uses both placement **constraints** & **preferences** to ensure that the servers are spread evenly across the Docker Swarm manager nodes and only **ALLOW** one replica per node.

![placement_prefs](https://docs.docker.com/engine/swarm/images/placement_prefs.png)

> See https://docs.docker.com/engine/swarm/services/#control-service-placement for more information.

#### List the nodes
On the manager node, run the following command to list the nodes in the cluster.

```sh
docker node ls
```

#### Add the label to the node
On the manager node, run the following command to add the label to the node.

Repeat this step for each node you want to deploy the service to. Make sure that the number of node updated matches the number of replicas you want to deploy.

**Example deploy service with 3 replicas**:
```sh
docker node update --label-add alertmanager=true <node-1>
docker node update --label-add alertmanager=true <node-2>
docker node update --label-add alertmanager=true <node-3>
```

## Deployment

To deploy the stack, run the following command:

```sh
$ make deploy
```

## Destroy

To destroy the stack, run the following command:

```sh
$ make destroy
```

## Troubleshooting

### Sending test alert

You can send a test alert to the alertmanager by running the following command:

```sh
# Replace 127.0.0.1 with the IP address of the alertmanager service
curl -H 'Content-Type: application/json' -d '[{"labels":{"alertname":"myalert"}}]' http://127.0.0.1:9093/api/v1/alerts
```
