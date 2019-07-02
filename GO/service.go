package main

import "log"

func service() {
	
	brokenMachines := make([] bool,numberOfMachines,numberOfMachines)
	numberOfWorkingServicemen := 0
	
	for {
		select {
			case brokenMachineID := <- reportsChannel:
				
				if brokenMachines[brokenMachineID] == false && numberOfWorkingServicemen < numberOfServicemen {
					numberOfWorkingServicemen++
					brokenMachines[brokenMachineID] = true
					go serviceman(brokenMachineID)
					
					if verbose {
						log.Println("Service got a report about machine : ", brokenMachineID)
					} else {
						reportsChannel <- brokenMachineID
					}
				}
				
			case fixedMachineID := <- fixedMachinesChannel:
					
					if verbose {
						log.Println("Service fixed machine : ", fixedMachineID)
					}
					
					brokenMachines[fixedMachineID] = false
					numberOfWorkingServicemen--
		}

	}
}

