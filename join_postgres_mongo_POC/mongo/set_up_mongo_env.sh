USERNAME='mongo'
MONGO_PASSWORD='mongo'

mongo < /home/src/objects_creation.sh

mongoimport -u ${USERNAME} \
            -p ${MONGO_PASSWORD} \
            --authenticationDatabase 'admin' \
            -d 'test_db' \
            --collection 'movies' \
            --file /home/src/FF6_record.json
