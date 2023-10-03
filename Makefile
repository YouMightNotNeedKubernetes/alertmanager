docker_stack_name = promstack


it:
	@echo "make [deploy|destroy]"

deploy:
	test -f "configs/prometheus.yml" || cp configs/prometheus.base.yml configs/prometheus.yml
	test -f "configs/alertmanager.yml" || cp configs/alertmanager.base.yml configs/alertmanager.yml
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
