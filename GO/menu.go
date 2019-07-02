package main

import "fmt"
import "time"

func menu(printJobs chan bool, printStore chan bool, done chan bool) {

	for {
		if !verbose {
			fmt.Print("This is silent mode.\nEnter 'v' to run verbose mode")
			fmt.Println("and then 'q' to return back to silent mode.")
			fmt.Println("Enter 'j' to see jobs to do by workers.")
			fmt.Println("Enter 's' to see  stock amount.")
			fmt.Println("Enter 'g' to see workers statistics.")
			fmt.Println("Enter 'e' to exit program.")
		}

		var input string
		fmt.Scanln(&input)
		switch input {
			
		case "v":
			verbose = true
			
		case "q":
			verbose = false
			
		case "j":
			fmt.Println("Jobs to do: ")
			printJobs <- true
			time.Sleep(time.Second)

		case "s":
			fmt.Println("Stock amount: ")
			printStore <- true
			time.Sleep(time.Second)
		
		case "g":
			fmt.Println("Statistics: ")
			printEmployees <- true
			time.Sleep(time.Second)
			
		case "e":
			done <- true
			time.Sleep(5 * time.Second)
			<-done
			done <- true
		}
	}
}