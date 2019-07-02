package main

import "fmt"
import "time"
import "math/rand"

func ceo(jobs chan<- *writeJob) {

	for {
		arg1 := rand.Intn(1000)
		arg2 := rand.Intn(1000)
		index := rand.Intn(2)
		operator := operators[index]

		write := &writeJob{
			task : job{arg1, arg2, operator},
			resp: make(chan bool)}

		jobs <- write
		<-write.resp

		if verbose {
			fmt.Println("ceo delegates a job: ", arg1, operator, arg2)
		}
		time.Sleep(ceoDelay * time.Millisecond)
	}
}
