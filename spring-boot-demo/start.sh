docker build . -t spring-boot-demo

docker network create --driver=bridge --subnet=172.19.101.0/16 spring-boot-network

docker run -d --name spring-mongo --network spring-boot-network -p 27017:27017 --ip 172.19.101.3 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=admin mongo


docker run -d --name spring-boot-demo --network spring-boot-network -p 8080:8080 --ip 172.19.101.4 spring-boot-demo


docker stop spring-boot-demo
docker rm spring-boot-demo

docker stop spring-mongo
docker rm spring-mongo

