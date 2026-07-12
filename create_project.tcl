#UNTESTED SHOULD BE FINE BUT STILL
create_project zybo_imgprocP1 ./phase1 -part xc7z020clg400-1 -force
# can probably combine this with files.f so we dont have to update both.
add_files [list \
    hw/rtl/pkg/img_pipe_pkg.sv
    hw/rtl/source/average_color.sv
    hw/rtl/source/pipeline_top.sv
    hw/rtl/source/test_image_gen.sv
    hw/rtl/source/timing_gen.sv
    hw/rtl/source/rgb_led_driver.sv
    hw/rtl/top.sv ]
add_files -fileset sim_1 hw\sim\tb_pipeline.sv
add_files -fileset constrs_1 Zybo-Z7-Master.xdc

set_property file_type SystemVerilog [get_files *.sv]
set_property top top [current_fileset]
set_property top tb_pipeline [get_filesets sim_1]

update_compiler_order -fileset sources_1