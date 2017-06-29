@echo off
set xv_path=F:\\Install\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim adder_substraction_test_behav -key {Behavioral:sim_1:Functional:adder_substraction_test} -tclbatch adder_substraction_test.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
