//Verilog BD wrapper
//not sure if this is the best option

//pixel_bus_t (MSB -> LSB)
//  [27:20] pixel.r [19:12] pixel.g     [11:4] pixel.b
//  [3] pixel_valid [2] hsync   [1] vsync   [0] frame_start
`timescale 1ns/1ps

module test_image_gen_bd (
    input wire clk,
    input wire rst_n,
    input wire sw,

    output wire [7:0] pix_r,
    output wire [7:0] pix_g,
    output wire [7:0] pix_b,
    output wire pixel_valid,
    output wire hsync,
    output wire vsync,
    output wire frame_start
);

    wire [27:0] out_bus;

    test_image_gen u_gen (
        .clk (clk),
        .rst_n(rst_n),
        .sw(sw),
        .out (out_bus)
    );

    assign pix_r = out_bus[27:20];
    assign pix_g = out_bus[19:12];
    assign pix_b = out_bus[11:4];
    assign pixel_valid = out_bus[3];
    assign hsync = out_bus[2];
    assign vsync = out_bus[1];
    assign frame_start = out_bus[0];
endmodule