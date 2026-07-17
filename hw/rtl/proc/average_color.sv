`timescale 1ns/1ps
import img_pipe_pkg::*;

module average_color (
    input logic clk,
    input logic rst_n,
    input pixel_bus_t in,

    output pixel_t avg,
    output logic avg_valid
);

    localparam int ACC_W = $clog2(FRAME_PIXELS) + 8; //addition because its log math 8 is 256
    logic [ACC_W-1:0] acc_r, acc_g, acc_b;
    logic [20:0] pix_count; //~2M

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            acc_r <= '0; acc_g <= '0; acc_b <= '0;
            pix_count <= '0;
            avg <= '0;
            avg_valid <= 1'b0;
        end else begin
            avg_valid <= 1'b0;
            if (in.frame_start) begin
                //previous frame just finished. Get total ave value, then reset counters. Will have to fix
                avg.r <= acc_r[ACC_W-1 -:8]; //top 8 bits. (-: is counting down from frist number) aka divide
                avg.g <= acc_g[ACC_W-1 -:8];
                avg.b <= acc_b[ACC_W-1 -:8];
                avg_valid <= 1'b1;

                //reset counters
                if (in.pixel_valid) begin
                    acc_r <= in.pixel.r; //not sure if this condition will ever be true
                    acc_g <= in.pixel.g;
                    acc_b <= in.pixel.b;
                    pix_count <= 21'd1;
                end else begin
                    acc_r <= '0; acc_g <= '0; acc_b <= '0;
                    pix_count <= '0;
                end
            end else if (in.pixel_valid) begin
                //regular adding
                acc_r <= acc_r + in.pixel.r;
                acc_g <= acc_g + in.pixel.g;
                acc_b <= acc_b + in.pixel.b;
                pix_count <= pix_count + 21'd1;
            end
        end
    end
    
endmodule
