`timescale 1ns/1ps
import img_pipe_pkg::*;

module rgb_led_driver (
    input logic clk,
    input logic rst_n,
    input pixel_t in,

    output logic led_r,
    output logic led_g,
    output logic led_b
);

    logic [7:0] pwm;

    always_ff @( posedge clk ) begin : pwmAccum
        if (!rst_n) pwm <= '0;
        else pwm <= pwm + 8'd1;
    end

    always_ff @( posedge clk ) begin : blockName
        if (!rst_n) begin
            led_r <= 1'b0;
            led_g <= 1'b0;
            led_b <= 1'b0;
        end else begin
            led_r <= (pwm < in.r);
            led_g <= (pwm < in.g);
            led_b <= (pwm < in.b);
        end
    end
    
endmodule
