# docker-jenkins makefile

CONTAINER = jenkins
PORTS = -p 8080:8080 -p 50000:50000
VOLUMES = -v `pwd`/jenkins_home:/var/jenkins_home

.PHONY: container run

container :
	docker pull $(CONTAINER) .

clean :
	rm -rf jenkins_home/*

run :
	docker run --restart=always --name $(CONTAINER) -i -d $(PORTS) $(ENVS) $(VOLUMES) -t $(CONTAINER)

kill :
	docker kill $(CONTAINER)
	docker rm $(CONTAINER)

restart :
	docker kill $(CONTAINER)
	docker rm $(CONTAINER)
	docker run --restart=always --name $(CONTAINER) -i -d $(PORTS) $(ENVS) $(VOLUMES) -t $(CONTAINER)

attach:
	docker attach $(CONTAINER)

bash:
	docker exec -ti $(CONTAINER) /bin/bash

tail:
	docker logs -f $(CONTAINER)
