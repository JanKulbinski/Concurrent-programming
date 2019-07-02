with Ada.Text_IO; use Ada.Text_IO;
with Constants; use Constants;
with Tasks; use Tasks;
with Ada.Numerics.Discrete_Random;

package Channels is

   subtype Random_Range is Integer range 1 .. 100;
   
   package R is new Ada.Numerics.Discrete_Random (Random_Range);
   use R;

   -- JOBS CHANNEL
   type ArrayJobs is array (1 .. jobsCapacity) of Job;

   protected type JobsStore is
      entry Set (j : Job);
      entry Get (j : out Job);
   private
      jobPointer: Integer := 1;
      tab : ArrayJobs;
   end JobsStore;
   
   -- STORE CHANNEL
   type ArrayStore is array (1 .. storeCapacity) of Integer;

   protected type Store is
      procedure Set (r : Integer);
      procedure Get (r : out Integer; s : out Boolean);
      procedure Amount;
   private
      StorePointer: Integer := 1;
      tab : ArrayStore;
   end Store;
   
 JobsChannel : JobsStore;
 StoreChannel : Store;
end Channels;
