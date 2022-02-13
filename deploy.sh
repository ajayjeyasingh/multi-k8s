docker build -t ajayjs/multi-client:latest -t ajayjs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajayjs/multi-server:latest -t ajayjs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajayjs/multi-worker:latest -t ajayjs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ajayjs/multi-client:latest
docker push ajayjs/multi-client:$SHA
docker push ajayjs/multi-server:latest
docker push ajayjs/multi-server:$SHA
docker push ajayjs/multi-worker:latest
docker push ajayjs/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajayjs/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajayjs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajayjs/multi-worker:$SHA