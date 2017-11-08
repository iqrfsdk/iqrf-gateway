# IQRF Gateway

IQRF Gateway image based on IQRF daemon solution

- https://github.com/iqrfsdk/iqrf-daemon
- https://github.com/iqrfsdk/iqrf-daemon-webapp
- https://github.com/iqrfsdk/iqrf-daemon-examples
- http://supervisord.org/
- https://mosquitto.org/
- https://nodered.org/
- https://github.com/node-red/node-red-dashboard

## Build and Push

```Bash
docker build -f Dockerfile.amd64 -t iqrfsdk/iqrf-gateway-debian .
docker login
docker image push iqrfsdk/iqrf-gateway-debian
```
