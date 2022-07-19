include .env

build:
	$(MAKE) -C ${SPRING_BOOT_APP_DIR}

run:
	docker-compose -f ${SPRING_BOOT_APP_DIR}/docker-compose.yml --env-file .env up