SetActiveLib -work
comp -include "$dsn\src\PC_Regester.vhd" 
comp -include "$dsn\src\TestBench\pc_regester_TB.vhd" 
asim +access +r TESTBENCH_FOR_pc_regester 
wave 
wave -noreg RIN
wave -noreg CLK
wave -noreg LD
wave -noreg INC
wave -noreg CLR
wave -noreg ROUT
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\pc_regester_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_pc_regester 
