docker build -t dennisdurairaj/multi-client:latest -t dennisdurairaj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dennisdurairaj/multi-server:latest -t dennisdurairaj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dennisdurairaj/multi-worker:latest -t dennisdurairaj/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dennisdurairaj/multi-client:latest
docker push dennisdurairaj/multi-client:$SHA
docker push dennisdurairaj/multi-server:latest
docker push dennisdurairaj/multi-server:$SHA
docker push dennisdurairaj/multi-worker:latest
docker push dennisdurairaj/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dennisdurairaj/multi-server:$SHA
kubectl set image deployments/client-deployment client=dennisdurairaj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dennisdurairaj/multi-worker:$SHA
