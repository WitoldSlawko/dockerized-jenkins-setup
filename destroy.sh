docker-compose down
sudo rm -rf ./jenkins_home/* | true
cd ./jenkins_home/ && sudo  rm -rf .config .lastStarted .cache .groovy .java | true
cd ../ 
docker image rm dockerized-jenkins-setup_jenkins
