#!/bin/bash

# create docker network
docker network create main-network

# Define the list of directories in the order to run docker-compose
services=("04-postgresql")
# services=("01-prometheus" "02-grafana" "03-elk-stack" "04-postgresql")

# Loop through each service directory and run docker-compose up -d
for service in "${services[@]}"; do
  echo "Starting service in $service..."
  (cd "$service" && docker-compose up -d)
  if [ $? -ne 0 ]; then
    echo "Failed to start service in $service. Exiting."
    exit 1
  fi
  echo "Service in $service started successfully."
done

echo "All services started successfully."
