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

NAME=inception

VOLUME="/home/omakran/data"

all:
	@echo "setting up the infrastructure"
	@mkdir -p $(VOLUME)/wordpress
	@mkdir -p $(VOLUME)/mariadb
	@docker-compose -p $(NAME) -f ./srcs/docker-compose.yml up --build -d

clean:
	@docker-compose -p $(NAME) -f ./srcs/docker-compose.yml down

fclean: clean
	@docker volume rm -f $$(docker volume ls -q)
	@docker rmi -f $$(docker images -qa)
	@sudo rm -rf $(VOLUME)/wordpress
	@sudo rm -rf $(VOLUME)/mariadb

re: fclean all

.PHONY: all clean fclean re