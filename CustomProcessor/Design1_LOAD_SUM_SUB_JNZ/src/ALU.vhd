library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	
port(
	in1,in2 : in std_logic_vector(5 downto 0);
	alu_cmd : in std_logic;
	result : out std_logic_vector(5 downto 0)
	);
end ALU;

architecture ALU of ALU is
 signal result_sig: std_logic_vector(5 downto 0);
	begin
		process(alu_cmd,in1,in2)
			begin
				case alu_cmd is
				 when '0' =>
				  result_sig <= in1 + in2; -- add
				 when '1' =>
				  result_sig <= in1 - in2; -- sub
				 when others => result_sig <= (others => 'Z');
				 end case;
		end process;
		result <= result_sig;

end ALU;
