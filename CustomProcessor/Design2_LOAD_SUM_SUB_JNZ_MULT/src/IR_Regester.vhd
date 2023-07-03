library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity IR_Regester is	
	port(  
	     RIN : in std_logic_vector(6 downto 0);
	     CLK : in std_logic;
		 LD : in std_logic;
		 ROUT : out std_logic_vector(6 downto 0)
		);
	
end IR_Regester;


architecture IR_Regester of IR_Regester is 
 
--signal RN0,RN1,RN2,RN3,R_0,R_1,R_2,R_3: std_logic_vector(6 downto 0);
signal IR: std_logic_vector(6 downto 0);
begin

------------------------------ MAIN registers ------------------------------		   
	  			
	process(CLK)
       begin
		if(rising_edge(CLK)) then
			if ( LD = '1') then
    			IR <=  RIN;
			end if;
 
		end if;
	end process;
				
 	ROUT <= IR;
	

end IR_Regester;


