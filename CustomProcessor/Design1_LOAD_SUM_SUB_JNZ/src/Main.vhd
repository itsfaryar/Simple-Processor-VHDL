library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main is 
	port(
		 CLK : in STD_LOGIC
	     );
end Main;

--}} End of automatically maintained section

architecture Main of Main is	

signal LD0, LD1, LD2, LD3, LD_PC, LD_IR, ZR0, ZR1, ZR2, ZR3, INC, CLR, RST, alu_cmd : std_logic;
signal RIN0, RIN1, RIN2, RIN3, RIN_PC, RIN_IR, ROUT0, ROUT1, ROUT2, ROUT3, ROUT_PC, ROUT_IR : std_logic_vector(5 downto 0);
signal alu_in1, alu_in2, alu_result : std_logic_vector(5 downto 0);
component ALU is
	
	port(
		in1,in2 : in std_logic_vector(5 downto 0);
		cmd : in std_logic;
		result : out std_logic_vector(5 downto 0)
		);
end component;

component MRegester is	
	port(  
	     RIN : in std_logic_vector(5 downto 0);
	     CLK : in std_logic;
		 LD : in std_logic;
		 ROUT : out std_logic_vector(5 downto 0);
		 ZR : out std_logic);
end component;

component IR_Regester is	
	port(  
	     RIN : in std_logic_vector(5 downto 0);
	     CLK : in std_logic;
		 LD : in std_logic;
		 ROUT : out std_logic_vector(5 downto 0)
		);
end component; 

component PC_Regester is	
	port(  
	     RIN : in std_logic_vector(5 downto 0);
	     CLK : in std_logic;
		 LD, INC, CLR : in std_logic;	 
		 ROUT : out std_logic_vector(5 downto 0));
	
end component; 

begin		
	-- Regesters   
	---Main
	Reg0     : MRegester       PORT MAP (RIN=>RIN0, CLK=>CLK, LD=>LD0, ZR=>ZR0, ROUT=>ROUT0);	  
	Reg1     : MRegester       PORT MAP (RIN=>RIN1, CLK=>CLK, LD=>LD1, ZR=>ZR1, ROUT=>ROUT1);
	Reg2     : MRegester       PORT MAP (RIN=>RIN2, CLK=>CLK, LD=>LD2, ZR=>ZR2, ROUT=>ROUT2);
	Reg3     : MRegester       PORT MAP (RIN=>RIN3, CLK=>CLK, LD=>LD3, ZR=>ZR3, ROUT=>ROUT3);	 
	---PC
	Reg_PC   : PC_Regester     PORT MAP (RIN=>RIN_PC, CLK=>CLK, LD=>LD_PC,CLR=> CLR, INC=> INC , ROUT=>ROUT_PC);	 
	---IR
	Reg_IR   : IR_Regester     PORT MAP (RIN=>RIN_IR, CLK=>CLK, LD=>LD_IR , ROUT=>ROUT_IR); 
	
	-- ALU
	ALU0     : ALU             PORT MAP (in1=>alu_in1, in2=>alu_in2, cmd=>alu_cmd);
	
end Main;

