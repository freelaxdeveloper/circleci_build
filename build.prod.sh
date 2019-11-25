sudo docker system prune -af
CONTAINER_IMAGE=$(grep CONTAINER_IMAGE .env | cut -d '=' -f2)

sudo $(aws ecr get-login --no-include-email --region us-east-1)
sudo docker image pull $CONTAINER_IMAGE
#docker kill $(docker ps -q)
#docker_clean_ps
#docker rmi $(docker images -a -q)
#sudo docker system prune -af
#docker builder prune
sudo docker-compose -f docker-compose.prod.yml stop web
sudo docker-compose -f docker-compose.prod.yml rm -f
sudo docker-compose -f docker-compose.prod.yml up -d
sleep 3
sudo docker exec web sh -c "cd /code && php artisan migrate --force"
