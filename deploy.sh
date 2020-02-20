docker build -t dupred/multi-client:latest -t dupred/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dupred/multi-server:latest -t dupred/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dupred/multi-worker:latest -t dupred/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push dupred/multi-client:latest
docker push dupred/multi-server:latest
docker push dupred/multi-worker:latest
docker push dupred/multi-client:$SHA
docker push dupred/multi-server:$SHA
docker push dupred/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dupred/multi-server:$SHA
kubectl set image deployments/client-deployment client=dupred/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dupred/multi-worker:$SHA

