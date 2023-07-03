library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MUX2x2 is	
	port(
		in0,in1 : in std_logic_vector(6 downto 0);
	    S                : in std_logic;
		output : out std_logic_vector(6 downto 0)
	);
end MUX2x2;

--}} End of automatically maintained section

architecture MUX2x2 of MUX2x2 is
begin

	 process( S, in0, in1 ) 
	begin 
		
		if ( S = '0' ) then
			output <= in0;
		elsif ( S = '1' ) then
			output <= in1;
		end if;	
	
	end process;

end MUX2x2;
