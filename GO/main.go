package main

var operators [3]string
var verbose bool
var jobsDone uint64

var jobsFromCeo chan *writeJob
var jobsToDo chan *readJob
var storeFromWorkers chan *writeStore
var storeToBuy chan *readStore

var	printStore chan bool
var	printJobs chan bool
var printEmployees chan bool

var machineChannels []chan *jobToMachine
var backdoorsChannels []chan bool

var reportsChannel chan int
var fixedMachinesChannel chan int

var employeesPatient []int

type job struct {
	argument1 int
	argument2 int
	operator  string
}

type jobToMachine struct {
	task  job
	resp chan int
	done chan bool
}
 
type readJob struct {
    resp chan job
}

type writeJob struct {
    task job
    resp chan bool
}

type readStore struct {
    resp chan int
}

type writeStore struct {
	id int
    result  int
    resp chan bool
}


func main() {

	verbose = false
	operators = [...]string{"+", "-", "*"}

	jobsFromCeo = make(chan *writeJob, jobsCapacity)
	storeFromWorkers = make(chan *writeStore, storeCapacity)
	jobsToDo = make(chan *readJob, jobsCapacity)
	storeToBuy = make(chan *readStore, storeCapacity)
	
	reportsChannel = make(chan int,reportsChannelCapacity)
	fixedMachinesChannel = make(chan int, numberOfMachines)
	
	machineChannels = make([] chan *jobToMachine, 0, numberOfMachines)
	for i := 0; i < numberOfMachines; i++ {
		machineChannels = append(machineChannels, make(chan *jobToMachine, 1))
	}
	
	backdoorsChannels = make([] chan bool, 0, numberOfMachines)
	for i := 0; i < numberOfMachines; i++ {
		backdoorsChannels = append(backdoorsChannels, make(chan bool, 1))
	}
	
	printStore = make(chan bool)
	printJobs = make(chan bool)
	printEmployees = make(chan bool)
	
	employeesPatient = make([]int,numberOfWorkers)
	
	done := make(chan bool)
	
	
	//starting goroutines
	for i := 0; i < numberOfCeos; i++ {
		go ceo(jobsFromCeo)
	}

	for i := 0; i < numberOfWorkers; i++ {
		go worker(jobsToDo, storeFromWorkers, i)
	}
	
	for i := 0; i < numberOfClients; i++ {
		go client(storeToBuy, i)
	}
	
	for i := 0; i < numberOfMachines; i++ {
		go machine(i)
	}
		
	go guard()
	
	go service()
	
	go menu(printJobs, printStore, done)
	
	<-done
}
