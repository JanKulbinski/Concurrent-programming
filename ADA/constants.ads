package Constants is

--channels
jobsCapacity : Integer := 100;
storeCapacity : Integer := 100;

--delays
ceoDelay : Standard.Duration := 0.5;
workerDelay : Standard.Duration := 1.0;
clientDelay : Standard.Duration := 1.0;
machineDelay : Standard.Duration := 0.5;
servicemanDelay : Standard.Duration := 2.2;
timeoutImpatient : Standard.Duration := 0.2;

--numbersOfPeople
numberOfWorkers : Integer := 16;
numberOfClients : Integer := 7;
numberOfCeos : Integer := 1;
numberOfMachines : Integer := 5;
numberOfSerivcemen : Integer := 2;

machineProbability : Integer := 10; -- probability that machine turns out to be broken in %


WorkerID : Integer := 0;
ClientID : Integer := 1;
loud: Boolean := false;


end constants;
