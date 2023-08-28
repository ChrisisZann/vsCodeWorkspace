package main

import (
	"fmt"

	"rsc.io/quote"
)

// go mod init example/hello
// go run .
// go mod tidy

func main() {
	fmt.Println(quote.Go())
}

// Hello returns a greeting for the named person.
// func Hello(name string) string {
//     // Return a greeting that embeds the name in a message.
//     message := fmt.Sprintf("Hi, %v. Welcome!", name)
//     return message
// }
