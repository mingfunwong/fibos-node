Config Enable producer

```bash
vi docker-compose.yml
# input below values:
PRODUCER_ENABLE: 'true'
PRODUCER_NAME: fibos123comm
PUBLIC_KEY: xxx
PRIVATE_KEY: xxxxx
```

Start

```bash
docker-compose up -d
```

Update

```bash
docker-compose pull
docker-compose up -d
```

Stop

```bash
docker-compose down
```
