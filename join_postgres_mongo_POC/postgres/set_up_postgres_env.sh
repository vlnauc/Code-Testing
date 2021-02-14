USERNAME='postgres'
POSTGRES_PASSWORD='postgres'
HOSTNAME='localhost'
PORT=5432

echo "*****************************************"
echo "Lets wait for Postgres start-up"
echo "*****************************************"
until PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${HOSTNAME} -U ${USERNAME} -c '\q'; do
  sleep 1
done
echo "*****************************************"
echo "PSQL ready"
echo "*****************************************"

PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${HOSTNAME} -p ${PORT} -U ${USERNAME} --file /home/src/create_schema.psql
PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${HOSTNAME} -p ${PORT} -U ${USERNAME} --file /home/src/movies.ddl
PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${HOSTNAME} -p ${PORT} -U ${USERNAME} --file /home/src/movies.dml
