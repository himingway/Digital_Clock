# Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, the Altera Quartus Prime License Agreement,
# the Altera MegaCore Function License Agreement, or other 
# applicable license agreement, including, without limitation, 
# that your use is for the sole purpose of programming logic 
# devices manufactured by Altera and sold by Altera or its 
# authorized distributors.  Please refer to the applicable 
# agreement for further details.

# Quartus Prime: Generate Tcl File for Project
# File: DigitalWatch.tcl
# Generated on: Fri May 05 15:15:39 2017

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "DigitalWatch"]} {
		puts "Project DigitalWatch is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists DigitalWatch]} {
		project_open -revision DigitalWatch DigitalWatch
	} else {
		project_new -revision DigitalWatch DigitalWatch
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone IV E"
	set_global_assignment -name DEVICE EP4CE6F17C7
	set_global_assignment -name TOP_LEVEL_ENTITY DigitalWatch
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 16.0.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "17:19:28  APRIL 25, 2017"
	set_global_assignment -name LAST_QUARTUS_VERSION 16.0.0
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 1
	set_global_assignment -name EDA_SIMULATION_TOOL "QuestaSim (Verilog)"
	set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
	set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name TIMEQUEST_MULTICORNER_ANALYSIS ON
	set_global_assignment -name NUM_PARALLEL_PROCESSORS ALL
	set_global_assignment -name ENABLE_SIGNALTAP ON
	set_global_assignment -name USE_SIGNALTAP_FILE output_files/stp.stp
	set_global_assignment -name EDA_TEST_BENCH_ENABLE_STATUS TEST_BENCH_MODE -section_id eda_simulation
	set_global_assignment -name EDA_NATIVELINK_SIMULATION_TEST_BENCH DigitalWatch_vlg_tst -section_id eda_simulation
	set_global_assignment -name EDA_TEST_BENCH_NAME DigitalWatch_vlg_tst -section_id eda_simulation
	set_global_assignment -name EDA_DESIGN_INSTANCE_NAME NA -section_id DigitalWatch_vlg_tst
	set_global_assignment -name EDA_TEST_BENCH_MODULE_NAME DigitalWatch_vlg_tst -section_id DigitalWatch_vlg_tst
	set_global_assignment -name EDA_TEST_BENCH_FILE simulation/modelsim/DigitalWatch.vt -section_id DigitalWatch_vlg_tst
	set_global_assignment -name ENABLE_OCT_DONE OFF
	set_global_assignment -name STRATIXV_CONFIGURATION_SCHEME "PASSIVE SERIAL"
	set_global_assignment -name USE_CONFIGURATION_DEVICE OFF
	set_global_assignment -name CRC_ERROR_OPEN_DRAIN OFF
	set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
	set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -rise
	set_global_assignment -name OUTPUT_IO_TIMING_NEAR_END_VMEAS "HALF VCCIO" -fall
	set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -rise
	set_global_assignment -name OUTPUT_IO_TIMING_FAR_END_VMEAS "HALF SIGNAL SWING" -fall
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
	set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"
	set_global_assignment -name VERILOG_FILE scr/Week.v
	set_global_assignment -name VERILOG_FILE scr/DigitalWatch.v
	set_global_assignment -name VERILOG_FILE scr/Watch_Control.v
	set_global_assignment -name VERILOG_FILE scr/TimeandData.v
	set_global_assignment -name VERILOG_FILE scr/define.v
	set_global_assignment -name VERILOG_FILE scr/debounce/debounce_module.v
	set_global_assignment -name VERILOG_FILE scr/debounce/debounce_module2.v
	set_global_assignment -name VERILOG_FILE scr/debounce/detect_module.v
	set_global_assignment -name VERILOG_FILE scr/debounce/delay_module.v
	set_global_assignment -name VERILOG_FILE scr/smg/smg_scan_module.v
	set_global_assignment -name VERILOG_FILE scr/smg/smg.v
	set_global_assignment -name VERILOG_FILE scr/smg/smg_encoder_module.v
	set_global_assignment -name VERILOG_FILE scr/smg/row_scan_module.v
	set_global_assignment -name VERILOG_FILE scr/smg/number_mod_module.v
	set_global_assignment -name VERILOG_FILE scr/smg/column_scan_module.v
	set_global_assignment -name QIP_FILE PLL.qip
	set_global_assignment -name VECTOR_WAVEFORM_FILE Waveform.vwf
	set_global_assignment -name CDF_FILE output_files/Chain1.cdf
	set_location_assignment PIN_B4 -to Column_Scan_Sig[5]
	set_location_assignment PIN_A4 -to Column_Scan_Sig[4]
	set_location_assignment PIN_B3 -to Column_Scan_Sig[3]
	set_location_assignment PIN_A3 -to Column_Scan_Sig[2]
	set_location_assignment PIN_B1 -to Column_Scan_Sig[1]
	set_location_assignment PIN_A2 -to Column_Scan_Sig[0]
	set_location_assignment PIN_B7 -to Row_Scan_Sig[0]
	set_location_assignment PIN_A8 -to Row_Scan_Sig[1]
	set_location_assignment PIN_A6 -to Row_Scan_Sig[2]
	set_location_assignment PIN_B5 -to Row_Scan_Sig[3]
	set_location_assignment PIN_B6 -to Row_Scan_Sig[4]
	set_location_assignment PIN_A7 -to Row_Scan_Sig[5]
	set_location_assignment PIN_B8 -to Row_Scan_Sig[6]
	set_location_assignment PIN_A5 -to Row_Scan_Sig[7]
	set_location_assignment PIN_E16 -to Button1_IN
	set_location_assignment PIN_M16 -to Button2_IN
	set_location_assignment PIN_M15 -to Button3_IN
	set_location_assignment PIN_E1 -to clk
	set_location_assignment PIN_E15 -to Button0_IN
	set_location_assignment PIN_G15 -to Week[0]
	set_location_assignment PIN_F16 -to Week[1]
	set_location_assignment PIN_F15 -to Week[2]
	set_location_assignment PIN_D16 -to Week[3]
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Including default assignments
	set_global_assignment -name TIMEQUEST_REPORT_WORST_CASE_TIMING_PATHS ON -family "Cyclone IV E"
	set_global_assignment -name TIMEQUEST_CCPP_TRADEOFF_TOLERANCE 0 -family "Cyclone IV E"
	set_global_assignment -name TDC_CCPP_TRADEOFF_TOLERANCE 0 -family "Cyclone IV E"
	set_global_assignment -name TIMEQUEST_DO_CCPP_REMOVAL ON -family "Cyclone IV E"
	set_global_assignment -name TIMEQUEST_SPECTRA_Q OFF -family "Cyclone IV E"
	set_global_assignment -name SYNTH_TIMING_DRIVEN_SYNTHESIS ON -family "Cyclone IV E"
	set_global_assignment -name SYNCHRONIZATION_REGISTER_CHAIN_LENGTH 2 -family "Cyclone IV E"
	set_global_assignment -name SYNTH_RESOURCE_AWARE_INFERENCE_FOR_BLOCK_RAM ON -family "Cyclone IV E"
	set_global_assignment -name OPTIMIZE_HOLD_TIMING "ALL PATHS" -family "Cyclone IV E"
	set_global_assignment -name OPTIMIZE_MULTI_CORNER_TIMING ON -family "Cyclone IV E"
	set_global_assignment -name AUTO_DELAY_CHAINS ON -family "Cyclone IV E"

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
