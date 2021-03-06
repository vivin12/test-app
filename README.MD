## Spring Boot Demo app 

### Containerizing the Application 

We have 2 example Dockerfiles that we used to containerize the application. In both cases we are creating the docker image
using multi stage docker builds. 
With multi-stage Docker builds, we use multiple FROM statements for each build stage. 
Every FROM statement creates a new base layer, and discards everything we don’t need from the previous FROM stage and that's why this is the ideal way.

1. In the file ```olp.Dockerfile``` from the root directory of the repo we are using open liberty as the base image. 

2. Second one is ```Dockerfile``` and we are using IBM websphere liberty as the base image.

There are different tags that you can use for the base image. Refer this doc for the different available tags - https://hub.docker.com/_/websphere-liberty

The kernel image we are using contains just the Liberty kernel and no additional runtime features. 
This image is the recommended basis for custom built images, so that they can contain only the features required for a specific application. 
For example, the following Dockerfile starts with this image, copies in the server.xml that lists the features required by the application, and then uses the configure.sh script to download those features from the online repository.
If you want to build the smallest possible WebSphere Liberty application image you can start with the kernel tag, add your artifacts, and run configure.sh to grow the set of features to be fit-for-purpose.

Refer this doc for more information on application image - https://github.com/WASdev/ci.docker#building-an-application-image

### Running the application locally as a docker conatiner

1. Git clone 
2. Build and tag the docker image. 
    If you are using ibm-liberty as the base image 
    ```docker build . -t websphere-liberty -f Dockerfile```
    
    If you are using open liberty as the base image 
    ```docker build . -t open-liberty -f olp.Dockerfile```

3. Run the docker image 
    For running ibm liberty image execute 
    ```docker run -d -p 9080:9080 websphere-liberty```
    
    For running open-liberty image execute 
    ```docker run -d -p 9080:9080 open-liberty```

### pushing the image to docker registry 

1. Tag the local image 
     ```docker tag <local image:tag name> <docker repo:tag name>```

2. push it docker registry ```docker push <docker repo:tag name>```

### Deploying the application on an OCP clsuter manually 

1. Login to OCP cluster

2. We have several deployment manifest files in the ```deployment``` folder of the root directory of the project. Inorder to deploy the application on to the cluster we need to apply these yaml files. 

3. First let's take a look at ```configmap.yaml``` and ```secret.yaml```
   
4. Apply the yaml files that creates deployment, sevice and route. 

  ```
      oc apply -f deployment/deployment.yaml
      oc apply -f deployment/service.yaml
      oc apply -f deployment/route.yaml
   ```
### Building the image using Jenkins and pushing it to a docker registry(Dockerhub)

For doing this follow the instructions in the Readme of this repo - https://github.com/vivin12/jenkins-example

### Reference docs 

Pull an image to docker registry - https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
Routes on OpenShift - https://docs.openshift.com/container-platform/3.9/architecture/networking/routes.html
