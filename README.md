
# 说明

fork  form [https://github.com/elleFlorio/svn-docker](https://github.com/elleFlorio/svn-docker)

ref from [https://github.com/li-franky/docker-svnserver](https://github.com/li-franky/docker-svnserver)

基于Alpine Linux和轻量级容器，提供SVN服务器（可以通过WebDav协议（http：//）和自定义协议（svn：//）访问服务器。


# 使用docker-compose 运行

- 将以下保存为docker-compose.yml

```
# 版本
version: "0.1"

# 服务
services:

  websvn:
    container_name: 'websvn'
    image: 'brotherdavid/websvn:0.0.5'
    restart: 'always'
    privileged: true
    hostname: 'localhost'
    ports:
      - '17443:443'
      - '17080:80'
      - '13690:3690'
    volumes:
      - '/mtdata/svn/repositories:/home/svn'
      - '/mtdata/svn/svnconfig:/etc/subversion'
      - '/mtdata/svn/svnadmin_data:/opt/svnadmin/data'


```

- 运行docker-compose.yml 

        docker-compose up -d 

- 通过命令进入docker 查看 

        docker exec -it websvn /bin/sh


# readme file from elleFlorio 

[![Docker Image](https://img.shields.io/badge/docker%20image-available-green.svg)](https://hub.docker.com/r/elleflorio/svn-server/)

## Description
Lightweight container providing an SVN server, based on **Alpine Linux** and S6 process management (see [here](https://github.com/smebberson/docker-alpine) for details).
The access to the server is possible via **WebDav protocol** (http://), and via **custom protocol** (svn://).
A complete tutorial on how to build this image, and how to run the container is available on [Medium](https://medium.com/@elle.florio/the-svn-dockerization-84032e11d88d#.bafh3otmh)

## Running Commands
To run the image, you can use the following command:
```
docker run -d --name svn-server -p 80:80 -p 3690:3690 elleflorio/svn-server
```
You can optionally bind a local folder to the container folder that will store your repositories using the flag `-v <hostpath>:/home/svn`.

## Configuration
**You need to setup username and password** for the access via WebDav protocol. You can use the following command from your host machine:
```
docker exec -t svn-server htpasswd -b /etc/subversion/passwd <username> <password>
```
To verify that everything is up and running, open your browser and connect to `http://localhost/svn`. The system should ask you for the username and password, then it will show you an empty folder (no repos yet!).
Check also that the custom protocol is working fine: go to your terminal and type `svn info svn://localhost:3690`. The system should connect to the server and tell you that is not able to find any repository.
For further information on how to configure Subversion, please refer to the [official web page](https://subversion.apache.org/).

## Alternative configuration via SVNADMIN
the image provides a graphical ui using the [SVNADMIN](https://github.com/mfreiholz/iF.SVNAdmin) interface via `http://localhost/svnadmin`.
You'll be prompted with a setup page, remember to test every step on the page then save the configuration.

## How to contribute
I'm super happy if you want to contribute! I do my best to keep this image updated and solve the issues that may arise, but I'm not much an operations guy, and I have very limited free time. :sweat_smile:

If you find something that can be improved or the solution to some issue, just comment the issue to notify that you will handle it, and then submit a pull request. I will then merge it and publish the updated image in the Docker Hub. :wink:

Thank you! :smile:
