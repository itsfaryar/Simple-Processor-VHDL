library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity main_tb is
end main_tb;

architecture TB_ARCHITECTURE of main_tb is
	-- Component declaration of the tested unit
	component main
	port(
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		BUS_Sel : out STD_LOGIC;
		INC : out STD_LOGIC;
		CMD : out STD_LOGIC_VECTOR(1 downto 0);
		IR : out STD_LOGIC_VECTOR(6 downto 0);
		PC : out STD_LOGIC_VECTOR(6 downto 0);
		LD_REG : out STD_LOGIC_VECTOR(0 to 3);
		Reg0 : out STD_LOGIC_VECTOR(6 downto 0);
		Reg1 : out STD_LOGIC_VECTOR(6 downto 0);
		Reg2 : out STD_LOGIC_VECTOR(6 downto 0);
		Reg3 : out STD_LOGIC_VECTOR(6 downto 0);
		ALU_out : out STD_LOGIC_VECTOR(6 downto 0);
		bus_data : out STD_LOGIC_VECTOR(6 downto 0);
		Memory_Data : out STD_LOGIC_VECTOR(6 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal RST : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal BUS_Sel : STD_LOGIC;
	signal INC : STD_LOGIC;
	signal CMD : STD_LOGIC_VECTOR(1 downto 0);
	signal IR : STD_LOGIC_VECTOR(6 downto 0);
	signal PC : STD_LOGIC_VECTOR(6 downto 0);
	signal LD_REG : STD_LOGIC_VECTOR(0 to 3);
	signal Reg0 : STD_LOGIC_VECTOR(6 downto 0);
	signal Reg1 : STD_LOGIC_VECTOR(6 downto 0);
	signal Reg2 : STD_LOGIC_VECTOR(6 downto 0);
	signal Reg3 : STD_LOGIC_VECTOR(6 downto 0);
	signal ALU_out : STD_LOGIC_VECTOR(6 downto 0);
	signal bus_data : STD_LOGIC_VECTOR(6 downto 0);
	signal Memory_Data : STD_LOGIC_VECTOR(6 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : main
		port map (
			CLK => CLK,
			RST => RST,
			BUS_Sel => BUS_Sel,
			INC => INC,
			CMD => CMD,
			IR => IR,
			PC => PC,
			LD_REG => LD_REG,
			Reg0 => Reg0,
			Reg1 => Reg1,
			Reg2 => Reg2,
			Reg3 => Reg3,
			ALU_out => ALU_out,
			bus_data => bus_data,
			Memory_Data => Memory_Data
		);

	-- Add your stimulus here ...
	rst <= '0';
	process
		begin
			clk <= '0';
			WAIT FOR 10 NS;
			clk <= '1';
			WAIT FOR 10 NS;
		
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_main of main_tb is
	for TB_ARCHITECTURE
		for UUT : main
			use entity work.main(main);
		end for;
	end for;
end TESTBENCH_FOR_main;

