package main

import (
	"io/ioutil"
	"log"
	"net/http"
	"time"
)

func main() {
	url := "http://metalfactory/produce/car"

	for true {
		log.Printf("Fetching url %s\n", url)
		res, err := http.Get(url)

		if err != nil {
			log.Fatal(err)
		}
		body, err := ioutil.ReadAll(res.Body)
		if err != nil {
			log.Fatal(err)
		}
		res.Body.Close()
		log.Printf("Response: StatusCode: %d - %s\n", res.StatusCode, body)

		time.Sleep(3 * time.Second)
	}
}
