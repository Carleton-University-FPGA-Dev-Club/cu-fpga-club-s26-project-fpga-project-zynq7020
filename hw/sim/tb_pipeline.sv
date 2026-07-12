`timescale 1ns/1ps
import img_pipe_pkg::*;

module tb_pipeline;

    logic clk = 0, rst_n = 0;
    always #4 clk = ~clk; //125Mhz (#1 would be 500)

    logic led_r, led_g, led_b, avg_valid;

    pipeline_top u_dut (
        .clk(clk), .rst_n(rst_n), .led_r(led_r), .led_g(led_g), .led_b(led_b), .valid(avg_valid)
    );

    initial begin
        #36 rst_n = 1;
        repeat (3) begin
            @(posedge avg_valid);
            $display("t=%0t avg = R:%0d G:%0d B:%0d",$time, u_dut.proc.r, u_dut.proc.g, u_dut.proc.b);
        end
        $finish;
    end

    initial begin
        #500_000_000 $display("TIMEOUT"); $finish;
    end

//  input logic clk,
//     input logic rst_n,
//     //pattern sel

//     output logic led_r,
//     output logic led_g,
//     output logic led_b,
//     output logic valid // a fingerprint saying its done processing basically

endmodule
