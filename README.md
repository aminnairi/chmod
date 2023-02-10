# chmod

Calculate `chmod` permissions using a grahpical Web interface

## Usage

See https://aminnairi.github.io/chmod

## Development

### Requirements

- [Git](https://git-scm.com/)
- [GNU/Bash](https://www.gnu.org/software/bash/)
- [GNU/Make](https://www.gnu.org/software/make/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

### Clone

```bash
git clone https://github.com/aminnairi/chmod
cd chmod
```

### Setup

Copy the [`.env.example`](./env.example) file and setup your environment by editing the newly copied file.

```bash
cp .env.example .env
```

### Development

Starts a development server and recompiles the application whenever a change occur in the [`src`](./src) directory.

```bash
make development
```

### Production

Compiles the project and stores the output in the `docs` directory.

```bash
make production
```

### Start

Serves the content of the `docs` directory and simulate a production server. This command automatically calls the `make production` command for you behind the scenes.

```bash
make start
```

## Credits

<a href="https://www.flaticon.com/free-icons/permission" title="permission icons">Permission icons created by Freepik - Flaticon</a>
