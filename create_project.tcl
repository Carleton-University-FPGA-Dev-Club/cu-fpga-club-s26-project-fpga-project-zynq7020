
set proj_name zybo_imgprocP1
set part xc7z020clg400-1
set bd_name design_1

create_project $proj_name ./phase1 -part $part -force

set src_files{}
foreach line $raw {
    set line [string trim $line]
    if {$line eq "" || [string match "#*" $line]} { continue }
    lappend src_files $line
}
add_files $src_files

#sim + con
add_files -fileset sim_1 hw/sim/tb_pipeline.sv
add_files -fileset constrs_1 hw/constraint/Zybo-Z7-Master.xdc

set_property file_type SystemVerilog [get_files *.sv]

#block diagram automation
set bd_script ".hw/bd/${bd_name}.tcl"
if {[file exists $bd_script]} {
    # rgb2dvi (you have to get from https://github.com/Digilent/vivado-library#)
    if {[file isdirectory ./ip/vivado-library]} {
        set_property ip_repo_paths [list ./ip/vivado-library] [current_project]
        update_ip_catalog
    }
    source $bd_script
    set bd_file [get_files ${bd_name}.bd]
    generate_target all $bd_file
    make_wrapper -files $bd_file =top
    add_files ./phase1/phase1.gen/sources_1/bd/${bd_name}/hdl/${bd_name}_wrapper.v
    set_property top ${bd_name}_wrapper [current_fileset]
} else {
    set_property top top [current_fileset]
}

set_property top tb_pipeline [get_filesets sim_1]
update_compiler_order -fileset sources_1
