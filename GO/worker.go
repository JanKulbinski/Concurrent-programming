package main

import "fmt"
import "time"
import "math/rand"

func worker(jobs chan<- *readJob, store chan<- *writeStore, id int) {

	patient := rand.Intn(2)
	employeesPatient[id] = patient

	for {
			
		read := &readJob{ resp: make(chan job) }
		jobs <- read

		task := <-read.resp
		
		taskToMachine := &jobToMachine{
			task: task,
			resp: make(chan int),
			done: make(chan bool)} 
		
		machineIndex := rand.Intn(numberOfMachines)
		
		var r int
		success := false

		for !success {
			
			if patient != 1 {		
				select {
					case machineChannels[machineIndex] <- taskToMachine:
						if <- taskToMachine.done  {
							r = <- taskToMachine.resp
							success = true
						} else {
							reportsChannel <- machineIndex
						}
							
					case <- time.After(impatientByMachineDelay * time.Millisecond) :
						machineIndex = (machineIndex + 1) % numberOfMachines
				}
			
			} else {
				machineChannels[machineIndex] <- taskToMachine
			
				if <- taskToMachine.done {
					r = <- taskToMachine.resp
					success = true
				} else {
					reportsChannel <- machineIndex
				}
			}
		}
		
		if verbose {
			fmt.Println("worker ID = ", id, " did a job: ", task.argument1, task.operator, task.argument2)
		}
		
		write := &writeStore { id : id, result : r, resp: make(chan bool) }
		store <- write
		<- write.resp

		
		time.Sleep(workerDelay * time.Millisecond)
	}
}

