with Ada.Text_IO; use Ada.Text_IO;
with Tasks; use Tasks;
with Ada.Task_Identification; use Ada.Task_Identification;
package body channels is

   -- JOBS CHANNEL
   protected body JobsStore is
      entry Set (j : Job)
        when jobPointer <= jobsCapacity is
      begin
         tab(jobPointer) := j;
         jobPointer := jobPointer+1;
      end Set;

      entry Get (j : out Job)
        when jobPointer > 1 is
      begin
        jobPointer := jobPointer-1;
        j := tab(jobPointer);
      end Get;
   end JobsStore;

   --STORE CHANNEL
   protected body Store is
      procedure Set (r : Integer) is
      begin
         if StorePointer <= storeCapacity then
              tab(StorePointer) := r;
            StorePointer := StorePointer+1;
         end if;
      end Set;

      procedure Get (r : out Integer; s : out Boolean) is
      begin
         if StorePointer > 1 then
            StorePointer := StorePointer-1;
            r := tab(StorePointer);
            s := true;
            return;
         end if;
         s:= false;
      end Get;

      procedure Amount is
      begin
          for I in 1 .. StorePointer loop
           Put(Integer'Image(tab(I)));
         end loop;
      end Amount;

   end Store;
end channels;
