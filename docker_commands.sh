# docker build giving a name to the image (. indicates the path of Dockerfile)
# to refresh the requirements.txt
docker build -t process_qa_27 .

# run/start container
docker run -it --rm [image name]
# start container opening bash
docker run -p 8080:80 -i -t 7fadaca3867f /bin/bash

# Attach a container
docker exec -i -t efab6ccf7ab2 /bin/bash

# IMAGES
docker images
docker images -a
docker rmi [Image_name | Image_id]

# CONTAINERS
docker ps -a

# remove containers
docker stop $(docker ps -a -q) 
docker rm $(docker ps -a -q)

# commit container to another image
docker commit -c "EXPOSE 20008-20009" 2e9ba3f563cb gisce/tilemill:mbutil

# DOCKER-COMPOSE
#_-----------------------------
# running container commands
docker-compose up
docker-compose run app date
docker-compose run mapnik-psql bash

# rebuild image
docker-compose build

#check docker services
service --status-all


# restart mapnik container
docker exec -t -i mapnik_mapnik_1 supervisorctl restart renderd apache2