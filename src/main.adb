pragma SPARK_Mode (On);

with Rocket_System;
use Rocket_System;


procedure Main
is
begin
   Init;
   loop
      pragma Loop_Invariant (Is_Safe(Status_System) and Is_Pressure_Safe(Pressure_Status_System));
      
      Read_Altitude;
      Read_Thrust_Level;
      Monitor_Thrust_Adjustment_System;
      Print_Status;
      Read_Pressure;
      Monitor_Pressure_Valve;
      Print_Pressure_Status;
      
   end loop;
end Main;

      
