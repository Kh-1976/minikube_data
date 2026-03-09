#!/bin/bash

# Получаем имя пода scheduler
POD_NAME=$(minikube kubectl -- get pods -n airflow -l component=scheduler -o jsonpath="{.items[0].metadata.name}")

# Получаем имя пода worker
WORKER_POD=$(minikube kubectl -- get pods -n airflow -l component=worker -o jsonpath="{.items[0].metadata.name}")

echo "Installing packages in scheduler pod: $POD_NAME"
# Устанавливаем пакеты в scheduler
minikube kubectl -- exec -it $POD_NAME -n airflow -- /bin/bash -c "pip install confluent-kafka kafka-python"

echo "Installing packages in worker pod: $WORKER_POD"
# Устанавливаем пакеты в worker
minikube kubectl -- exec -it $WORKER_POD -n airflow -- /bin/bash -c "pip install confluent-kafka kafka-python"

echo "Verifying installation in scheduler:"
minikube kubectl -- exec -it $POD_NAME -n airflow -- pip list | grep kafka

echo "Verification in worker:"
minikube kubectl -- exec -it $WORKER_POD -n airflow -- pip list | grep kafka

echo "All packages installed successfully!"
