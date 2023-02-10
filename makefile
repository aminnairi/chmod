.PHONY: install development production start

build:
	docker compose build

install: build
	docker compose run --rm npm install

development: install
	docker compose run --rm --service-ports npm run development

production: build
	docker compose run --rm npm run production

start: production
	docker compose run --rm --service-ports npm start
