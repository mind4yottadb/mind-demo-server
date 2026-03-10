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
docker image build  --build-arg --build-arg BRANCH=v0.20.0 --progress=plain -t mind-server .
docker run -d --init --tty -p 10000:10000 --name=mind-server mind-server
docker rm mind-server

