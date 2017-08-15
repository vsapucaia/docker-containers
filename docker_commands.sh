# Docker container initialization

touch docker-compose.yml

# Inside yml:
version: '3'
services:
  app:
    image: gisce/tilemill
    # entrypoint: /bin/bash
    working_dir: /app
    volumes:
      - .:/app


# IMAGES
docker images
docker images -a
docker rmi [Image_name | Image_id]

# CONTAINERS
docker ps -a

# remove containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# running container commands
docker-compose run app date
docker-compose run app bash
docker-compose up
service --status-all

# commit container to another image
docker commit -c "EXPOSE 20008-20009" 2e9ba3f563cb gisce/tilemill:mbutil

# Attach a container
docker exec -i -t a00b5bd21c30 /bin/bash
