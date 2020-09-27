#! /bin/sh
docker-compose up --build -d

echo After 13 seconds will let Node 2 join cluster && sleep 13
docker exec rabbitNode2 rabbitmqctl stop_app
docker exec rabbitNode2 rabbitmqctl join_cluster rabbit@node1.rabbit
docker exec rabbitNode2 rabbitmqctl start_app

echo After 3 seconds will set High avilabilty policy && sleep 3
docker exec rabbitNode2 rabbitmqctl set_policy ha-sync "." "{\"ha-mode\":\"all\",\"ha-sync-mode\":\"automatic\"}"
