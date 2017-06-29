@echo off
set xv_path=F:\\Install\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 88de57ae81884a4c8521964bb48e011c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot adder_substraction_test_behav xil_defaultlib.adder_substraction_test -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
