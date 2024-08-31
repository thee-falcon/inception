# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: omakran <omakran@student.1337.ma>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/30 21:53:38 by omakran           #+#    #+#              #
#    Updated: 2024/08/31 18:41:42 by omakran          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Target run the docker-compose file which starts up the conatiners
all:
	@docker-compose -f ./srcs/docker-compose.yml up
# builds and starts the containers using the Docker Compose
# --build to rebuild of the images before starting the containers
build:
	@docker-compose -f ./srcs/docker-compose.yml up  --build
# stopd and remove the containers
down:
	@docker-compose -f ./srcs/docker-compose.yml down
# remove the unused Docker data like stopped containers, unused networks, images and build cache
clean: down
	@docker system prune -af
# stops all running containers and the unused Docker data
fclean:
	@docker stop $$(docker ps -qa)
	@docker volume prune -f
	@docker network prune --force
	@docker system prune -af
# stratup the containers from scratch, It's used fully reset the environment
re:	fclean all
	@docker-compose -f ./srcs/docker-compose.yml up  --build

.PHONY	: all build down clean fclean re