explain:
	@echo "Available commands `make build`, `make test`, `make run`"

test:
	docker build . --file=docker/testing.Dockerfile -t goapp-testing:latest
	docker run -e COVERAGE_THRESHOLD=90 goapp-testing:latest

build:
	docker build . --file=docker/Dockerfile -t goapp:latest

run:
	docker run -e APP_PORT=4422 -p 4422:4422 goapp:latest

go: | build run
