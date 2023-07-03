
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX4x2 is  
	port(
		in0,in1,in2,in3  : in std_logic_vector(5 downto 0);
	    S0,S1                : in std_logic;
		output : out std_logic_vector(5 downto 0)
	);
end MUX4x2;

--}} End of automatically maintained section

architecture MUX4x2 of MUX4x2 is
begin
	 	process( S0, S1, in0, in1, in2, in3 ) 
	begin 
		
		if ( S0 = '0' and S1 = '0' ) then
			output <= in0;
		elsif ( S0 = '1' and S1 = '0' ) then
			output <= in1;
		elsif ( S0 = '0' and S1 = '1' ) then
			output <= in2;
		elsif ( S0 = '1' and S1 = '1' ) then
			output <= in3;
		end if;	
	
	end process;	


end MUX4x2;
