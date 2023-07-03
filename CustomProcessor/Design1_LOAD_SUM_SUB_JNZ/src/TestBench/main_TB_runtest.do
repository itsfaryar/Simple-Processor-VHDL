SetActiveLib -work
comp -include "$dsn\src\Main.vhd" 
comp -include "$dsn\src\TestBench\main_TB.vhd" 
asim +access +r TESTBENCH_FOR_main 
wave 
wave -noreg CLK
wave -noreg RST
wave -noreg BUS_Sel
wave -noreg INC
wave -noreg CMD
wave -noreg IR
wave -noreg PC
wave -noreg LD_REG
wave -noreg Reg0
wave -noreg Reg1
wave -noreg Reg2
wave -noreg Reg3
wave -noreg Select0
wave -noreg Select1
wave -noreg ALU_out
wave -noreg bus_data
wave -noreg Memory_Data
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\main_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_main 
