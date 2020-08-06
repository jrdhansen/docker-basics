DOCKER                                                                         
- The problem which Docker solves is to prevent the "well it worked on         
  my machine!" problem when source code is ported onto a new system (new          
  hardware, new OS, etc.)                                                      
- Docker is compatible with just about every language.                         
- Containers are the atomic unit of docker. I think of a container as kind of  
  being like a python virtual environment. You specify all of your             
  dependencies (packages, OS of the container, "images", etc.) and the         
  container has all of those things and works on top of the OS of the actual   
  hardware. It also contains code which you want to run int the container.        
- You can share docker containers on docker-hub.                               
- Docker containers can interact with each other and work together.            
- Containers are kind of like VMs, but VMs are more restrictive.               
- [Dockerfile] -> [Docker image] -> [Docker container]                         
- An image is a template for creating the env you want in a container. Said       
  another way, a container is a running instance of an image.                  
- An image is defined by a Dockerfile. A Dockerfile is a text file with a list 
  of steps to perform to create the desired image (e.g. configure the OS,         
  install needed software like Python modules, copy project files and code        
  into the right places, etc.) Write the Dockerfile then build that image,        
  then build the image to create a container.                                  
- Each instruction/command in the dockerfile prompts the docker builder to        
  generate an image layer and stack them atop each other. the docker image is  
  a read-only stack of image layers.                                           
- The first image in the dockerfile (the aptly-named based image) is important 
  since everything is built on top of it. Basically, make sure to pick a good  
  foundation (also, don't make it way too big, could use python:3.8-slim for   
  example).                                                                    
- Totake advantage of image building caching, put layers which get changed the 
  least at the top of the file, and layers which get changed most nearer the   
  bottom. For example, requirements.txt likely won't change as much as some       
  main.py file, so place the command relating to the main.py file lower in the 
  Dockerfile.                                                                  
- NOTE: all < docker ... > commands listed below must be preceded by <sudo> in 
        order to work properly unless some extra configuring has been done at  
        some point.                                                               
- CMD = <docker build [OPTIONS] PATH | URL | - >                                  
  This command builds a Docker image from a Dockerfile and a "context." A         
  build's context is the set of files in the specified PATH or URL. By default 
  <docker build> looks for a Dockerfile at the root of the build context.       
  example: < docker build -t myimage . > Here PATH=current dir (hence the .)   
          and we specify the -t option to name the image "myimage" (we could   
          have done myimage:mytag to give the image a tag)                     
- CMD = < docker images > lists docker images                                     
- CMD = < docker ps > lists docker processes                                      
- CMD = < docker run [OPTIONS] IMAGE [COMMAND] [ARG...] >  
