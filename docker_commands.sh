# docker build giving a name to the image (. indicates the path of Dockerfile)
# to refresh the requirements.txt
docker build -t process_qa_27 .

# run/start container
docker run -it --rm [image name]
# start container opening bash
docker run -i -t process_qa_27 /bin/bash

# Attach a container
docker exec -i -t 0e48e3c2d156 /bin/bash

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
docker-compose run mapnik-psql bash
docker-compose up
service --status-all

# commit container to another image
docker commit -c "EXPOSE 20008-20009" 2e9ba3f563cb gisce/tilemill:mbutil
