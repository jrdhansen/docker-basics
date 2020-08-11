# DOCKER                                                                         
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
- Terminology: a container is just a running image (was having a hard time     
  telling if there is a difference between a container and an image).          
- NOTE: all < docker ... > commands listed below must be preceded by `\<sudo\>` in 
        order to work properly unless some extra configuring has been done at  
        some point.                                                            
- CMD = <docker build [OPTIONS] PATH | URL | - >                               
  This command builds a Docker image from a Dockerfile and a "context." A      
  build's context is the set of files in the specified PATH or URL. By default 
  <docker build> looks for a Dockerfile at the root of the build context.      
  example: < docker build -t myimage . > Here PATH=current dir (hence the .)   
          and we specify the -t option to name the image "myimage" (we could   
          have done myimage:mytag to give the image a tag)                     
- CMD = < docker images >   lists docker images                                
  CMD = < docker image ls > lists docker images                                
- CMD = < docker ps > lists docker processes                                   
- CMD = < docker run [OPTIONS] IMAGE [COMMAND] [ARG...] >                      
- CMD = < docker                                                               
- Dockerfile                                                                   
  - [Dockerfile] ---- \<docker build...\> ----> [Docker image]                   
  - When running \<docker build\> the command by default searches for a file     
    named Dockerfile.                                                          
  - Keywords in a Dockerfile are referred to as instructions. Instructions     
    include FROM, RUN, CMD, ENV                                                
  - Use the FROM keyword to specify a base image.                              
    Use <FROM scratch> to build your own image from scratch.                   
  - <MAINTAINER> to specify name and <youremai@site.com>                   
  - If you want to run something in (think: in the CLI of) your image you      
    say <RUN ...> like <RUN apt-get update> for example or <RUN mkdir newdir>  
    These commands get executed once at build time and get written into your   
    Docker image as a new layer.                                               
    - The layers of a Docker image are files generated from running a cmd.     
    - Layers can be reused by multiple images.                                 
    - A container is an image with a readable/writeable layer on top of a      
      bunch of read-only layers.                                               
  - Use the <CMD> instruction to run a command (think on the CLI of the        
    container) AFTER the container/image has been created.                     
  - The difference between RUN and CMD is that RUN commands get executed once  
    when the image is being built (creates a new layer) and CMD gives your     
    container a default command to run when the container is created and then  
    is first started.                                                          
- < sudo docker CMD --help > allows you to see help documentation for the CMD. 
- Volumes                                                                         
  - Volumes allow for data to persist after a container has been destroyed.       
  - Bind mounts are an alternative to volumes, but volumes are highly             
    preferred over bind mounts. Bind mounts can live anywhere in the host's       
    filesystem, while volumes live (are stored) only in the Docker area of the 
    filesystem and are much harder to alter. (Areas where bind mounts are         
    stored might be overwritten, accessed by other parts of the system, etc.)  
                         
