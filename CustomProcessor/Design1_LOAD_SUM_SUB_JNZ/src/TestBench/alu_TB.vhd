library ieee;
use ieee.STD_LOGIC_SIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity alu_tb is
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	-- Component declaration of the tested unit
	component alu
	port(
		in1 : in STD_LOGIC_VECTOR(5 downto 0);
		in2 : in STD_LOGIC_VECTOR(5 downto 0);
		cmd : in STD_LOGIC;
		result : out STD_LOGIC_VECTOR(5 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal in1 : STD_LOGIC_VECTOR(5 downto 0);
	signal in2 : STD_LOGIC_VECTOR(5 downto 0);
	signal cmd : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal result : STD_LOGIC_VECTOR(5 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		port map (
			in1 => in1,
			in2 => in2,
			cmd => cmd,
			result => result
		);

	-- Add your stimulus here ...
	process
		begin
			in1 <= "000011";
			in2 <= "000001";
			cmd <= '0';
			WAIT FOR 20 NS;
			cmd <= '1';
			WAIT FOR 20 NS;
		
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(alu);
		end for;
	end for;
end TESTBENCH_FOR_alu;

