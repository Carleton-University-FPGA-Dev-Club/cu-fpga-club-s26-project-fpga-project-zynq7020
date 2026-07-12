`timescale 1ns/1ps
import img_pipe_pkg::*;

module timing_gen(
    input logic clk,
    input logic rst_n,

    output logic [11:0] x_pos,
    output logic [11:0] y_pos,
    output logic active,
    output logic hsync,
    output logic vsync,
    output logic frame_start
);
    //all of this stuff is mainly here to make it easier once we go to hdmi. 
    //Tho it may be useless idk. Something cool ive seen been done before
    logic [11:0] h_count, v_count;

    always_ff @( posedge clk ) begin : blockName
        if (!rst_n) begin
            h_count <= '0;
            v_count <= '0;
        end else begin
            if (h_count == H_TOTAL - 1) begin
                h_count <= '0;
                //wraps
                if (v_count == V_TOTAL - 1)
                    v_count <= '0;
                else
                    v_count <= v_count + 1'b1;
            end else begin
                h_count <= h_count + 1'b1;
            end
        end
    end

    //output logic omg i remember this stuff yay
    //region that actually is seem by the monitor (not super important but good to know)
    assign active = (h_count < H_ACTIVE)  && (v_count < V_ACTIVE);

    assign x_pos = h_count[11:0];
    assign y_pos = v_count[11:0];

    //something about porches. https://electronics.stackexchange.com/questions/201011/what-is-front-porch-and-back-porch-of-a-video-signal-in-crt-display
    assign hsync = (h_count >= H_ACTIVE + H_FRONT) && (h_count < H_ACTIVE + H_FRONT + H_SYNC);
    assign vsync = (v_count >= V_ACTIVE + V_FRONT) && (v_count < V_ACTIVE + V_FRONT + V_SYNC);

    assign frame_start = (h_count == 0) && (v_count == 0);

endmodule
