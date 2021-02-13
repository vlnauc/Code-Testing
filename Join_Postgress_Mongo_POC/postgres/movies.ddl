CREATE TABLE devops_sch.movies (
	movie_id serial PRIMARY KEY,
	name VARCHAR ( 50 ) UNIQUE NOT NULL,
	year INTEGER
);

