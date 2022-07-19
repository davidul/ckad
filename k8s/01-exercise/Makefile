include .env

# tag and push to local registry
deploy:
	minikube cache add ${SPRING_BOOT_IMAGE_NAME}:latest
	#docker tag ${SPRING_BOOT_IMAGE_NAME} registry.dev.svc.cluster.local:5001/${SPRING_BOOT_IMAGE_NAME}
	#docker push registry.dev.svc.cluster.local:5001/${SPRING_BOOT_IMAGE_NAME}

k8s-pods:
	kubectl -f pod/spring-boot.yml apply

k8s-deploy:
	kubectl -f deployment/spring-boot.yml apply
