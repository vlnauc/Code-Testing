MONGO_USERNAME='mongo'
MONGO_PASSWORD='mongo'

mongo -u ${MONGO_USERNAME} \
      -p ${MONGO_PASSWORD} \
      --authenticationDatabase 'admin' \
      < /home/src/objects_creation.sh

mongoimport -u ${MONGO_USERNAME} \
            -p ${MONGO_PASSWORD} \
            --authenticationDatabase 'admin' \
            -d 'test_db' \
            --collection 'movies' \
            --file /home/src/FF6_record.json
