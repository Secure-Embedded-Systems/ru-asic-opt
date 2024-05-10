export DESIGN_NAME = poly1305
export PLATFORM    = sky130hd

export VERILOG_FILES = ./crypto-asic-opt/poly1305/rtl/processblock.v \
			./crypto-asic-opt/poly1305/rtl/poly1305.v

export SDC_FILE      = ./crypto-asic-opt/poly1305/work/constraint.sdc

export DIE_AREA    =   0   0   1200   1200
export CORE_AREA   =   5   5   1195   1195
