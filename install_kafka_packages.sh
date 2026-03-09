#!/bin/bash

# Получаем имя пода scheduler
SCHEDULER_NAME=$(minikube kubectl -- get pods -n airflow -l component=scheduler -o jsonpath="{.items[0].metadata.name}")
# Получаем имя пода worker
WORKER_POD=$(minikube kubectl -- get pods -n airflow -l component=worker -o jsonpath="{.items[0].metadata.name}")
# Получаем имя пода dag-processor
DAG_POD=$(minikube kubectl -- get pods -n airflow -l component=dag-processor -o jsonpath="{.items[0].metadata.name}")
# Получаем имя пода triggerer
TRIGGER_POD=$(minikube kubectl -- get pods -n airflow -l component=triggerer -o jsonpath="{.items[0].metadata.name}")

echo "Installing packages in scheduler pod: $SCHEDULER_NAME"
# Устанавливаем пакеты в scheduler
minikube kubectl -- exec -it $SCHEDULER_NAME -n airflow -- /bin/bash -c "pip install confluent-kafka kafka-python"

echo "Installing packages in worker pod: $WORKER_POD"
# Устанавливаем пакеты в worker
minikube kubectl -- exec -it $WORKER_POD -n airflow -- /bin/bash -c "pip install confluent-kafka kafka-python"

echo "Installing packages in worker pod: $DAG_POD"
# Устанавливаем пакеты в worker
minikube kubectl -- exec -it $DAG_POD -n airflow -- /bin/bash -c "pip install confluent-kafka kafka-python"

echo "Installing packages in worker pod: $TRIGGER_POD"
# Устанавливаем пакеты в worker
minikube kubectl -- exec -it $TRIGGER_POD -n airflow -- /bin/bash -c "pip install confluent-kafka kafka-python"

echo "All packages installed successfully!"
