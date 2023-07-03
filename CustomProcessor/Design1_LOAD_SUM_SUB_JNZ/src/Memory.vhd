library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use ieee.numeric_std.all; 
entity Memory is	
	port(
	     Address : in std_logic_vector(5 downto 0);
		 Data : out std_logic_vector(5 downto 0)
		 );	
end Memory;
architecture Memory of Memory is
type mem_type is array(0 to 63) of std_logic_vector(5 downto 0);
signal ROM : mem_type;
begin
ROM(0) <= "000001";
ROM(1) <= "000000";
ROM(2) <= "000101";
ROM(3) <= "000001";
ROM(4) <= "001001";
ROM(5) <= "001000";
ROM(6) <= "001101";
ROM(7) <= "000110";
ROM(8) <= "010010";
ROM(9) <= "101101";
ROM(10) <= "111100";
ROM(11) <= "001000";
ROM(12) <= "000000";
Data <= ROM(to_integer(unsigned(Address)));
end Memory;