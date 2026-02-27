# Every Docker Command you Require!

A comprehensive guide to Docker fundamentals from basics to advanced concepts.

<br>

## What is Docker?

Docker is used to **Isolate** and **Containerize** applications, making them:
- OS independent
- Lightweight and fast
- Easy to deploy across different environments

#### Before Terraform and Kubernetes, we have to learn Docker
Before diving into container orchestration, understanding Docker and containerization is essential. Docker is the foundation for modern DevOps practices.

<br>

## Core Docker Concepts

#### **Docker**
- Used to containerize applications including code, dependencies, and configurations
- Makes applications OS independent
- Lightweight compared to Virtual Machines

#### **Docker Container**
- Contains everything your app needs to run
- Isolated environment running on shared OS
- Docker images with help of images, containers are created (Blueprint to create containers)

#### **Docker Image**
- Stack of layers (image stack)
- Every instruction is a layer stacked on each other
- Only the top layer is executable
- Every other layer is read only
- This image stack makes it lightweight and portable

#### **Dockerfile**
- Used to create images
- Written in YAML format

#### **Containerization vs Multiple Images**
- When you create image & run multiple images, it's called **containerization**

#### **Docker Hub**
- Just like GitHub, it's a repository for your images
- Consists of famous view images like: node, nginx, maven, tomcat and many more

#### **Docker Engine**
- Core part of Docker that runs and manages containers

#### **Docker Volumes**
- Containers don't store data permanently
- To store data permanently, volumes are used

<br>

## Docker Compose

#### Used to run multi-containers
- In real world, we don't have a single container to run, it's multiple containers
- For microservice projects, it's best to containerize and run it
- Each service has its own container, isolated and highly optimized

#### Docker-compose file helps there
- So Docker-compose file is written in YAML format

#### It is written in YAML format

#### Containerization = Combination of (Multiple) Dockerfile + (Single) Docker-compose file

#### When you create image & run multiple images, it's called containerization

<br>
<br>

## Initial Setup Commands

#### Pull an image from DockerHub
```bash
docker pull <image-name>
```

#### Shows all existing images
```bash
docker images
```

#### Run a container from an image
```bash
docker run <image-name>
```

#### Show all running containers
```bash
docker ps
```

#### Show all containers (including stopped ones)
```bash
docker ps -a
```

#### Stop a running container
```bash
docker stop <container-name>
```

#### Start a stopped container
```bash
docker start <container-name>
```

#### After stopping container, delete the container
```bash
docker rm <container-name>
```

#### Delete an image
```bash
docker rmi <image-name>
```

#### Login to DockerHub
```bash
docker login
```

#### Push image to DockerHub (username:image-name)
```bash
docker push <dockerhub-username>:<image-name>
```

<br>
<br>

## Advanced Docker Commands

#### Inspect and get data like IP of container
```bash
docker inspect <container-name>
```

#### Execute commands inside running container (not changeable)
```bash
docker exec <container-name>
```
- By use of `-exec` command, you can go inside container, to its directory to change something

#### Run your compose file and create and run multicontainer
```bash
docker compose up
```

#### Show what's running
````bash
docker compose ps
````

#### Stops and deletes all the containers created by compose file
```bash
docker compose down
```

#### To see the logs (You don't know what's happening in Docker)
```bash
docker logs <container-name>
```
- So logs help a lot

#### Build image from Dockerfile in current directory
```bash
docker build -t <image-name> .
```

#### Lists all Docker networks
```bash
docker network ls
```

#### Lists all Docker volumes
```bash
docker volume ls
```

#### Create a new volume
```bash
docker volume create <volume-name>
```

#### Remove a volume
```bash
docker volume rm <volume-name>
```

#### Tag an image
```bash
docker tag <image-id> <repository:tag>
```

#### Port mapping (Host port : Container port)
```bash
docker run -p 8080:80 <image-name>
```
- **Port binding**: Used to clean up container ports

#### Shortcut to add and commit at once
#### Condition: File should be tracked once
```bash
git commit -am "your message"
```

<br>
<br>

## Running Containers in Different Modes

#### Detach mode (-d)
```bash
docker run -d <image-name>
```
- As container is an ongoing process, it might take up your terminal
- So to run the container in background, use detach mode

#### Interactive mode
```bash
docker run -it <image-name>
```
- To run bash scripts and react with containers

<br>
<br>

## Docker Port Binding

#### Containers are OS virtualization (Portable and lightweight as OS is virtualized)
#### VMs are hardware virtualization (Need OS - Heavy)

#### When you run a container, it has its own internal ports
Example: A web app might run on port 80 inside a container

#### Port binding allows you to connect that container port to your [host] port
- So you [user] can access the app from browser

#### Example Command
```bash
docker run -p 8080:80 <image-name>
```
- **Host port**: Container IP
- **nginx** listens to port 80
- So, you can access nginx service at your public IP: 8080

<br>
<br>

## Dockerfiles - Creating Your Own Images

A Dockerfile is used to create images. Here are all the important instructions:

#### FROM - Takes base image from DockerHub
```dockerfile
FROM node:18
```

#### LABEL - To tag metadata
```dockerfile
LABEL maintainer="your-email@example.com"
```

#### RUN - To perform shell instructions (can be multiple)
```dockerfile
RUN apt-get update && apt-get install -y curl
```

#### COPY - Copy files from local to image
```dockerfile
COPY . /app
```

#### ADD - Like COPY but unpacks zip/tar files
```dockerfile
ADD archive.tar.gz /app
```

#### WORKDIR - Set working directory of container
```dockerfile
WORKDIR /app
```

#### ENV - Set environment variables
```dockerfile
ENV NODE_ENV=production
```

#### EXPOSE - Documents the port container listens to
```dockerfile
EXPOSE 3000
```

#### CMD - Single/Default command to run when container starts
```dockerfile
CMD ["node", "server.js"]
```
- More properly than RUN
- Should list point

#### ENTRYPOINT - Main command to run, even if arguments are passed
```dockerfile
ENTRYPOINT ["npm", "start"]
```

#### VOLUME - Creates a mount point with a volume
```dockerfile
VOLUME /data
```

<br>
<br>

## Docker Compose File Structure

Docker Compose is written in YAML format to run multi-containers.

#### Example Docker Compose File (version: 3.3)

```yaml
version: '3.3'

services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
    restart: always

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: mydb
    ports:
      - "3306:3306"
    volumes:
      - db-data:/var/lib/mysql

volumes:
  db-data:
```

#### Breakdown of Docker Compose Structure:

**Version**: Specifies Docker Compose file format version

**Services**: Contains all the containers to run
- **web**: Service name
  - **image**: nginx:latest (base image)
  - **ports**: "8080:80" (host:container)
  - **volumes**: Mount local files to container
  - **restart**: always (restart policy)

- **db**: Database service
  - **image**: mysql:8.0
  - **environment**: Environment variables
    - MYSQL_ROOT_PASSWORD: password
    - MYSQL_DATABASE: mydb
  - **ports**: "3306:3306"
  - **volumes**: Persistent data storage

**Volumes**: Define named volumes for data persistence
- **db-data**: Volume automatically created if it doesn't exist

<br>
<br>

## You Can Host Websites on Docker Container

#### Steps:
1. You can run multiple containers using compose file (even a microservice project)
2. Containers have their own IP address
3. Configure proper port mapping
4. Access your application through host machine

<br>
<br>

## Docker Networking

#### Lists all networks
```bash
docker network ls
```

#### Containers can communicate with each other through Docker networks

#### Docker creates default networks:
- **bridge**: Default network for containers
- **host**: Container shares host network
- **none**: No networking

<br>
<br>

## Docker Volumes - Data Persistence

#### Why Docker Volumes?
Docker volumes **don't store data** permanently inside containers.

#### To store data permanently, volumes are used

#### Create a volume
```bash
docker volume create <volume-name>
```

#### List all volumes
```bash
docker volume ls
```

#### Remove a volume
```bash
docker volume rm <volume-name>
```

#### Mount volume in container
```bash
docker run -v <volume-name>:/path/in/container <image-name>
```

<br>
<br>

## Best Practices

#### Container Management
- Use detach mode (`-d`) for production containers
- Always name your containers for easy identification
- Clean up unused containers regularly

#### Image Management
- Build lightweight images
- Use specific image tags, not `latest`
- Leverage layer caching for faster builds

#### Data Management
- Always use volumes for persistent data
- Backup important volumes regularly
- Don't store sensitive data in images

#### Networking
- Use custom networks for better isolation
- Map only necessary ports
- Use environment variables for configuration

<br>
<br>

## Common Use Cases

#### Microservices Architecture
Each service has its own container:
- Isolation between services
- Easy to scale individual services
- Independent deployment

#### Development Environment
- Consistent environment across team
- Easy setup for new developers
- No "works on my machine" issues

#### Web Hosting
- Host websites in containers
- Easy deployment and updates
- Scalable and portable

<br>
<br>

## Debugging Docker

#### Check container logs
```bash
docker logs <container-name>
```

#### Follow logs in real-time
```bash
docker logs -f <container-name>
```

#### Inspect container details
```bash
docker inspect <container-name>
```

#### Execute commands inside running container
```bash
docker exec -it <container-name> /bin/bash
```

#### Check Docker system information
```bash
docker info
```

#### View Docker disk usage
```bash
docker system df
```

<br>
<br>

## Cleaning Up Docker

#### Remove stopped containers
```bash
docker container prune
```

#### Remove unused images
```bash
docker image prune
```

#### Remove unused volumes
```bash
docker volume prune
```

#### Remove unused networks
```bash
docker network prune
```

#### Clean up everything (use with caution!)
```bash
docker system prune -a
```

<br>
<br>

## Quick Reference Cheat Sheet

| Command | Description |
|---------|-------------|
| `docker pull` | Download image from DockerHub |
| `docker images` | List all images |
| `docker run` | Create and start container |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop` | Stop running container |
| `docker start` | Start stopped container |
| `docker rm` | Remove container |
| `docker rmi` | Remove image |
| `docker exec` | Execute command in container |
| `docker logs` | View container logs |
| `docker build` | Build image from Dockerfile |
| `docker compose up` | Start multi-container application |
| `docker compose down` | Stop multi-container application |

<br>
<br>

---

## Summary

Docker revolutionizes application deployment by providing:
- **Isolation**: Each container runs independently
- **Portability**: Run anywhere Docker is installed
- **Efficiency**: Lightweight compared to VMs
- **Scalability**: Easy to scale applications
- **Consistency**: Same environment everywhere

Master these Docker concepts and commands to become proficient in modern containerization practices!

---

**Created for YouTube Tutorial**  
Next video is : Learning Terraform for Beginners
Subscribe for more DevOps content! 🚀
