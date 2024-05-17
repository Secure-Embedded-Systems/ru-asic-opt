export DESIGN_NAME = poly1305
export PLATFORM    = sky130hd

export VERILOG_FILES = ./ru-asic-opt/poly1305_singlemul/rtl/processblock.v \
			./ru-asic-opt/poly1305_singlemul/rtl/poly1305.v

export SDC_FILE      = ./ru-asic-opt/poly1305_singlemul/work/constraint.sdc

export DIE_AREA    =   0   0   500   500
export CORE_AREA   =   5   5   495   495
