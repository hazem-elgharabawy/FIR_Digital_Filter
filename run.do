vlib work
vlog -f source_files.list -mfcu
vsim -voptargs=+acc work.FIR_filter_tb 
add wave *
run -all