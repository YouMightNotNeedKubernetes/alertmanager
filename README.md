# alertmanager
A high-availability alertmanager stack for Docker Swarm

## Getting Started

You might need to create swarm-scoped overlay network called `dockerswarm_monitoring` for all the stacks to communicate if you haven't already.

```sh
$ docker network create --driver overlay --attachable dockerswarm_monitoring
```

We provided a base configuration file for Prometheus & Alertmanager. You can find it in the `config` folder.  
Please make a copy as `configs/alertmanager.yml`, and add any additional configuration you need.

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
