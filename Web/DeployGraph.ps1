#Do precompiled steps here and publish the Webapp as described here https://docs.microsoft.com/en-us/aspnet/mvc/overview/deployment/docker-aspnetmvc#publish-script
#Copy Dockerfile2 to /bin/Release/PublishOutput and rename to Dockerfile. Then do the following docker commands changing the name of the repo and tag version
docker build -t graphexplorer .
docker tag graphexplorer:latest jarvisux/graphexplorer:v3
docker push jarvisux/graphexplorer:v3

#use this to test and run locally
docker run -d --name testweb  jarvisux/graphexplorer:v3
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" testweb
#get IP address returned from inspect command and type this into a browser. You should see the app run locally.

# use this stop and remove local containers
docker rm testweb -f

#Use this to remove old local images 
docker rmi jarvisux/graphexplorer:v1

#To run images in Service Fabric from container registry that you pushed to.
Connect-ServiceFabricCluster [name ofcluster]
New-ServiceFabricComposeApplication -ApplicationName "fabric:/graphexplorer" -Compose "Cdocker-compose-prebuilt.yml"
Remove-ServiceFabricComposeApplication -ApplicationName "fabric:/graphexplorer" 