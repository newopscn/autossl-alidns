all: push

TAG=`cat TAG`
APP=alidns
IMAGE=hub.digi-sky.com/base/${APP}:${TAG}
TX_IMAGE=ccr.ccs.tencentyun.com/digisky-base/${APP}:${TAG}

build:
	docker build -t ${IMAGE} .

push: build
	docker push ${IMAGE}

push2tx: build
	docker tag ${IMAGE} ${TX_IMAGE}
	docker push ${TX_IMAGE}

run:
	docker run -it -d --name ${APP} ${IMAGE}

conn:
	docker exec -it ${APP} bash

clean:
	docker stop ${APP}
	docker rm ${APP}

.PHONY: push
