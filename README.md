# chmod

Calculate `chmod` permissions using a grahpical Web interface

## Usage

See https://aminnairi.github.io/chmod

## Development

### Requirements

- Docker
- Docker Compose

### Run

```bash
docker compose run --rm --publish 8000:8000 elm reactor --port 8000
```

### Build

```bash
docker compose run --rm elm make --output docs/index.js src/Main.elm
```
