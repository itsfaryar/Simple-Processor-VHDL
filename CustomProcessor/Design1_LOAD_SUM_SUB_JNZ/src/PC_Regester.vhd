							 library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity PC_Regester is	
	port(  
	     RIN : in std_logic_vector(5 downto 0);
	     CLK : in std_logic;
		 LD, INC, CLR : in std_logic;	 
		 ROUT : out std_logic_vector(5 downto 0));
	
end PC_Regester;


architecture PC_Regester of PC_Regester is 
 
--signal RN0,RN1,RN2,RN3,R_0,R_1,R_2,R_3: std_logic_vector(5 downto 0);
signal PC: std_logic_vector(5 downto 0);
begin

------------------------------ MAIN registers ------------------------------		   
	  			
	process(CLK,CLR)
	begin	
		if CLR = '1' then
			PC <= (others => '0');	
			
		elsif(rising_edge(CLK)) then
			if ( LD = '1') then
    			PC <=  RIN;
			end if;	
			if (INC = '1') then
				PC <= PC + 1;
			end if;
 
		end if;
	end process;
				
 	ROUT <= PC;
				 

	

end PC_Regester;


