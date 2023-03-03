package handler

import (
	"io"
	"net/http"
)

func Healthcheck(w http.ResponseWriter, r *http.Request) {
	io.WriteString(w, "Healthy Pod!")
}
