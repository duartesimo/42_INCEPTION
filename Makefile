DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml
DATA_DIR = /home/nsimao/data

all: build

build:
	mkdir -p $(DATA_DIR)/mysql
	mkdir -p $(DATA_DIR)/wordpress
	@$(DOCKER_COMPOSE) up --build -d

up:
	@$(DOCKER_COMPOSE) up -d

down:
	@$(DOCKER_COMPOSE) down

clean:
	@$(DOCKER_COMPOSE) down -v

fclean: clean
	rm -rf $(DATA_DIR)
	docker system prune -a -f

restart: down up

.PHONY: all build up down clean fclean restart