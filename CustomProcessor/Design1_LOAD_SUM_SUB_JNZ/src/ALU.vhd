library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_signed.all;

entity ALU is
	
port(
	in1,in2 : in std_logic_vector(5 downto 0);
	cmd : in std_logic;
	result : out std_logic_vector(5 downto 0)
	);
end ALU;

architecture ALU of ALU is
 signal result_sig: std_logic_vector(5 downto 0);
	begin
		process(cmd,in1,in2)
			begin
				case cmd is
				 when '0' =>
				  result_sig <= in1 + in2; -- add
				 when '1' =>
				  result_sig <= in1 - in2; -- sub
				 when others => result_sig <= (others => 'X');
				 end case;
		end process;
		result <= result_sig;

end ALU;
