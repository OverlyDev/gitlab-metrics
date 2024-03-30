.PHONY: up
up:
	@mkdir -p ./gitlab/config ./gitlab/data ./gitlab/logs ./gitlab-runner
	@docker-compose up -d

.PHONY: status
status:
	@echo "Waiting for gitlab"
	@while [ "`docker inspect -f {{.State.Health.Status}} gitlab`" != "healthy" ]; do sleep 2; done
	@echo "gitlab is up"

.PHONY: down
down:
	@docker-compose down

.PHONY: clean
clean: down
	@sudo rm -rf ./gitlab

.PHONY: exec
exec:
	@docker exec -it gitlab /bin/bash
