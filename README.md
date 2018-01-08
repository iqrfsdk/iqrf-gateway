# IQRF Starter Gateway

Docker image based on IQRF GW daemon solution

![IQRF Starter Gateway](docs/iqrf-starter-gateway.png)

- https://github.com/iqrfsdk/iqrf-daemon
- https://github.com/iqrfsdk/iqrf-daemon-webapp
- https://github.com/iqrfsdk/iqrf-daemon-examples
+
- https://nginx.org/
- https://mosquitto.org/
- https://nodered.org/
- https://github.com/node-red/node-red-dashboard/
- http://supervisord.org/

## UP board

### Build and push

```Bash
docker build -f amd64-stable.Dockerfile -t iqrfsdk/iqrf-starter-gateway-debian .
docker login
docker image push iqrfsdk/iqrf-starter-gateway-debian
```

### Run

```Bash
docker container run -d -p 80:80 -p 1880:1880 -p 1883:1883 -p 9001:9001 --device /dev/spidev2.0:/dev/spidev2.0 \ 
--privileged --name iqrf-starter-gateway --restart=always iqrfsdk/iqrf-starter-gateway-debian
```

### Login

http://YOUR-IP/
user: admin
pass: iqrf

## RPI board

### Build and push

```Bash
docker build -f rpi-stable.Dockerfile -t iqrfsdk/iqrf-starter-gateway-raspbian .
docker login
docker image push iqrfsdk/iqrf-starter-gateway-raspbian
```

### Run

```Bash
docker container run -d -p 80:80 -p 1880:1880 -p 1883:1883 -p 9001:9001 --device /dev/spidev0.0:/dev/spidev0.0 \
--privileged --name iqrf-starter-gateway --restart=always iqrfsdk/iqrf-starter-gateway-raspbian
```

### Login

http://YOUR-IP/
user: admin
pass: iqrf
