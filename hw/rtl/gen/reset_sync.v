`timescale 1ns/1ps

module reset_sync (
    input wire clk,
    input wire arst_in,
    input wire locked,
    output wire rst_n
);
    wire arst = arst_in | ~locked;
    (* ASYNC_REG = "TRUE" *) reg [1:0] sync = 2'b00;

    always @(posedge clk or posedge arst) begin
        if (arst) sync <= 2'b00;
        else sync <= {sync[0], 1'b1};
    end

    assign rst_n = sync[1];
endmodule