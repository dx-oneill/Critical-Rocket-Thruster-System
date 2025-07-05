pragma SPARK_Mode (On);


with AS_IO_Wrapper;  use AS_IO_Wrapper; 


package body Rocket_System is
   
   
   --Thrust adjustment system.
   
   
   procedure Read_Altitude is
      
      Altitude : Integer;
      
   begin
      
      AS_Put_Line("Please type in current altitute in km as read by sensors");
      
      loop
         AS_Get(Altitude,"Please type in an integer");
         exit when (Altitude >= 0) and (Altitude <= Maximum_Altitude);
         
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_Altitude);
         AS_Put_Line("");
         
      end loop;
      
      Status_System.Altitude_Measured := Altitude_Range(Altitude);
      
      if (Status_System.Altitude_Measured <= 10) then
         Status_System.Critical_Thrust_Level := 100;
      elsif (Status_System.Altitude_Measured <= 50) then
         Status_System.Critical_Thrust_Level := 90;
      elsif (Status_System.Altitude_Measured <= 90) then
         Status_System.Critical_Thrust_Level := 80;
      elsif (Status_System.Altitude_Measured <= 500) then
         Status_System.Critical_Thrust_Level := 40;
      else
         Status_System.Critical_Thrust_Level := 0;
      end if;
      
   end Read_Altitude;
   
   
   procedure Read_Thrust_Level is
      
      Thrust_Level : Integer;
      
   begin
      
      AS_Put_Line("Please type in current Thrust Level as read by sensors");
      
      loop
         AS_Get(Thrust_Level,"Please type in an integer");
         exit when (Thrust_Level >=0) and (Thrust_Level <= Maximum_Thrust_Level);
         
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_Thrust_Level);
         AS_Put_Line("");
         
      end loop;
      
      Status_System.Thrust_Level_Measured := Thrust_Level_Range(Thrust_Level);
      
   end Read_Thrust_Level;
   
   
   function Status_Thrust_Adjustment_System_To_String (Status_Thrust_Adjustment_System   : Status_Thrust_Adjustment_System_Type) return String is
      
   begin

      if (Status_Thrust_Adjustment_System = Activated) 
      then return "Activated";
      else return "Not Activated";
      end if;
      
   end Status_Thrust_Adjustment_System_To_String;
	
   
   procedure Print_Status is
      
   begin
      
      AS_Put("Thrust Level = ");
      AS_Put(Integer(Status_System.Thrust_Level_Measured));
      AS_Put_Line("");
      AS_Put("Thrust Adjustment System = ");
      AS_Put_Line(Status_Thrust_Adjustment_System_To_String(Status_System.Status_Thrust_Adjustment_System));
      
   end Print_Status;
   
   
   procedure Monitor_Thrust_Adjustment_System  is
      
   begin
      
      if Status_System.Thrust_Level_Measured = Status_System.Critical_Thrust_Level
      then Status_System.Status_Thrust_Adjustment_System := Not_Activated;
      else Status_System.Status_Thrust_Adjustment_System := Activated;
      end if;
      
   end Monitor_Thrust_Adjustment_System;
   
   
   --Pressure Valve System
   
   
   procedure Read_Pressure is
      
      Pressure : Integer;
      
   begin
      
      AS_Put_Line("Please type in current Pressure (psi) as read by sensors");
      
      loop
         AS_Get(Pressure,"Please type in an integer");
         exit when (Pressure >=0) and (Pressure <= Maximum_Pressure_Possible);
         
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_Pressure_Possible);
         AS_Put_Line("");
         
      end loop;
      
      Pressure_Status_System.Pressure_Measured := Pressure_Range(Pressure);
      
   end Read_Pressure;
   
	
   function Status_Pressure_Valve_To_String (Status_Pressure_Valve   : Status_Pressure_Valve_Type) return String is
     
      
   begin
      
      if (Status_Pressure_Valve = Open) 
      then return "Open";
      else return "Not Open";
      end if;
      
   end Status_Pressure_Valve_To_String;
   
   
   procedure Print_Pressure_Status is
      
   begin
      
      AS_Put("Pressure = ");
      AS_Put(Integer(Pressure_Status_System.Pressure_Measured));
      AS_Put_Line("");
      AS_Put("Pressure Valve = ");
      AS_Put_Line(Status_Pressure_Valve_To_String(Pressure_Status_System.Status_Pressure_Valve));
      
   end Print_Pressure_Status;
   
   
   procedure Monitor_Pressure_Valve  is
      
   begin
      
      if Integer(Pressure_Status_System.Pressure_Measured) > Critical_Pressure 
      then Pressure_Status_System.Status_Pressure_Valve := Open;
      else Pressure_Status_System.Status_Pressure_Valve := Not_Open;
      end if;
      
   end Monitor_Pressure_Valve;
  
   
   procedure Init is
      
   begin
      
      AS_Init_Standard_Input; 
      AS_Init_Standard_Output;
      Status_System := (Thrust_Level_Measured  => 0,
                        Status_Thrust_Adjustment_System => Not_Activated,
                        Critical_Thrust_Level => 0, 
                        Altitude_Measured => 0);
      Pressure_Status_System := (Pressure_Measured  => 0,
                                 Status_Pressure_Valve => Not_Open);
      
   end Init;
   
   
end Rocket_System;
	


