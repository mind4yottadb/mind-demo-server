# mind-demo-server

## Build arguments

- `SERVERMODE`
- `BRANCH`
- `STARTUPMODE`

---

#### `SERVERMODE`

Possible values are:

- `plain`
- `client-test`
- `server-test`

Default value is: `plain`

---
#### `BRANCH`

Default value is: `main`

---
#### `STARTUPMODE`

- `shell`
- `direct`

Default value is: `direct`

---

## Client-test

docker image build  --build-arg SERVERMODE=client-test --build-arg BRANCH=v0.20.0 --progress=plain -t mind-server .
docker run -d --init --tty -p 10000:10000 --name=mind-server mind-server
docker rm mind-server

## Server-test

docker image build  --build-arg SERVERMODE=server-test --build-arg BRANCH=v0.20.0 --progress=plain -t mind-server .
docker run --init --tty -p 10000:10000 --name=mind-server mind-server
docker rm mind-server

## As a stand-alone server

WHEN MIND START RIGHT AWAY
docker image build --build-arg BRANCH=v0.20.0 --progress=plain -t mind-server .
docker run -d --init --tty -p 10000:10000 --name=mind-server mind-server
docker rm mind-server

WHEN MIND START WITH THE SHELL
docker image build  --build-arg STARTUPMODE=shell  --build-arg BRANCH=v0.20.0 --progress=plain -t mind-server .
docker run -d --init --tty -p 10000:10000 --name=mind-server mind-server
docker exec -it mind-server bash
../mind
docker rm mind-server

You can pass arguments by storing them in the env var: `mind_args`

docker run -d --init --tty -p 10000:10000 --env mind_args=--use-tls=yes --name=mind-server mind-server