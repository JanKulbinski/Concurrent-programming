package main

import "time"
import "math/rand"

func machine(id int) {
	
	ifBroken := false
	
	for {
		select {
			case ifBroken = <- backdoorsChannels[id] :
				
			case taskToMachine := <- machineChannels[id] :		
				task := taskToMachine.task
				
				if ifBroken == true {
					taskToMachine.done <- false
					break
				}
				
				var r int
				if task.operator == "+" {
					r = task.argument1 + task.argument2
				} else if task.operator == "-" {
					r = task.argument1 - task.argument2
				} else if task.operator == "*" {
					r = task.argument1 * task.argument2
				}
				
				taskToMachine.done <- true
				taskToMachine.resp <- r
		}
		
		if !ifBroken && probabilityMachineToFail >= rand.Float32() {
			ifBroken = true
		}
		
		time.Sleep(machineDelay * time.Millisecond)
	}
}