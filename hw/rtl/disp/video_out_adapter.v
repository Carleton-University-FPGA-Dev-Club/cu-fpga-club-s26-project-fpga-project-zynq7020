`timescale 1ns/1ps

module video_out_adapter (
    input wire clk, //74.25Mhz
    input wire rst_n,

    input wire [7:0] in_r,
    input wire [7:0] in_g,
    input wire [7:0] in_b,
    input wire in_pixel_valid,
    input wire in_hsync,
    input wire in_vsync,
    //input wire in_frame_start,

    output reg [23:0] vid_pData,
    output reg vid_pVDE,
    output reg vid_pHsync,
    output reg vid_pVsync
    //output reg out_frame_start
);

always @(posedge clk) begin
    if (!rst_n) begin
        vid_pData <= 24'd0;

        vid_pVDE <= 1'b0;
        vid_pHsync <= 1'b0;
        vid_pVsync <= 1'b0;

    end
    else begin
        vid_pData <= {in_r, in_g, in_b};

        vid_pVDE <= in_pixel_valid;
        vid_pHsync <= in_hsync;
        vid_pVsync <= in_vsync;
    end
end

endmodule