#!/bin/sh

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#   IN development phase
#    - not yet working
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# mongo configuration
#########################################################################################################
MONGO_CONTAINER_NAME='mongo_poc'
MONGO_USERNAME='mongo'
MONGO_PASSWORD='mongo'
MONGO_HOSTNAME='localhost'
MONGO_PORT=27017

POSTGRES_CONTAINER_NAME='postgres_poc'
POSTGRES_USERNAME='postgres'
POSTGRES_PASSWORD='postgres'
POSTGRES_HOSTNAME='localhost'
POSTGRES_PORT=5432

PYTHON_CONTAINER_NAME='python_poc'
PYTHON_IMAGE_NAME="python_image"
PYTHON_IMAGE_TAG='3.9.1'

# stopping previous run
docker-compose -f docker/docker-compose.yml down
# start new one
docker-compose -f docker/docker-compose.yml up -d

#loading mock data
docker exec -it ${MONGO_CONTAINER_NAME} bash /home/set_up_mongo_env.sh
docker exec -it ${POSTGRES_CONTAINER_NAME} bash /home/set_up_postgres_env.sh
#execute python
docker exec -it ${PYTHON_CONTAINER_NAME} python /home/join_psql_mongo.py
