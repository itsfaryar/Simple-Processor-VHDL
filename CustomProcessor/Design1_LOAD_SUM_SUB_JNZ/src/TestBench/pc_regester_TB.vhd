library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity pc_regester_tb is
end pc_regester_tb;

architecture TB_ARCHITECTURE of pc_regester_tb is
	-- Component declaration of the tested unit
	component pc_regester
	port(
		RIN : in STD_LOGIC_VECTOR(5 downto 0);
		CLK : in STD_LOGIC;
		LD : in STD_LOGIC;
		INC : in STD_LOGIC;
		CLR : in STD_LOGIC;
		ROUT : out STD_LOGIC_VECTOR(5 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal RIN : STD_LOGIC_VECTOR(5 downto 0);
	signal CLK : STD_LOGIC;
	signal LD : STD_LOGIC;
	signal INC : STD_LOGIC;
	signal CLR : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ROUT : STD_LOGIC_VECTOR(5 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : pc_regester
		port map (
			RIN => RIN,
			CLK => CLK,
			LD => LD,
			INC => INC,
			CLR => CLR,
			ROUT => ROUT
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
			CLR <= '1';	 
			RIN <= "000000";
			LD <=  '0';	  
			INC <= '0';
			WAIT FOR 20 NS;	  
			CLR <= '0';	
			RIN <= "000000";
			LD <=  '0';	  
			INC <= '1';
			WAIT FOR 20 NS;	
			CLR <= '0';
			RIN <= "000011";
			LD <= '1';		
			INC <= '0';
			WAIT FOR 20 NS;
			RIN <= "000000";
			LD <=  '0';	  
			INC <= '1';
			WAIT FOR 20 NS;	 
			CLR <= '0';
			RIN <= "000000";
			LD <=  '0';	  
			INC <= '1';
			WAIT FOR 20 NS;
		
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pc_regester of pc_regester_tb is
	for TB_ARCHITECTURE
		for UUT : pc_regester
			use entity work.pc_regester(pc_regester);
		end for;
	end for;
end TESTBENCH_FOR_pc_regester;

