with Channels; use Channels;
with Constants; use Constants;
with Ada.Text_IO; use Ada.Text_IO;

package body Tasks is
   machines : ArrayMachines;

   --CEO
   task body Ceo is
      G : Generator;
      arg1 : Integer;
      arg2 : Integer;
      res : Integer := 0;
      oper : Character;
      creation : Job;
      operands : array (1 .. 3) of Character;
   begin
      accept Start;
      operands := ('+','-','*');
      Reset(G);
      loop
         arg1:= Random(G);
         arg2:= Random(G);
         oper:= operands((Random(G) mod 3 )+ 1);
         creation := (arg1,arg2,oper,res);
         JobsChannel.Set(creation);
         if(loud) then
            Put("ID 1 : New job created:" & Integer'Image(arg1) & " ");
            Put_Line(oper & Integer'Image(arg2));
         end if;
         delay ceoDelay;
      end loop;
   end Ceo;


   --WORKER
   task body Worker is
      id : Integer;
      temp : Job;
      patient : Integer := 0;
      G : Generator;
      success : Boolean;
      broken : Boolean;
   begin
      accept Start;
      Reset(G);
      WorkerID := WorkerID + 1;
      id := WorkerID;
      patient := Random(G) mod 2;
      loop
         success := false;
         broken := false;

         JobsChannel.Get(temp);
         if patient = 0 then
            machinesArray.Patient(id,temp,broken);
         else
            machinesArray.Impatient(id,temp,broken);
         end if;
         StoreChannel.Set(temp.result);
         if(loud) then
               Put_Line("ID" & Integer'Image(id) & " : New product created:" & Integer'Image(temp.result));
            end if;
         delay workerDelay;
      end loop;
   end Worker;


   --CLIENT
   task body Client is
      temp : Integer;
      success : Boolean;
      id : Integer;
   begin
      accept Start;
      ClientID := ClientID + 1;
      id := ClientID;
      loop
         success := false;
         StoreChannel.Get(temp, success);

         if success then
            if(loud) then
               Put_Line("ID" & Integer'Image(id) & " : New product was bought:" &  Integer'Image(temp));
            end if;
         end if;
         delay clientDelay;
      end loop;
   end Client;

   --SERVICEMAN
   task body Serviceman is
   begin

      loop
         accept Fix(MachineId : in out Integer; id : in out Integer) do
            delay servicemanDelay;
            if(loud) then
               Put_Line("ID" & Integer'Image(MachineId) & " : Machine is repaired");
            end if;
            machines(MachineId).fix;
            servicemenStat(id) := 0;
            machinesStat(MachineId) := 0;
         end Fix;
      end loop;
   end Serviceman;

   -- MACHINE
   task body Machine is
      G : Generator;
      broken : Boolean := false;
      result : Integer;

   begin
      loop
         select
            accept doMath(temp : out Job; r : in out Boolean; b : out Boolean) do
               if broken = false then
                  if temp.operator = '+' then
                     result := temp.argument1 + temp.argument2;
                  elsif temp.operator = '-' then
                     result := temp.argument1 - temp.argument2;
                  elsif temp.operator = '*' then
                     result := temp.argument1 * temp.argument2;
                  end if;
                  temp.result := result;
                  b := false;
                  r:= true;
               else
                  b := true;
                  r:= false;
               end if;

               if Random(G) <= machineProbability and broken = false then
                  broken := true;
               end if;


               delay machineDelay;

            end doMath;
         or
            accept doMathImpatient(temp : out Job; r : in out Boolean; b : out Boolean) do

               if broken then
                  b := true;
                  r := false;
               else
                  if temp.operator = '+' then
                     result := temp.argument1 + temp.argument2;
                  elsif temp.operator = '-' then
                     result := temp.argument1 - temp.argument2;
                  elsif temp.operator = '*' then
                     result := temp.argument1 * temp.argument2;
                  end if;
                  temp.result := result;
                  b:= false;
                  r := true;
               end if;

               if Random(G) <= machineProbability and broken = false then
                  broken := true;
               end if;

               delay machineDelay;

            end doMathImpatient;

         or
            accept fix do
               broken := false;
            end fix;

         or
          delay timeoutImpatient;
         end select;
      end loop;


   end Machine;

   -- MACHINE CHANNEL
   task body MachineChannel is
      G : Generator;
      statistics : Employees;
      machineId : Integer;

      r : Boolean := false;
   begin
      loop
         select
            accept Patient (id : Integer; s : out Job; b : in out Boolean) do
               Reset(G);
               statistics(id).patient := 1;
               machineId := (Random(G) mod numberOfMachines) + 1;
               machines(machineId).doMath(s,r,b);

               while not r loop
                  if b = true then
                     ServiceChannel.BrokenCall(machineId);
                     machineId := (Random(G) mod numberOfMachines) + 1;
                  end if;
                  b := false;
                  machines(machineId).doMath(s,r,b);
                  delay machineDelay;
               end loop;

               r := false;
               b := false;
               statistics(id).goals := statistics(id).goals + 1;

            end Patient;
         or
            accept Impatient (id : in Integer; s : out Job; b : in out Boolean) do
               Reset(G);
               statistics(id).patient := 1;
               machineId := (Random(G) mod numberOfMachines) + 1;
               machines(machineId).doMathImpatient(s,r,b);

               while not r loop
                  if b = true then
                     ServiceChannel.BrokenCall(machineId);
                  end if;

                  b := false;
                  machineId := (Random(G) mod numberOfMachines) + 1;
                  machines(machineId).doMathImpatient(s,r,b);

                  delay machineDelay;
               end loop;
               r := false;
               b := false;
               statistics(id).goals := statistics(id).goals + 1;
            end Impatient;
         or
            accept Show do
              for I in statistics'Range loop
                  Put(Integer'Image(I));
                  Put(Integer'Image(statistics(I).patient));
                  Put_Line(Integer'Image(statistics(I).goals));
               end loop;
            end Show;
         end select;
      end loop;
   end MachineChannel;

   --SERVICE CHANNEL
   task body Service is
      i: Integer := 1; --iterator
      numberOfWorkingServicemen: Integer := 0;
      servicemenTable: ArrayServicemen;
      machinesStat: ArrayService := (others => 0);
      servicemenStat: ArrayServicemenStat := (others => 0);

      begin
        loop
          select
            accept BrokenCall (machineID : in out Integer) do

                  if machinesStat(machineID) = 0 then

                  machinesStat(machineID) := 1;
                  numberOfWorkingServicemen := numberOfWorkingServicemen + 1;

                  if(loud) then
                     Put_Line("ID" & Integer'Image(MachineId) & " : Machine is broken");
                  end if;

                  loop
                     i := ((i mod numberOfSerivcemen) + 1);
                     exit when servicemenStat(i) = 0;
                     i := ((i mod numberOfSerivcemen) + 1);
                  end loop;

                  servicemenTable(i).Fix(machineID,i);
                  machinesStat(machineID) := 0;
               end if;
            end BrokenCall;
          end select;
        end loop;
    end Service;
end Tasks;
