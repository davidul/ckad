include .env

build:
	docker build -t ${SPRING_BOOT_IMAGE_NAME} ${SPRING_BOOT_APP_DIR}

run:
	docker-compose -f ${SPRING_BOOT_APP_DIR}/docker-compose.yml --env-file .env up