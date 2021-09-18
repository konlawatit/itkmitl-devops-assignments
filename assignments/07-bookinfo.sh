#!/bin/sh
git clone -b dev git@github.com:konlawatit/itkmitl-bookinfo-ratings.git ~/bookinfo/ratings
git clone -b dev git@github.com:konlawatit/itkmitl-bookinfo-details.git ~/bookinfo/details
git clone -b dev git@github.com:konlawatit/itkmitl-bookinfo-reviews.git ~/bookinfo/reviews
git clone -b dev git@github.com:konlawatit/itkmitl-bookinfo-productpage.git ~/bookinfo/productpage

docker build -t ratings ~/bookinfo/ratings
docker run -d --name mongodb -p 27017:27017 -v ~/bookinfo/ratings/databases:/docker-entrypoint-initdb.d bitnami/mongodb:5.0.2-debian-10-r2
docker run -d --name ratings -p 8080:8080 --link mongodb:mongodb -e SERVICE_VERSION=v2 -e 'MONGO_DB_URL=mongodb://mongodb:27017/ratings' ratings

docker build -t details ~/bookinfo/details
docker run -d --name details -p 8081:8081 details

docker build -t reviews ~/bookinfo/reviews
docker run -d --name reviews -p 8082:9080 --link ratings:ratings -e 'RATINGS_SERVICE=http://ratings:8080' -e 'ENABLE_RATINGS=true' reviews

docker build -t productpage ~/bookinfo/productpage
docker run -d --name productpage -p 8083:9080 --link details:details --link ratings:ratings --link reviews:reviews -e 'DETAILS_HOSTNAME=http://details:8081' -e 'RATINGS_HOSTNAME=http://ratings:8080' -e 'REVIEWS_HOSTNAME=http://reviews:9080' productpage