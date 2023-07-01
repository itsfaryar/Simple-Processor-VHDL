SetActiveLib -work
comp -include "$dsn\src\IR_Regester.vhd" 
comp -include "$dsn\src\TestBench\ir_regester_TB.vhd" 
asim +access +r TESTBENCH_FOR_ir_regester 
wave 
wave -noreg RIN
wave -noreg CLK
wave -noreg LD
wave -noreg ROUT
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\ir_regester_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_ir_regester 
