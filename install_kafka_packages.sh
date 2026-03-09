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
# Устанавливаем пакеты в scheduler (без -it)
minikube kubectl -- exec $SCHEDULER_NAME -n airflow -- /bin/bash -c "pip install --upgrade pip && pip install confluent-kafka kafka-python faker"

echo "Installing packages in worker pod: $WORKER_POD"
# Устанавливаем пакеты в worker (без -it)
minikube kubectl -- exec $WORKER_POD -n airflow -- /bin/bash -c "pip install --upgrade pip && pip install confluent-kafka kafka-python faker"

echo "Installing packages in dag-processor pod: $DAG_POD"
# Устанавливаем пакеты в dag-processor (без -it)
minikube kubectl -- exec $DAG_POD -n airflow -- /bin/bash -c "pip install --upgrade pip && pip install confluent-kafka kafka-python faker"

echo "Installing packages in triggerer pod: $TRIGGER_POD"
# Устанавливаем пакеты в triggerer (без -it)
minikube kubectl -- exec $TRIGGER_POD -n airflow -- /bin/bash -c "pip install --upgrade pip && pip install confluent-kafka kafka-python faker"

echo "All packages installed successfully!"
