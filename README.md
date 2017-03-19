# Glassfish docker image

You can put `.war` and `.sh` files in a folder and mount it as a volume.
e.g. using [docker-compose](https://github.com/docker/compose):

Starting from a folder structure similar to the following one:

```
.
|-- docker-compose
`-- glassfish-init
    |-- my-app.war
    `-- initscript.sh
```

and a `docker-compose.yml` file:

```
version: '3'

services:
  glassfish:
image: koralco/glassfish
    ports:
      - "8080:8080"
    expose:
      - 8080
    volumes:
      - ./glassfish-init:/docker-entrypoint-glassfish.d
```

`my-app.war` is going to be autodeployed in the container, while `initscript.sh` is going to be executed.
