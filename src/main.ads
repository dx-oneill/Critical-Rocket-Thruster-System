-- this is the executable file 
-- running the rocket system
--
-- it initialises the system
-- then runs forever in a loop which
--   1) reads the altitude and thrust level from console
--   2) monitors the thrust system so that the adjustment
--      system is activated if the thrust is not perfect
--   3) prints out the status
--   4) reads pressure from the console
--   5) monitors the pressure valve system so that
--      the pressure valve system opens if the pressure is too high
--   6) prints out the pressure system status 
--  the loop_invariant expresses that the system stays safe all the time.
pragma SPARK_Mode (On);

procedure Main;
      
