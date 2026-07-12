`timescale 1ns/1ps
import img_pipe_pkg::*;

module test_image_gen (
    input logic clk,
    input logic rst_n,

    output pixel_bus_t out
);

    logic [11:0] x, y;
    logic active, hsync, vsync, frame_start;
    timing_gen u_timing (
        .clk(clk),
        .rst_n(rst_n),
        .x_pos(x),
        .y_pos(y),
        .active(active),
        .hsync(hsync),
        .vsync(vsync),
        .frame_start(frame_start)
    );

    pixel_t pattern_pixel;
    logic pattern = 1'd0;
    always_comb begin
        case (pattern)
            1'd0: begin
                //pixel position -> colour. But shifted a bit to make it less chaotic (ie changes every 4 pixels instead of 1)
                pattern_pixel.r = x[9:2];//pattern_pixel.r = x[9:2];
                pattern_pixel.g = y[9:2];//pattern_pixel.g = y[9:2];
                pattern_pixel.b = 8'h40;
            end
            default: begin
                pattern_pixel = '{r:8'h00, g:8'h00, b:8'h00};
            end
        endcase
    end

    always_ff @( posedge clk ) begin : outputReg
        if (!rst_n) begin
            out <= '0;
        end else begin
            out.pixel <= pattern_pixel;
            out.pixel_valid <= active;
            out.hsync <= hsync;
            out.vsync <= vsync;
            out.frame_start <= frame_start;
        end
    end
    
endmodule
