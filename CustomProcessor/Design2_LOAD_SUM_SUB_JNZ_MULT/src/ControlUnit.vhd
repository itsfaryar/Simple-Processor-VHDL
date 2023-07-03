
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity ControlUnit is  
	 port( clk,rst: in std_logic;
	      ZR0,ZR1,ZR2,ZR3 : in std_logic;
		  ROUT_IR : in std_logic_vector(6 downto 0);
		  LD0,LD1,LD2,LD3 : out std_logic;
		  LD_PC , LD_IR :out std_logic;
		  selm0_0,selm0_1,selm1_0,selm1_1: out std_logic;
		  BUS_sel : out std_logic;  
		  ALU_CMD : out std_logic_vector(1 downto 0);
		  INC , CLR : out std_logic);
end ControlUnit;


architecture ControlUnit of ControlUnit is 
	signal index : integer;
	signal Z : std_logic_vector(3 downto 0);
	type States is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S_HLT);																  
	signal STATE : States;	
begin
	index <= to_integer(unsigned(ROUT_IR(3 downto 2))); 
	
	Z(0) <= ZR0;
	Z(1) <= ZR1;
	Z(2) <= ZR2;
	Z(3) <= ZR3;
	
	process( rst, CLK ) 	
	begin
		if(rst = '1') then
			  
			CLR   <= '1';
			LD0   <= '0';    	  
			LD1   <= '0';     
			LD2   <= '0';     
			LD3   <= '0';
			LD_IR  <= '0';
			LD_PC  <= '0';
			INC   <= '0';
			BUS_Sel <= '0';
			
			STATE <= S0;
			
		elsif( rising_edge(CLK) ) then	
				CLR   <= '0';
				LD0   <= '0';    	  
				LD1   <= '0';     
				LD2   <= '0';     
				LD3   <= '0';
				LD_IR  <= '0';
				LD_PC  <= '0';
				INC   <= '0';
				BUS_Sel <= '0';
				ALU_CMD <= "00";
			case STATE is			
				when S0 => 
					INC <= '1';
					LD0 <= '0';
					LD1 <= '0';
					LD2 <= '0';
					LD3 <= '0';
					LD_IR <= '1';
					LD_PC <= '0';
					
					BUS_Sel <= '0';
					
					STATE <= S1;
					
				when S1 =>
					CLR <= '0';
					INC <= '0';
					LD_IR <= '0';
					
					STATE <= S_HLT;
					
				when S_HLT =>

					if(ROUT_IR= "0000000")then 
						STATE <= S2;			
					elsif (ROUT_IR(6 downto 4)= "000")then 
						STATE <= S3;
					elsif (ROUT_IR(6 downto 4) = "001")then 
						STATE <= S4; 	
					elsif (ROUT_IR(6 downto 4) = "010")then 
						STATE <= S5;
					elsif (ROUT_IR(6 downto 4) = "011")then 
						if(Z(index) = '0')then 
							STATE <= S6; 
						else
							STATE <= S7; 
						end if;
					elsif (ROUT_IR(6 downto 4) = "100") then	
						STATE <= S8;	
					end if;
				
				when S2 => 
					INC <= '0';
					STATE <= S2;
				
				when S3 => 
					if(ROUT_IR(3 downto 2) = "00")then
						LD0 <= '1';					   
					elsif(ROUT_IR(3 downto 2) = "01")then
						LD1 <= '1';						   	
					elsif(ROUT_IR(3 downto 2) = "10")then
						LD2 <= '1';						   	
					elsif(ROUT_IR(3 downto 2) = "11")then
						LD3 <= '1';						 	
					end if;
					
					INC <= '1';
					BUS_Sel <= '0';
					
					STATE <= S0;
				
				when S4 => 
					if(ROUT_IR(3 downto 2) = "00")then
						LD0 <= '1';
					elsif(ROUT_IR(3 downto 2) = "01")then
						LD1 <= '1';
					elsif(ROUT_IR(3 downto 2) = "10")then
						LD2 <= '1';
					elsif(ROUT_IR(3 downto 2) = "11")then
						LD3 <= '1';
					end if;
					
					alu_CMD <= "00";
					BUS_Sel <= '1';	
					selm0_0 <= ROUT_IR(2);
					selm0_1 <= ROUT_IR(3);
					
					-- MUX1 selector
					selm1_0 <= ROUT_IR(0);
					selm1_1 <= ROUT_IR(1);
					
					STATE <= S0;
				
				when S5 => -- SUB STATE
					-- set LDx = 1 for output register
					if(ROUT_IR(3 downto 2) = "00")then
						LD0 <= '1';
					elsif(ROUT_IR(3 downto 2) = "01")then
						LD1 <= '1';
					elsif(ROUT_IR(3 downto 2) = "10")then
						LD2 <= '1';
					elsif(ROUT_IR(3 downto 2) = "11")then
						LD3 <= '1';
					end if;
					
					alu_CMD <= "01";
					BUS_Sel <= '1';
					
					-- MUX0 selector
					selm0_0 <= ROUT_IR(2);
					selm0_1 <= ROUT_IR(3);
					
					-- MUX1 selector
					selm1_0 <= ROUT_IR(0);
					selm1_1 <= ROUT_IR(1);
					
					STATE <= S0;
					
				
				when S6 => 
					LD_PC <= '1';
					BUS_Sel <= '0';
					STATE <= S0;
				
				when S7 =>
					INC <= '1';
					STATE <= S0;
					
				when S8 =>
					if(ROUT_IR(3 downto 2) = "00")then
						LD0 <= '1';
					elsif(ROUT_IR(3 downto 2) = "01")then
						LD1 <= '1';
					elsif(ROUT_IR(3 downto 2) = "10")then
						LD2 <= '1';
					elsif(ROUT_IR(3 downto 2) = "11")then
						LD3 <= '1';
					end if;
					
					alu_CMD <= "10";
					BUS_Sel <= '1';	
			
					selm0_0 <= ROUT_IR(2);
					selm0_1 <= ROUT_IR(3);
					
					-- MUX1 selector
					selm1_0 <= ROUT_IR(0);
					selm1_1 <= ROUT_IR(1);
					
					STATE <= S0;
			end case;		
		end if;
	end process ;
	 

end ControlUnit;
