with Constants; use Constants;
with Ada.Numerics.Discrete_Random;
package Tasks is
   
   subtype Random_Range is Integer range 1 .. 100;
   
   package R is new Ada.Numerics.Discrete_Random (Random_Range);
   use R;

   type Job is record
         argument1 : Integer;
         argument2 : Integer;
         operator : Character;
         result : Integer;
   end record;

   type Stats is record
         patient : Integer;
         goals : Integer := 0;
   end record;

   --CEO THREAD
   task type Ceo is
      entry Start;
   end Ceo;
   
   --WORKER THREAD
   task type Worker is
      entry Start;
   end Worker;
   
   --CLIENT THREAD
   task type Client is
      entry Start;
   end Client;
   
   --MACHINE THREAD
   task type Machine is
      entry doMath(temp : out Job; r : in out Boolean; b : out Boolean);
      entry doMathImpatient(temp : out Job; r : in out Boolean; b : out Boolean);
      entry fix;
   end Machine;
   
   -- MACHINE CHANNEL
   type ArrayMachines is array (1 .. numberOfMachines) of Machine;
   type Employees is array (1 .. numberOfWorkers) of Stats;

   task type MachineChannel is
     entry Patient (id : in Integer; s : out Job; b : in out Boolean);
     entry Impatient (id : in Integer; s : out Job; b : in out Boolean);
     entry Show;
   end MachineChannel;
   
    --SERVICEMAN THREAD
   task type Serviceman is
      entry Fix(machineID : in out Integer; id : in out Integer);
   end Serviceman;

   -- SERVICE CHANNEL
   type ArrayService is array (1 .. numberOfMachines) of Integer;
   type ArrayServicemen is array (1 .. numberOfSerivcemen) of Serviceman;
   type ArrayServicemenStat is array (1 .. numberOfSerivcemen) of Integer;
   
   --SERVICE THREAD
   task type Service is
      entry BrokenCall (machineID : in out Integer);
   end Service;
   
   
   ServiceChannel : Service;
   machinesArray : MachineChannel;
   machinesStat: ArrayService := (others => 0);
   servicemenStat: ArrayServicemenStat := (others => 0);
   
end Tasks;
