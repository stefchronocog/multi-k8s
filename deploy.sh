docker build -t stefcognizant/multi-client:latest -t stefcognizant/multi-client/$SHA -f ./client/Dockerfile ./client
docker build -t stefcognizant/multi-server:latest -t stefcognizant/multi-server/$SHA -f ./server/Dockerfile ./server
docker build -t stefcognizant/multi-worker:latest -t stefcognizant/multi-worker/$SHA -f ./worker/Dockerfile ./worker

docker push stefcognizant/multi-client:latest
docker push stefcognizant/multi-server:latest
docker push stefcognizant/multi-worker:latest

docker push stefcognizant/multi-client:$SHA
docker push stefcognizant/multi-server:$SHA
docker push stefcognizant/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stefcognizant/multi-server:$SHA
kubectl set image deployments/client-deployment client=stefcognizant/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stefcognizant/multi-worker:$SHA