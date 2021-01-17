# Crossfire-docker

```bash
docker build . -t dhjensen/testnet2:test
```

```bash
docker run -it --mount type=bind,source=$HOME/crossfiredata,target=/chain-main dhjensen/testnet2:test bash
```
