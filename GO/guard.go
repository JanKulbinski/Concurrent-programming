package main

import "fmt"

func maybe(b bool, c chan *writeJob) chan *writeJob {
    if !b {
        return nil
    }
    return c
}

func maybe2(b bool, c chan *writeStore) chan *writeStore {
    if !b {
        return nil
    }
    return c
}

func maybe3(b bool, c chan *readJob) chan *readJob {
    if !b {
    	
        return nil
    }
    return c
}

func maybe4(b bool, c chan *readStore) chan *readStore {
    if !b {
        return nil
    }
    return c
}

func guard() {
	
	 jobSlice := make([]job, 0, jobsCapacity)
	 storeSlice := make([]int, 0, storeCapacity)
	 employeesSlice := make([]int, numberOfWorkers)
	 
	for {
		select {
			
			case ceoMakesTask := <- maybe(jobsCapacity > len(jobSlice), jobsFromCeo):
					jobSlice = append(jobSlice,ceoMakesTask.task)
					ceoMakesTask.resp <- true
					
			case workerGetsTask := <- maybe3(0 < len(jobSlice), jobsToDo):
					workerGetsTask.resp <- jobSlice[0]
					jobSlice = append(jobSlice[:0], jobSlice[1:]...)
			
			case workerMakesProduct := <- maybe2(storeCapacity > len(storeSlice), storeFromWorkers):
					employeesSlice[workerMakesProduct.id]++
					storeSlice = append(storeSlice,workerMakesProduct.result)
					workerMakesProduct.resp <- true
			
			case clientGetsProduct := <- maybe4(0 < len(storeSlice), storeToBuy):
					clientGetsProduct.resp <- storeSlice[0]
					storeSlice = append(storeSlice[:0], storeSlice[1:]...)
			
			case <- printEmployees:
				for i := 0; i < numberOfWorkers; i++ {
					output := fmt.Sprintf("%s%d%s%d%s%d","ID: ", i, " patient: ",employeesPatient[i] ," score: ",employeesSlice[i])
					fmt.Println(output)
				}

			case <- printJobs:
				fmt.Println(jobSlice)
				
			case <- printStore:
				fmt.Println(storeSlice)	 
		}
	}		
}