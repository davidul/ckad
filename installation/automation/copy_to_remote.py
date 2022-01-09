import os
import paramiko.client
import sys

password = sys.argv[1]
client = paramiko.SSHClient()
client.load_system_host_keys()
client.connect('10.0.1.18',username="david",password=password)
sftp = client.open_sftp()
sftp.put("C:/Users/davidul/IdeaProjects/_courses/_go/ckad/installation/docker/spring-boot-demo/Dockerfile", "/home/david/spring-boot-demo/Dockerfile")
sftp.put("C:/Users/davidul/IdeaProjects/_courses/_go/ckad/installation/automation/create_docker.py", "/home/david/spring-boot-demo/create_docker.py")
#sftp.put("C:/Users/davidul/IdeaProjects/_courses/_go/ckad/spring-boot-demo/target/spring-boot-demo-0.0.1-SNAPSHOT.jar", "/home/david/spring-boot-demo/spring-boot-demo-0.0.1-SNAPSHOT.jar")
sftp.close()
client.close()