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
docker compose run --rm elm make --optimize --output docs/index.js src/Main.elm
```

### Optimize

```bash
docker compose run --rm uglifyjs docs/index.js --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe' --output docs/index.js
docker compose run --rm uglifyjs --mangle --output docs/index.js docs/index.js
```
