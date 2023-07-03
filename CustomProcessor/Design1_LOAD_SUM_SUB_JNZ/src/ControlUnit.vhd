library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ControlUnit is  
	 port( clk,rst: in std_logic;
	      ZR0,ZR1,ZR2,ZR3 : in std_logic;
		  ROUT_IR : in std_logic_vector(5 downto 0);
		  LD0,LD1,LD2,LD3 : out std_logic;
		  LD_PC , LD_IR :out std_logic;
		  Sel0: out std_logic_vector(1 downto 0);
		  Sel1: out std_logic_vector(1 downto 0);
		  BUS_sel , ALU_CMD : out std_logic;
		  INC , CLR : out std_logic);
end ControlUnit;


architecture ControlUnit of ControlUnit is 

   type FSM is (S0,S1,HLTSTATE,S2,S3,S4,S5,S6,S7);
   signal PSTATE,NSTATE : FSM;
   signal HLT : std_logic;
   signal temp : integer;
   signal R : std_logic_vector(0 to 3);
   
begin
	
	 temp <= conv_integer(ROUT_IR(3 downto 2));
     R(0) <= ZR0;
     R(1) <= ZR1;
     R(2) <= ZR2;
     R(3) <= ZR3;
	
	process(ROUT_IR)
	begin
		if(ROUT_IR = "000000") then
			HLT <= '1';
		else  
			HLT <= '0';
			
		end if;
		end process;
--------------------------------------------------- FSM -----------------------------------------------------------		
	
process(clk,rst) 
	begin 
	    if(rst='1') then
			PSTATE <= S0;
		 elsif(rising_edge(clk)) then
		    PSTATE <= NSTATE;
		  end if;
end process;	 
-------------------------- so -----------------------------		  
process(PSTATE,ROUT_IR,ZR0,ZR1,ZR2,ZR3)
	begin
		case PSTATE is
			when S0 => CLR <= '1';  	
	     		LD_IR <= '0'; 
         		INC <= '0'; 
	     		LD_PC <= '0'; 
	     		Bus_sel <= '0';
		 		LD0 <= '0';
	     		LD1 <= '0';
		 		LD2 <= '0';
		 		LD3 <= '0';
		 		LD_PC <= '0'; 
	     		Bus_sel <= '0';
		 		ALU_CMD <= '0';
		 		Sel0 <= "00";
		 		Sel1 <= "00";
	 			NSTATE <= S1;
----------------------------- s1 ---------------------
			when S1 => LD_IR <= '1'; 
        		INC <= '1'; 
        		LD_PC <= '0'; 
        		Bus_sel <= '0';
	    		CLR <= '0';
    			LD0 <= '0';
	    		LD1 <= '0';
	    		LD2 <= '0';
	    		LD3 <= '0';
	    		ALU_CMD <= '0';
				Sel0 <= "00";
				Sel1 <= "00";
   				NSTATE <= HLTSTATE;		
------------------------- hltstate ----------------------------------------					

			when HLTSTATE => if(ROUT_IR = "000000") then NSTATE <= S2 ;
		 		else	
		   		if(ROUT_IR(5 downto 4) = "00")then
			 		NSTATE <= S3;
				 elsif(ROUT_IR(5 downto 4) = "01")then
		    		NSTATE <= S4;
			     elsif(ROUT_IR(5 downto 4) = "10")then
	        		NSTATE <= S5;
				 elsif(ROUT_IR(5 downto 4) = "11")then
				if(R(temp) = '1')then
		    		NSTATE <= S7;
					else
		    		NSTATE <= S6;
			    end if;
			  	end if;
				end if;

			  	CLR <= '0';
				Bus_sel <= '0';
				LD0 <= '0';
				LD1 <= '0';
				LD2 <= '0';
				LD3 <= '0';
				ALU_CMD <= '0';
				Sel0 <= "00";
				Sel1 <= "00"; 
				LD_PC <= '0'; 		 
				LD_IR <= '0';
				INC <= '0';
---------------------------------- s2 -------------------------------------								  
			when S2 => 
				CLR <= '0';
				Bus_sel <= '0';
				LD0 <= '0';
				LD1 <= '0';
				LD2 <= '0';
				LD3 <= '0';				
				ALU_CMD <= '0';
				Sel0 <= "00";
				Sel1 <= "00"; 
				LD_PC <= '0'; 
				LD_IR <= '0';	 
				NSTATE <= S2;
----------------------------------- s3 -------------------------------------				
			when S3 =>  if(ROUT_IR(3 downto 2) = "00") then LD0 <= '1';
					elsif(ROUT_IR(3 downto 2)= "01") then LD1 <= '1';
			  		 elsif(ROUT_IR(3 downto 2)= "10") then LD2 <= '1';
					  elsif(ROUT_IR(3 downto 2)= "11") then LD3 <= '1';
						end if;
								
				INC <= '1';
				LD_PC <= '0';
				Bus_sel <= '0';
				CLR <= '0';
				LD_IR <= '0';
				ALU_CMD <= '0';
				Sel0 <= "00";
				Sel1 <= "00";
				NSTATE <= S1;
--------------------------------- s4 ---------------------------								

			when S4 => 	Sel0 <= ROUT_IR(3 downto 2);
		        Sel1 <= ROUT_IR(1 downto 0);
								
            	if(ROUT_IR(3 downto 2) = "00") then LD0 <= '1';
		     	elsif(ROUT_IR(3 downto 2)= "01") then LD1 <= '1';
			  	elsif(ROUT_IR(3 downto 2)= "10") then LD2 <= '1';
			   	elsif(ROUT_IR(3 downto 2)= "11") then LD3 <= '1';
				end if;
								
				ALU_CMD <= '0';
				Bus_sel <= '1';
				CLR <= '0';
				LD_IR <= '0';
				INC <= '0';
				LD_PC <= '0'; 
				NSTATE <= S1;
								
----------------------------------- s5 -----------------------------------------								
						
			when S5 => 	Sel0 <= ROUT_IR(3 downto 2);
	            Sel1 <= ROUT_IR(1 downto 0);
							
				if(ROUT_IR(3 downto 2) = "00") then LD0 <= '1';
			   	elsif(ROUT_IR(3 downto 2)= "01") then LD1 <= '1';
			  	elsif(ROUT_IR(3 downto 2)= "10") then LD2 <= '1';
				elsif(ROUT_IR(3 downto 2)= "11") then LD3 <= '1';
				end if;
				
				ALU_CMD <= '1';
				Bus_sel <= '1';
				CLR <= '0';
				LD_IR <= '0';
				INC <= '0';
				LD_PC <= '0';
				NSTATE <= S1;
---------------------------------- s6 -----------------------------					
								
			when S6 => 	LD_PC <= '1'; 
				INC <= '0'; 
				Bus_sel <= '0'; 
				CLR <= '0';
				LD0 <= '0';
				LD1 <= '0';
				LD2 <= '0';
				LD3 <= '0';
				LD_IR <= '0';
				Sel0 <= "00";
				Sel1 <= "00";
				ALU_CMD <='0';	      
				NSTATE <= S1;
								
---------------------------------- s7 ---------------------------------			

			when S7 =>  INC <= '1'; 
				LD_PC <= '0'; 
				CLR <= '0';
				LD0 <= '0';
				LD1 <= '0';
				LD2 <= '0';
				LD3 <= '0';
				
				LD_IR <= '0';
				Sel0 <= "00";
				Sel1 <= "00";
				ALU_CMD <= '0';
				Bus_sel <= '0';
				NSTATE<= S1;
								
			end case;
				
	end process;
					
					
end ControlUnit;
