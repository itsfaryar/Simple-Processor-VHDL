
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX4x2 is  
	port(
		in0,in1,in2,in3  : in std_logic_vector(5 downto 0);
	    s                : in std_logic_vector(1 downto 0);
		output : out std_logic_vector(5 downto 0)
	);
end MUX4x2;

--}} End of automatically maintained section

architecture MUX4x2 of MUX4x2 is
begin
	 	output <= in0 when s="00" else
       in1 when s="01" else
       in2 when s="10" else
       in3 when s="11";


end MUX4x2;
