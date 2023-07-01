library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity mregester_tb is
end mregester_tb;

architecture TB_ARCHITECTURE of mregester_tb is
	-- Component declaration of the tested unit
	component mregester
	port(
		RIN : in STD_LOGIC_VECTOR(5 downto 0);
		CLK : in STD_LOGIC;
		LD : in STD_LOGIC;
		ROUT : out STD_LOGIC_VECTOR(5 downto 0);
		ZR : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal RIN : STD_LOGIC_VECTOR(5 downto 0);
	signal CLK : STD_LOGIC;
	signal LD : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ROUT : STD_LOGIC_VECTOR(5 downto 0);
	signal ZR : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : mregester
		port map (
			RIN => RIN,
			CLK => CLK,
			LD => LD,
			ROUT => ROUT,
			ZR => ZR
		);

	-- Add your stimulus here ...  
	process
		begin
			clk <= '0';
			WAIT FOR 10 NS;
			clk <= '1';
			WAIT FOR 10 NS;
		
	end process;
	process
		begin
			RIN <= "000011";
			LD <= '1';
			WAIT FOR 20 NS;
			RIN <= "000000";
			LD <= '0';
			WAIT FOR 20 NS;	   
			RIN <= "000000";
			LD <= '1';
			WAIT FOR 20 NS;
		
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_mregester of mregester_tb is
	for TB_ARCHITECTURE
		for UUT : mregester
			use entity work.mregester(mregester);
		end for;
	end for;
end TESTBENCH_FOR_mregester;

