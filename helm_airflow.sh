#!/bin/bash

echo "=== Обновление репозитория Apache Airflow ==="
helm repo update

echo "=== Установка Airflow через Helm ==="
helm upgrade --install airflow apache-airflow/airflow \
  --namespace airflow --create-namespace \
  -f https://raw.githubusercontent.com/Kh-1976/minikube_data/main/values_git_sync.yaml

echo "=== Ожидание 7 минут для полного запуска всех подов ==="
echo "Ожидание началось: $(date)"
sleep 420  # 7 минут = 420 секунд
echo "Ожидание завершено: $(date)"

echo "=== Запуск скрипта install_kafka_packages.sh ==="
# Загружаем и запускаем скрипт установки Kafka пакетов
curl -s https://raw.githubusercontent.com/Kh-1976/minikube_data/main/install_kafka_packages.sh | bash

echo "=== Все операции завершены ==="
