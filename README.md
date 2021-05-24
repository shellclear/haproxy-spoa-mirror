# HAPROXY - SPOA mirror 

The bash script _build-spoa.sh_ will build an image that will be used by the stack to deplot  four services: haproxy, spoa-mirror, nginx and apache. 

The haproxy has two backends, the production backend that will be used for receiving the real traffic and send it to nginx server and the production-mirror that will mirror all traffic arriving to production backend to the spoa-mirror service and so from the spoa-mirror to stage server.

### Services nt he stack
  + haproxy -> hapoxy:latest
  + spoa-mirror -> spoa-mirror:latest(build with bash script)
  + nginx -> nginx:latest
  + apache -> httpd:latest


