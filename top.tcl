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
set_wire_load_model -name 4000 -library SP65NLLD2_3P3V_v0p1_tt_v1p20_25C
set_operating_conditions ff_v1p32_-40c
set_wire_load_mode segmented
set MAX_LOAD [load_of scc65nll_hs_lvt_ff_v1p32_-40c_ccs/LVT_DRNHSV1/D]
set_load [expr $MAX_LOAD*5] [all_outputs]


ungroup -flatten -all
compile -map_effort medium -ungroup_all

compile_ultra -inc


#### REPORTS ####
report_constraints  > $CONSTRAINT_VIOLATION
report_timing       > $TIMING_RPT
report_area         > $AREA_RPT
report_power        > $POWER_RPT
report_qor          > $QoR_RPT
