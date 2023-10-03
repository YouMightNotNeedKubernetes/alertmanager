docker_stack_name = alertmanager

it:
	@echo "make [configs|deploy|destroy]"

.PHONY: configs
configs:
	test -f "configs/alertmanager.yml" || cp configs/alertmanager.base.yml configs/alertmanager.yml

deploy: configs
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
