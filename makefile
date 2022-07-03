
BUILD_NAME = /home/rocky/Repositories/uvm_verification_example
QVH_HOME = /opt/intelFPGA/20.1/modelsim_ase/linux
RTL_DIR = ${BUILD_NAME}/src
RTL_INC = +incdir+${RTL_DIR}
TB_DIR = ${BUILD_NAME}/tb
TB_INC = +incdir+${TB_DIR}
ENV_INC = +incdir+${TB_DIR}
#TESTS_INC = +incdir+${BUILD_NAME}/tb/tests

UVM_SRC = /opt/intelFPGA/20.1/modelsim_ase/verilog_src/uvm-1.2/src

WORK : clean
	vlib work

RTL : WORK
	vlog -sv ${RTL_INC} ${RTL_DIR}/det_1011_v1.0.sv

TB : RTL
	vlog -sv ${RTL_INC} ${TB_INC} -L uvm +incdir+${UVM_SRC}+${ENV_INC} ${UVM_SRC}/uvm_pkg.sv ${TB_DIR}/tb.sv ${UVM_SRC}/dpi/uvm_dpi.cc -ccflags -DQUESTA

SIM : TB
	vsim ${RTL_INC} ${TB_INC} ${ENV_INC} tb -c -do "add wave -r /*; run -all; quit" -l vsim.log

clean:
	rm -rf work vlib.log vlog.log vsim.log vsim.wlf
