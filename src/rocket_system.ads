-- These files are created by Tejay Hall 2204744 and Dexter O'Neill 2259884
-- This is an example of a Rocket Control System.
-- In particular, it is the thrust control and pressure management.
-- The critical thrust level is based on the current altitude.
-- The higher the altitude the less thrust is needed as gravity becomes less and less.
-- If the thrust level is not equal to the critical thrust level
-- the thrust adjustment system will be set to activated.
-- The pressure system will active when
-- the pressure is below then critical pressure.


pragma SPARK_Mode (On);


with SPARK.Text_IO; use SPARK.Text_IO;


package Rocket_System is
   
   
   -- Thrust adjustment system.
   
   
   -- Maximum_Altitude describes the 
   -- maximum altitude which could ever occur.
   -- It is needed since we restrict the integers up to this value.
  
   Maximum_Altitude : constant Integer := 384400;

   
   -- Maximum_Thrust_Level describes the 
   -- maximum thrust which could ever occur.
   -- It is needed since we restrict the integers up to this value.
   
   Maximum_Thrust_Level : constant Integer := 100;

   
   -- Thrust level range that can exist.
   
   type Thrust_Level_Range is new Integer range 0 .. Maximum_Thrust_Level;

   
   -- Range of altitudes which is possible to exist.
   
   type Altitude_Range is new Integer range 0 .. Maximum_Altitude;

   
   -- Status of the thrust adjustment system.
   
   type Status_Thrust_Adjustment_System_Type is (Activated, Not_Activated);

   
   -- Status of the overall thrust adjustment system consisting of 
   -- the altitude, thrust, critical thrust level and the status of the thrust system.
   
   type Status_System_Type is record
      Altitude_Measured               : Altitude_Range;
      Thrust_Level_Measured           : Thrust_Level_Range;
      Critical_Thrust_Level           : Thrust_Level_Range;
      Status_Thrust_Adjustment_System : Status_Thrust_Adjustment_System_Type;
   end record;  
   
   
   -- Critical_Thrust_Level is a global variable determining 
   -- the critical thrust level of the system.
   
   Critical_Thrust_Level : Thrust_Level_Range:= 0;

   
   -- Status_System is a global variable determining the status of the system
   
   Status_System : Status_System_Type;
   
   
   -- Read_Altitude gets the current altitude from console input output
   -- and updates Status_System.
   -- It does NOT monitor the cooling system
   -- so after executing it the system might be unsafe.
   
   procedure Read_Altitude with
     Global  => (In_Out => (Standard_Output, Standard_Input, Status_System)),
     Depends => (Standard_Output => (Standard_Output, Standard_Input),
                 Standard_Input => Standard_Input,
                 Status_System  => (Status_System, Standard_Input));

   
   -- Read_Thrust_Level gets the current thrust level from console input output
   -- and updates Status_System.
   -- It does NOT monitor the cooling system
   -- so after executing it the system might be unsafe.
   
   procedure Read_Thrust_Level with
     Global  => (In_Out => (Standard_Output, Standard_Input, Status_System)),
     Depends => (Standard_Output => (Standard_Output, Standard_Input),
                 Standard_Input => Standard_Input,
                 Status_System  => (Status_System, Standard_Input));

   
   -- This function converts a value into Status_System_Type
   -- into a string which can be printed to console.
   
   function Status_Thrust_Adjustment_System_To_String
     (Status_Thrust_Adjustment_System : Status_Thrust_Adjustment_System_Type)
      return String;

   
   -- Print_Status prints out the status of the system on console.
   
   procedure Print_Status with
     Global  => (In_Out => Standard_Output, Input => Status_System),
     Depends => (Standard_Output => (Standard_Output, Status_System));

   
   -- Is_Safe determines whether the system is safe, if applied to Status_System
   -- This is an example of an expression function
   -- It abbreviates in verification condition what it means for the system to be safe.
   -- Is_Safe(Status_System) means that the system is safe
     
   function Is_Safe (Status : Status_System_Type) return Boolean is
     (if  Status.Thrust_Level_Measured = Status.Critical_Thrust_Level
      then Status.Status_Thrust_Adjustment_System = Not_Activated
      else Status.Status_Thrust_Adjustment_System = Activated);
   
   
   -- Monitor_Thrust_Adjustment_System monitors the thrust level,
   -- if it is not equal to the critical thrust level then 
   -- it activates the cooling system.
   -- Afterwards the system will be safe as expressed by  the post condition.
   
   procedure Monitor_Thrust_Adjustment_System with
     Global  => (In_Out => Status_System),
     Depends => (Status_System => Status_System),
     Post    => Is_Safe (Status_System);
   
   
   --Pressure Valve System
   
  
   -- Maximum_Pressure_Possible describes the 
   -- maximum pressure which could ever occur.
   -- It is needed since we restrict the integers up to this value.
   
   Maximum_Pressure_Possible : constant Integer := 5000;
   
   
   -- if the pressure is larger than Critical_Pressure
   -- then the pressure system will be activated.
   
   Critical_Pressure : constant Integer := 3500;
   
   
   -- range of pressures which can exist   
   
   type Pressure_Range is new Integer range 0 .. Maximum_Pressure_Possible;
   
   
   -- status of the cooling system
   
   type Status_Pressure_Valve_Type is (Open, Not_Open);
   
   
   -- status of the overall system consisting of the pressure and the status of the pressure system
   
   type Pressure_Status_System_Type  is 
      record
         Pressure_Measured   : Pressure_Range;
         Status_Pressure_Valve : Status_Pressure_Valve_Type;
      end record;
   
  
   -- Status System is a global variable determining the status of the system
   
   Pressure_Status_System : Pressure_Status_System_Type;
   
   
   -- Read_Pressure gets the current pressure from console input output
   -- and updates Status_System
   -- it does NOT monitor the pressure system
   -- so after executing it the system might be unsafe.
   
   procedure Read_Pressure with
     Global => (In_Out => (Standard_Output, Standard_Input,Pressure_Status_System)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input),
                 Standard_Input  => Standard_Input,
                 Pressure_Status_System   => (Pressure_Status_System, Standard_Input));
   
   
   -- This function converts a value into Pressure_Status_System_Type
   -- into a string which can be printed to console.
     
   function Status_Pressure_Valve_To_String (Status_Pressure_Valve   : Status_Pressure_Valve_Type) return String;
      
   
   -- Print Status prints out the status of the system on console
   
   procedure Print_Pressure_Status with
     Global => (In_Out => Standard_Output, 
                Input  => Pressure_Status_System),
     Depends => (Standard_Output => (Standard_Output,Pressure_Status_System));
   
   
   -- Is_Pressure_Safe determines whether the system is safe, if applied to Pressure_Status_System
   -- This is an example of an expression function
   -- It abbreviates in verification condition what it means for the system to be safe.
   -- Is_Pressure_Safe(Pressure_Status_System) means that the system is safe
   
   function Is_Pressure_Safe (Status : Pressure_Status_System_Type) return Boolean is
     (if (Integer(Status.Pressure_Measured) > Critical_Pressure)
      then Status.Status_Pressure_Valve = Open
      else Status.Status_Pressure_Valve = Not_Open);
         
   
   -- Monitor_Pressure_Valve monitors the pressure, 
   -- if the pressure is higher than the critical pressure the valve becomes open.
   -- Afterwards the system will be safe as expressed by  the post condition
   
   procedure Monitor_Pressure_Valve  with
     Global  => (In_Out => Pressure_Status_System),
     Depends => (Pressure_Status_System => Pressure_Status_System),
     Post    => Is_Pressure_Safe(Pressure_Status_System);
   
   
   -- Init initialises the system to some values.
   -- afterwards the system is safe.
   
   procedure Init with
     Global  => (Output => (Standard_Output, Standard_Input, Status_System,Pressure_Status_System)),
     Depends => ((Standard_Output, Standard_Input, Status_System,Pressure_Status_System) => null),
     Post    => Is_Safe (Status_System) and Is_Pressure_Safe(Pressure_Status_System);
   

end Rocket_System;
