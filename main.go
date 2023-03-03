package main

import (
	"fmt"
	"github.com/ktsivkov/golang-github-cicd-pipeline/internal/handler"
	"net/http"
	"os"
)

func main() {
	port := os.Getenv("APP_PORT")
	if port == "" {
		port = "80"
	}

	http.HandleFunc("/", handler.Index)
	http.HandleFunc("/healthcheck", handler.Healthcheck)

	fmt.Println("Serving the application on port [" + port + "]")
	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		panic(err)
	}
}
