library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use ieee.numeric_std.all; 
entity Memory is	
	port(
	     Address : in std_logic_vector(6 downto 0);
		 Data : out std_logic_vector(6 downto 0)
		 );	
end Memory;
architecture Memory of Memory is
type mem_type is array(0 to 63) of std_logic_vector(5 downto 0);
signal ROM : mem_type;
begin
ROM(0) <= "000001";
ROM(1) <= "000110";
ROM(2) <= "000101";
ROM(3) <= "001000";
ROM(4) <= "110001";
ROM(5) <= "000000";
Data(5 downto 0) <= ROM(to_integer(unsigned(Address)));	  
data(6) <= '0';
end Memory;