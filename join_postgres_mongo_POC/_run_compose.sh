#!/bin/sh

# mongo configuration
#########################################################################################################
MONGO_CONTAINER_NAME='mongo_poc'
POSTGRES_CONTAINER_NAME='postgres_poc'
PYTHON_CONTAINER_NAME='python_poc'

# stopping previous run
docker-compose -f docker/docker-compose.yml down
# start new one
docker-compose -f docker/docker-compose.yml up -d

# waiting till mongo spin up
sleep 10

#loading mock data
docker exec -it ${MONGO_CONTAINER_NAME} bash /home/set_up_mongo_env.sh
docker exec -it ${POSTGRES_CONTAINER_NAME} bash /home/set_up_postgres_env.sh
#execute python
docker exec -it ${PYTHON_CONTAINER_NAME} python /home/join_psql_mongo.py
