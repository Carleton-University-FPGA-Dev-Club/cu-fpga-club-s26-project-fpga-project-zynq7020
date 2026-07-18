//Verilog BD wrapper
//not sure if this is the best option

//pixel_bus_t (MSB -> LSB)
//  [27:20] pixel.r [19:12] pixel.g     [11:4] pixel.b
//  [3] pixel_valid [2] hsync   [1] vsync   [0] frame_start
`timescale 1ns/1ps

module passthrough_bd (
    input wire clk,
    input wire rst_n,

    input wire [7:0] in_r,
    input wire [7:0] in_g,
    input wire [7:0] in_b,
    input wire in_pixel_valid,
    input wire in_hsync,
    input wire in_vsync,
    input wire in_frame_start,

    output reg [7:0] out_r,
    output reg [7:0] out_g,
    output reg [7:0] out_b,
    output reg out_pixel_valid,
    output reg out_hsync,
    output reg out_vsync,
    output reg out_frame_start
);

always @(posedge clk) begin
    if (!rst_n) begin
        out_r <= 8'd0;
        out_g <= 8'd0;
        out_b <= 8'd0;

        out_pixel_valid <= 1'b0;
        out_hsync <= 1'b0;
        out_vsync <= 1'b0;
        out_frame_start <= 1'b0;
    end
    else begin
        out_r <= in_r;
        out_g <= in_g;
        out_b <= in_b;

        out_pixel_valid <= in_pixel_valid;
        out_hsync <= in_hsync;
        out_vsync <= in_vsync;
        out_frame_start <= in_frame_start;
    end
end

endmodule