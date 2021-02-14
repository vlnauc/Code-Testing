#!/bin/sh

# mongo configuration
#########################################################################################################
DOCKER_MONGO_NAME='mongo_poc'
USERNAME='mongo'
MONGO_PASSWORD='mongo'
HOSTNAME='localhost'
PORT=27017

# stopping and cleainig docker containers
docker stop ${DOCKER_MONGO_NAME}
docker container prune -f
docker pull mongo:latest

#run docker container
docker run -d --name ${DOCKER_MONGO_NAME} \
            -e MONGO_INITDB_ROOT_USERNAME=${USERNAME} \
            -e MONGO_INITDB_ROOT_PASSWORD=${MONGO_PASSWORD} \
            -p ${PORT}:${PORT} \
            -v $PWD/mongo:/home \
            mongo

# just print of IP 
echo "Mongo docker  DB is running on IP:"
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${DOCKER_MONGO_NAME}

# sleep 5 seconds - waiting to start mongo docker
sleep 10

docker exec -it ${DOCKER_MONGO_NAME} bash /home/set_up_mongo_env.sh

# creating DB and collection
#mongo   --host ${HOSTNAME} \
#        --port ${PORT} \
#        -u ${USERNAME} \
#        -p ${MONGO_PASSWORD} \
#        --authenticationDatabase 'admin' \
#        < ./mongo/objects_creation.sh


# importing data to MongoDB
#mongoimport --host ${HOSTNAME} \
#            --port ${PORT} \
#            -u ${USERNAME} \
#            -p ${MONGO_PASSWORD} \
#            --authenticationDatabase 'admin' \
#            -d 'test_db' \
#            --collection 'movies' \
#            --file ./mongo/FF6_record.json

#postgres configuration
#########################################################################################################
DOCKER_PSQL_NAME='postgres_poc'
USERNAME='postgres'
POSTGRES_PASSWORD='postgres'
HOSTNAME='localhost'
PORT=5432

docker stop ${DOCKER_PSQL_NAME}
docker container prune -f
docker pull postgres:latest

docker run -d --name ${DOCKER_PSQL_NAME} \
            -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
            -p ${PORT}:${PORT} \
            -v $PWD/postgres:/home \
            postgres

echo "Postgres docker is running on IP:"
docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${DOCKER_PSQL_NAME}

docker exec -it ${DOCKER_PSQL_NAME} bash /home/set_up_postgres_env.sh


#echo "*****************************************"
#echo "Lets wait for Postgres start-up"
#echo "*****************************************"
#until PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${HOSTNAME} -U ${USERNAME} -c '\q'; do
#  sleep 1
#done
#echo "*****************************************"
#echo "PSQL ready"
#echo "*****************************************"
#
#PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${HOSTNAME} -p ${PORT} -U ${USERNAME} --file ./postgres/create_schema.psql
#PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${HOSTNAME} -p ${PORT} -U ${USERNAME} --file ./postgres/movies.ddl
#PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${HOSTNAME} -p ${PORT} -U ${USERNAME} --file ./postgres/movies.dml

#########################################################################################################
# python configuration
#########################################################################################################


python3 ./python/join_psql_mongo.py





