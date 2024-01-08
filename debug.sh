#!/bin/bash
docker build -t app:7 -f Dockerfile_7 .
docker build -t app:8 -f Dockerfile_8 .


docker run -d -e COMPlus_EnableDiagnostics=0 --name app app:7
sleep 2
docker exec app datadog/dd-dotnet.sh check process 1
docker rm -f app


docker run -d --name app app:7
sleep 2
docker exec app datadog/dd-dotnet.sh check process 1
docker rm -f app


docker run -d -e COMPlus_EnableDiagnostics=0 --name app app:8
sleep 2
docker exec app datadog/dd-dotnet.sh check process 1
docker rm -f app


docker run -d --name app app:8
sleep 2
docker exec app datadog/dd-dotnet.sh check process 1
docker rm -f app
