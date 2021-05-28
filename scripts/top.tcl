set TOP_LEVEL             approximate_multiplier

set CONSTRAINT_VIOLATION  reports/${TOP_LEVEL}_vio.rpt
set TIMING_RPT            reports/${TOP_LEVEL}_timing.rpt
set AREA_RPT              reports/${TOP_LEVEL}_area.rpt
set POWER_RPT		  reports/${TOP_LEVEL}_power.rpt
set QoR_RPT               reports/${TOP_LEVEL}_qor.rpt

#### READ FILE ####
set src_path "./src/"
set all_src "approximate_multiplier.v"
foreach src $all_src {
    analyze -format verilog -lib WORK $src_path$src
}
set TOP approximate_multiplier
elaborate $TOP -arch "verilog" -lib WORK -update

current_design $TOP_LEVEL
link

uniquify
link

#### CONSTRAINTS ####
#7nm
set MAX_LOAD [load_of asap7sc7p5t_INVBUF_RVT_TT_ccs_201020/INVx3_ASAP7_75t_R/A]
set_load [expr $MAX_LOAD*5] [all_outputs]

#55nm
#set MAX_LOAD [load_of scc55nll_vhs_rvt_tt_v1p2_25c_ccs/INVHSV0/I]
#set_load [expr $MAX_LOAD*5] [all_outputs]

#65nm
#set_wire_load_model -name 4000 -library SP65NLLD2_3P3V_v0p1_tt_v1p20_25C
#set MAX_LOAD [load_of scc65nll_hs_lvt_ff_v1p32_-40c_ccs/LVT_DRNHSV1/D]
#set_load [expr $MAX_LOAD*5] [all_outputs]

create_clock -period 333.33 -name VCLK
set_input_delay 0 -clock VCLK [all_inputs]
set_output_delay 0 -clock VCLK [all_outputs]


compile_ultra


#### REPORTS ####
report_constraints  > $CONSTRAINT_VIOLATION
report_timing       > $TIMING_RPT
report_area         > $AREA_RPT
report_power        > $POWER_RPT
report_qor          > $QoR_RPT
