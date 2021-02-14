import pymongo
import psycopg2
import json

mongo_host = 'mongo_poc'
postgres_host = 'postgres_poc'

#############
#   MONGO   #
#############

def get_data_from_mongo():
    myclient = pymongo.MongoClient(f"mongodb://{mongo_host}:27017/", username='mongo', password='mongo')
    mydb = myclient["test_db"]
    mycol = mydb["movies"]

    x = mycol.find_one({"name":"Fast & Furious 6"})
    #print (x["_id"])

    return x


#################
#   postgres    #
#################

def connec_postgres():
    return psycopg2.connect(
        host = postgres_host,
        port = 5432,
        #database = 'devops_sch', 
        user = 'postgres', 
        password = 'postgres',
    )

def get_data_from_postgres(one=False):

    conn = connec_postgres()
    curr = conn.cursor()
    query = '''
        select
            movie_id,
            name,
            year
        from devops_sch.movies
        where name = 'Fast & Furious 6';
    '''

    curr.execute(query)
    r = [dict((curr.description[i][0], value) for i, value in enumerate(row)) for row in curr.fetchall()]

    curr.connection.close()
    return (r[0] if r else None) if one else r

#########
# main  #
#########

if __name__ == '__main__':

    json_output = get_data_from_postgres()
    # solving only for one row in answerset
    #for i in json_output:
    #    print(type(i))
    
    # data in json format from postgres
    psq_json_data = json_output[0]
    #psq_json_data = json.dumps(json_output)
    #print (psq_json_data)
    

    mongo_json_data = get_data_from_mongo()
    #print(mongo_json_data)
    movie_year = mongo_json_data['rating']
    #print (movie_year)

    psq_json_data['rating'] =  movie_year
    print(psq_json_data)

