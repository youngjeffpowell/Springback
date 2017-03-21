
SHELL:=/bin/bash
default: run

run:
	docker-compose up -d

build:
	docker build -t code42:5.4.2 .

clean:
	docker-compose kill || true
	docker-compose rm -f || true
