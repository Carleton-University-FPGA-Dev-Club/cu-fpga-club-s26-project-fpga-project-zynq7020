`timescale 1ns/1ps
//maps the smaller components together
import img_pipe_pkg::*;

module pipeline_top (
    input logic clk,
    input logic rst_n,
    //pattern sel

    output logic led_r,
    output logic led_g,
    output logic led_b,
    output logic valid // a fingerprint saying its done processing basically
);
    //Modular component 1. SOURCE
    pixel_bus_t src;
    test_image_gen u_src (
        .clk(clk),
        .rst_n(rst_n),
        .out(src)
    );

    //Modular Component 2. PROC
    pixel_t proc;
    average_color u_avg (
        .clk(clk),
        .rst_n(rst_n),
        .in(src),
        .avg(proc),
        .avg_valid(valid)
    );

    //Modular COmponent 3. OUT
    //output should be stuff defined in the xrc file.
    rgb_led_driver u_led (
        .clk(clk),
        .rst_n(rst_n),
        .in(proc),
        .led_r(led_r),
        .led_g(led_g),
        .led_b(led_b)
    );

endmodule
