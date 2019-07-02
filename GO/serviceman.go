package main

import "time"

func serviceman (machineID int) {
	
	time.Sleep(servicemanDelay * time.Millisecond)
	backdoorsChannels[machineID] <- false
	
	fixedMachinesChannel <- machineID
}

