DOCKER_NETWORK = docker-calmar_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t calvaluscalmar/hadoop-base:$(current_branch) ./hadoop-base
	docker build -t calvaluscalmar/calvalus-base:$(current_branch) ./calvalus-base
	docker build -t calvaluscalmar/tomcat-base:$(current_branch) ./tomcat-base
	docker build -t calvaluscalmar/hadoop-namenode:$(current_branch) ./namenode
	docker build -t calvaluscalmar/hadoop-datanode:$(current_branch) ./datanode
	docker build -t calvaluscalmar/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t calvaluscalmar/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t calvaluscalmar/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t calvaluscalmar/hadoop-submit:$(current_branch) ./submit
	docker build -t calvaluscalmar/calvalus-portal:$(current_branch) ./calvalus-portal
	docker build -t calvaluscalmar/geoserver:$(current_branch) ./geoserver

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvaluscalmar/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvaluscalmar/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvaluscalmar/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvaluscalmar/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} calvaluscalmar/hadoop-base:$(current_branch) hdfs dfs -rm -r /input
