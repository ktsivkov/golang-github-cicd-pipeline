# Example Golang Project with a CI/CD  Pipeline

![Test, Build & Deploy](https://github.com/ktsivkov/golang-github-cicd-pipeline/actions/workflows/main.yml/badge.svg)

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

## The `.coverignore` file
As at the moment GoLang doesn't provide any official way to enforce the test existence I have created
a bash script that enforces each `*.go` file to have its own `*_test.go` one.
Check `./cicd/test_verifier.sh`

On the other hand, as most applications have a few files that are not supposed to be counted
in the test coverage.

Therefore, I have implemented a way to ignore such files using the `./.coverignore` file,
located in the project root.

When you run `./cicd/test_verifier.sh` from the project root, it reads the contents
of the `./.coverignore` file, and ignores them.

The syntax used is similar to the `.gitignore`'s one.

Example `.coverignore` file and syntax / note that comments are not supposed to be in the file,
but I am using them to make it more understandable for the sake of the example.
```
.                     # will ignore everything
.*                    # will ignore everything
./                    # will ignore everything
./*                   # will ignore everything
./*.go                # will ignore all .go files located in the main directory
./main.go             # will ignore the ./main.go file from the test coverage
./mydir/demofile.go   # will ignore the demofile.go located inside mydir
./mydir/*.go          # will ignore all .go files located inside mydir, but not its subdirectories
./mydir/*             # will ignore all files located inside mydir, and its subdirectories
./mydir/*/            # will ignore all files located in its subdirectories
...
```
