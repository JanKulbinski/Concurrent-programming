package main

import "fmt"
import "time"

func client(store chan<- *readStore, id int) {
	for {
		read := &readStore{resp: make(chan int)}
		store <- read
		product := <-read.resp
		if verbose {
			fmt.Println("client ID = ", id, " bought a result: ", product)
		}
		time.Sleep(clientDelay * time.Millisecond)
	}

}