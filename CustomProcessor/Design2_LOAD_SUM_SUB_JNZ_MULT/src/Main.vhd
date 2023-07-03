library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Main is 
	port(
		 CLK : in STD_LOGIC;
	   	 RST : in STD_LOGIC;
		 BUS_Sel : out STD_LOGIC;
		 INC : out std_logic ;
		 CMD : out STD_LOGIC;
		 IR : out STD_LOGIC_VECTOR(6 downto 0);		  
		 PC : out STD_LOGIC_VECTOR(6 downto 0);
		 LD_REG : out STD_LOGIC_VECTOR(0 to 3);
		 Reg0 : out STD_LOGIC_VECTOR(6 downto 0);
		 Reg1 : out STD_LOGIC_VECTOR(6 downto 0);
		 Reg2 : out STD_LOGIC_VECTOR(6 downto 0);
		 Reg3 : out STD_LOGIC_VECTOR(6 downto 0);
		 ALU_out : out STD_LOGIC_VECTOR(6 downto 0);
		 bus_data : out STD_LOGIC_VECTOR(6 downto 0);
		 Memory_Data : out STD_LOGIC_VECTOR(6 downto 0)
	     );
end Main;

--}} End of automatically maintained section

architecture Main of Main is	

signal LD0_sig,LD1_sig,LD2_sig,LD3_sig,LD_PC_sig, LD_IR_sig, ZR0_sig, ZR1_sig, ZR2_sig, ZR3_sig, INC_sig, CLR_sig,BUS_Sel_sig : std_logic;
signal RIN0_sig, RIN1_sig, RIN2_sig, RIN3_sig, RIN_PC_sig, RIN_IR_sig, ROUT0_sig, ROUT1_sig, ROUT2_sig, ROUT3_sig, ROUT_PC_sig, ROUT_IR_sig,MData_sig,bus_input_sig : std_logic_vector(6 downto 0);
signal alu_in1_sig, alu_in2_sig, alu_result_sig : std_logic_vector(6 downto 0);		 
signal selm0_0_sig,selm0_1_sig,selm1_0_sig,selm1_1_sig : std_logic;	 
signal alu_cmd_sig :  std_logic_vector(1 downto 0);

component ALU is
	
	port(
		in1,in2 : in std_logic_vector(6 downto 0);
		alu_cmd : in std_logic;
		result : out std_logic_vector(6 downto 0)
		);
end component;

component MRegester is	
	port(  
	     RIN : in std_logic_vector(6 downto 0);
	     CLK : in std_logic;
		 LD : in std_logic;
		 ROUT : out std_logic_vector(6 downto 0);
		 ZR : out std_logic);
end component;

component IR_Regester is	
	port(  
	     RIN : in std_logic_vector(6 downto 0);
	     CLK : in std_logic;
		 LD : in std_logic;
		 ROUT : out std_logic_vector(6 downto 0)
		);
end component; 

component PC_Regester is	
	port(  
	     RIN : in std_logic_vector(6 downto 0);
	     CLK : in std_logic;
		 LD, INC, CLR : in std_logic;	 
		 ROUT : out std_logic_vector(6 downto 0));
	
end component; 					

component ControlUnit is  
	port( clk,rst: in std_logic;
	      ZR0,ZR1,ZR2,ZR3 : in std_logic;
		  ROUT_IR : in std_logic_vector(6 downto 0);
		  LD0,LD1,LD2,LD3 : out std_logic;
		  LD_PC , LD_IR :out std_logic;
		  selm0_0,selm0_1,selm1_0,selm1_1: out std_logic;
		  BUS_sel : out std_logic;  
		  ALU_CMD : out std_logic_vector(1 downto 0);
		  INC , CLR : out std_logic);
end component;	 

component MUX4x2 is  
	port(
		in0,in1,in2,in3  : in std_logic_vector(6 downto 0);
	    S0,S1                : in std_logic;
		output : out std_logic_vector(6 downto 0)
	);
end component; 
 component MUX2x2 is	
	port(
		in0,in1 : in std_logic_vector(6 downto 0);
	    S                : in std_logic;
		output : out std_logic_vector(6 downto 0)
	);
end component;
component Memory is	
	port(
	     Address : in std_logic_vector(6 downto 0);
		 Data : out std_logic_vector(6 downto 0)
		 );	
end component;
begin		
	-- Regesters   
	---Main
	Reg0_Cmp     : MRegester       PORT MAP (RIN=>bus_input_sig, CLK=>CLK, LD=>LD0_sig, ZR=>ZR0_sig, ROUT=>ROUT0_sig);	  
	Reg1_Cmp     : MRegester       PORT MAP (RIN=>bus_input_sig, CLK=>CLK, LD=>LD1_sig, ZR=>ZR1_sig, ROUT=>ROUT1_sig);
	Reg2_Cmp     : MRegester       PORT MAP (RIN=>bus_input_sig, CLK=>CLK, LD=>LD2_sig, ZR=>ZR2_sig, ROUT=>ROUT2_sig);
	Reg3_Cmp     : MRegester       PORT MAP (RIN=>bus_input_sig, CLK=>CLK, LD=>LD3_sig, ZR=>ZR3_sig, ROUT=>ROUT3_sig);	 
	---PC																					  
	Reg_PC   : PC_Regester     PORT MAP (RIN=>bus_input_sig, CLK=>CLK, LD=>LD_PC_sig,CLR=> CLR_sig, INC=> INC_sig , ROUT=>ROUT_PC_sig);	 
	---IR
	Reg_IR   : IR_Regester     PORT MAP (RIN=>bus_input_sig, CLK=>CLK, LD=>LD_IR_sig , ROUT=>ROUT_IR_sig); 
	
	-- ALU
	ALU0     : ALU             PORT MAP (in1=>alu_in1_sig, in2=>alu_in2_sig, alu_cmd=>alu_cmd_sig,result =>alu_result_sig);		  
	--Control Unit
	ControlUnit_inst : ControlUnit port map(clk => CLK,rst => RST,ZR0 => ZR0_sig,ZR1 => ZR1_sig,ZR2 => ZR2_sig,ZR3 => ZR3_sig,ROUT_IR => ROUT_IR_sig,LD0 => LD0_sig,LD1 => LD1_sig,LD2 => LD2_Sig,LD3 => LD3_sig,LD_PC => LD_PC_sig,LD_IR => LD_IR_sig, selm0_0 =>selm0_0_sig ,selm0_1 => selm0_1_sig,selm1_0 => selm1_0_sig, selm1_1 => selm1_1_sig,BUS_Sel => BUS_Sel_sig,ALU_CMD => alu_cmd_sig,INC => INC_sig,CLR => CLR_Sig);
	ROM0             : Memory      PORT MAP (Address=>ROUT_PC_sig, Data=>MData_sig);	
	
	--ALU inputs MUltiplexers  
	MUX0     : MUX4x2          PORT MAP  (in0=> ROUT0_sig, in1=>ROUT1_sig, in2=>ROUT2_sig, in3=>ROUT3_sig, s0=>selm0_0_sig,s1=>selm0_1_sig, output=>alu_in1_sig);							 
	MUX1     : MUX4x2          PORT MAP  (in0=> ROUT0_sig, in1=>ROUT1_sig, in2=>ROUT2_sig, in3=>ROUT3_sig, s0=>selm1_0_sig,s1=>selm1_1_sig, output=>alu_in2_sig);
	--BUS 
	MUX2     : MUX2x2          port map(S => BUS_Sel_sig, in0 => MData_sig, in1 => alu_result_sig, output => bus_input_sig);
	
	BUS_Sel <= BUS_Sel_sig;
	INC <= INC_sig;
	CMD <= alu_cmd_sig;
	IR  <= ROUT_IR_sig;	
	PC <= Rout_PC_sig;
	LD_REG(0) <= LD0_sig;
	LD_REG(1) <= LD1_Sig;
	LD_REG(2) <= LD2_sig;
	LD_REG(3) <= LD3_sig;
	Reg0      <= Rout0_sig;
	Reg1      <= Rout1_sig;
	Reg2      <= Rout2_sig;
	Reg3      <= Rout3_Sig;
	ALU_out   <= alu_result_sig;
	bus_data  <= bus_input_sig;
	Memory_Data <= MData_sig;
end Main;

