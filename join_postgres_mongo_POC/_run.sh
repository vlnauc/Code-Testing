#!/bin/sh

# mongo configuration
#########################################################################################################
MONGO_CONTAINER_NAME='mongo_poc'
MONGO_USERNAME='mongo'
MONGO_PASSWORD='mongo'
MONGO_HOSTNAME='localhost'
MONGO_PORT=27017

# stopping and cleainig docker containers
docker stop ${MONGO_CONTAINER_NAME}
docker container prune -f
docker pull mongo:4.4

#run docker container
docker run -d --name ${MONGO_CONTAINER_NAME} \
            -e MONGO_INITDB_ROOT_USERNAME=${MONGO_USERNAME} \
            -e MONGO_INITDB_ROOT_PASSWORD=${MONGO_PASSWORD} \
            -v $PWD/mongo:/home \
            mongo

# just print of IP 
echo "Mongo docker  DB is running on IP:"
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${MONGO_CONTAINER_NAME}

# sleep 10 seconds - waiting to start mongo docker
sleep 10

docker exec -it ${MONGO_CONTAINER_NAME} bash /home/set_up_mongo_env.sh

#postgres configuration
#########################################################################################################
POSTGRES_CONTAINER_NAME='postgres_poc'
POSTGRES_USERNAME='postgres'
POSTGRES_PASSWORD='postgres'
POSTGRES_HOSTNAME='localhost'
POSTGRES_PORT=5432

docker stop ${POSTGRES_CONTAINER_NAME}
docker container prune -f
docker pull postgres:13.2

docker run -d --name ${POSTGRES_CONTAINER_NAME} \
            -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
             -v $PWD/postgres:/home \
            postgres

echo "Postgres docker is running on IP:"
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${POSTGRES_CONTAINER_NAME}

docker exec -it ${POSTGRES_CONTAINER_NAME} bash /home/set_up_postgres_env.sh


#########################################################################################################
# python configuration
#########################################################################################################
PYTHON_CONTAINER_NAME='python_poc'
PYTHON_IMAGE_NAME="python_image"
PYTHON_IMAGE_TAG='3.9.1'

docker stop ${PYTHON_CONTAINER_NAME}
docker container prune -f
docker build -f $PWD/docker/DockerFile#python -t ${PYTHON_IMAGE_NAME}:${PYTHON_IMAGE_TAG} .

docker run -it -d --name ${PYTHON_CONTAINER_NAME} \
            -v $PWD/python:/home \
            ${PYTHON_IMAGE_NAME}:${PYTHON_IMAGE_TAG}


#python3 ./python/join_psql_mongo.py


#########################################################################################################
# network configuration
#########################################################################################################
NETWORK_NAME=network_poc
docker network rm ${NETWORK_NAME}
docker network create -d bridge --subnet 172.25.0.0/16 ${NETWORK_NAME}
docker network connect ${NETWORK_NAME} ${MONGO_CONTAINER_NAME}
docker network connect ${NETWORK_NAME} ${POSTGRES_CONTAINER_NAME}
docker network connect ${NETWORK_NAME} ${PYTHON_CONTAINER_NAME}

# execution of python
docker exec python_poc python /home/join_psql_mongo.py
