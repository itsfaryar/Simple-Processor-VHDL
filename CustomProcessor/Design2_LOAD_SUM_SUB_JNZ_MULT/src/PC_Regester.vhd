
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC_Regester is	
	port(  
	     RIN : in std_logic_vector(6 downto 0);
	     CLK : in std_logic;
		 LD, INC, CLR : in std_logic;	 
		 ROUT : out std_logic_vector(6 downto 0));
	
end PC_Regester;


architecture PC_Regester of PC_Regester is 
 
--signal RN0,RN1,RN2,RN3,R_0,R_1,R_2,R_3: std_logic_vector(6 downto 0);
signal PC, PC_next: std_logic_vector(6 downto 0):= "000000";
begin

------------------------------ MAIN registers ------------------------------		   
	 	FF: process( CLK, CLR )
	begin  
		if ( CLR = '1' ) then
			PC <=  "000000";  
		elsif ( rising_edge(CLK) ) then
			PC <= PC_next;	
		end if;
	end process FF;
	
	----------------------------------------------------------------------------
	LOGIC: process( RIN, PC, INC, LD )
	begin  
		if ( LD = '1' ) then
			PC_next <=  RIN;
		elsif ( INC = '1' ) then
			PC_next <= (PC + 1);
		end if;
	end process LOGIC;
	
	
	ROUT <= PC;  
				 

	

end PC_Regester;


