docker build -t kothamasu/multi-client:latest -t kothamasu/multi-client:$GIT_SHA -f ./client/Dockerfile:latest ./client
docker build -t kothamasu/multi-server:latest -t kothamasu/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t kothamasu/multi-worker:latest -t kothamasu/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push kothamasu/multi-client:$GIT_SHA
docker push kothamasu/multi-worker:$GIT_SHA
docker push kothamasu/multi-server:$GIT_SHA

docker push kothamasu/multi-client:latest
docker push kothamasu/multi-worker:latest
docker push kothamasu/multi-server:latest


kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kothamasu/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment server=kothamasu/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment server=kothamasu/multi-worker:$GIT_SHA