package main

import (
	"basic-api/app/adapters"
)

func main() {
	router := adapters.BuildRouter()
	router.Run(":8080")
}
