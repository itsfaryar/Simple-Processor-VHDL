SetActiveLib -work
comp -include "$dsn\src\MRegester.vhd" 
comp -include "$dsn\src\TestBench\mregester_TB.vhd" 
asim +access +r TESTBENCH_FOR_mregester 
wave 
wave -noreg RIN
wave -noreg CLK
wave -noreg LD
wave -noreg ROUT
wave -noreg ZR
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\mregester_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_mregester 
