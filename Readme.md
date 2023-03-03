# Example Golang Project with a CI/CD  Pipeline

## Intro
This is an example project that targets to show how you can implement a CI/CD pipeline in your Go projects.

## What it does
- Builds docker image
- Checks that we have tests for all required files
- Runs all the unit tests
- Checks that we have the required test coverage

## Commands available to run locally
- `make test` - runs all tests and checks the test coverage
- `make build` - builds and prepares a docker image for the application
- `make run` - runs the application using the built docker image
