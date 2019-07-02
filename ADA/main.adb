with Ada.Text_IO; use Ada.Text_IO;
with Constants; use Constants;
with Channels; use Channels;
with Tasks; use Tasks;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Numerics.Discrete_Random;

procedure Main is



   type ArrayClients is array (1 .. numberOfClients) of Client;
   type ArrayWorkers is array (1 .. numberOfWorkers) of Worker;


   clients : ArrayClients;
   workers : ArrayWorkers;
   chef : Ceo;
   input : Character;

 -- MENU THREAD
begin
   chef.Start;
   delay 1.0;

   for i in workers'Range loop
      workers(i).Start;
   end loop;

   for i in clients'Range loop
      clients(i).Start;
   end loop;

   loop
      if loud = false then
         Put_Line(" ");
         Put_Line("This is silent mode.");
         Put("Enter 'v' to run verbose mode ");
         Put_Line("and then 'q' to return back to silent mode.");
       --  Put_Line("Enter 'w' to see workers stats.");
         Put_Line("Enter 's' to see  stock amount.");
         Put_Line("Enter 'e' to exit program.");
      end if;

      Get(input);

      if input = 'v' then
         loud := true;
      elsif input = 'q' then
            loud := false;
      elsif input = 's' then
         Put_Line("Stock amount: ");
         StoreChannel.Amount;
--      elsif input = 'w' then
--         Put_Line("Workers: ");
--         machinesArray.Show;
      elsif input = 'e' then
              exit;
      end if;

   end loop;

   Abort_Task(chef'Identity);
   for i in workers'Range loop
      Abort_Task(workers(i)'Identity);
   end loop;

   for i in clients'Range loop
      Abort_Task(clients(i)'Identity);
   end loop;

end Main;
