`timescale 1ns/1ps
// top
module top (
    input logic sysclk, //sysclk
    input logic [0:0] btn_rst, //btn0
    
    output logic led5_r,
    output logic led5_g,
    output logic led5_b,
    output logic [3:0] led
);
    logic rst_n, rst_meta, rst_sync;
    always_ff @( posedge sysclk ) begin : blockName
        rst_meta <= ~btn_rst;
        rst_sync <= rst_meta;
    end
    assign rst_n = rst_sync;

    //pipeline
    logic avg_valid;
    pipeline_top u_pipe (
        .clk(sysclk),
        .rst_n(rst_n),
        .led_r(led5_r),
        .led_g(led5_g),
        .led_b(led5_b),
        .valid(avg_valid)
    );

    //heartbeat
    logic [26:0] hb;
    always_ff @( posedge sysclk ) begin : blocka
        if (!rst_n) hb <= '0;
        else hb <= hb + 1'b1;
    end
    assign led = hb[26];
endmodule
