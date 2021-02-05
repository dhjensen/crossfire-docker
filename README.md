# Crossfire-docker

```bash
docker-compose up -d --build
```

```bash
docker build . -t dhjensen/crossfire:test
```

```bash
docker run -it --mount type=bind,source=$HOME/crossfiredata,target=/chain-main dhjensen/crossfire:test bash
```
