library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity MRegester is	
	port(  
	     RIN : in std_logic_vector(6 downto 0);
	     CLK : in std_logic;
		 LD : in std_logic;
		 ROUT : out std_logic_vector(6 downto 0);
		 ZR : out std_logic);
	
end MRegester;


architecture MRegester of MRegester is 
 
--signal RN0,RN1,RN2,RN3,R_0,R_1,R_2,R_3: std_logic_vector(6 downto 0);
signal Reg: std_logic_vector(6 downto 0):="0000000";
begin

------------------------------ MAIN registers ------------------------------		   
	  			
	process(CLK)
       begin
		if(rising_edge(CLK)) then
			if ( LD = '1') then
    			Reg <=  RIN;
			end if;
 
		end if;
	end process;
				
 	ROUT <= Reg;
				 
	ZR  <= '1' when (Reg="0000000") else '0';
	

end MRegester;


