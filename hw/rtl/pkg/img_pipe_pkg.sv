`timescale 1ns/1ps
package img_pipe_pkg;

    parameter int H_ACTIVE = 1280;    //1280
    parameter int H_FRONT = 110;    //110
    parameter int H_SYNC = 40;      //40
    parameter int H_BACK = 220;     //220
    parameter int H_TOTAL = H_ACTIVE + H_FRONT + H_SYNC + H_BACK;

    parameter int V_ACTIVE = 720;     //720
    parameter int V_FRONT = 5;      //5
    parameter int V_SYNC = 5;       //5
    parameter int V_BACK = 20;      //20
    parameter int V_TOTAL = V_ACTIVE + V_FRONT + V_SYNC + V_BACK;

    parameter int FRAME_PIXELS = H_ACTIVE * V_ACTIVE;

    //this is the main section
    typedef struct packed {
        logic [7:0] r;
        logic [7:0] g;
        logic [7:0] b;
    } pixel_t;

    typedef struct packed {
        pixel_t pixel;
        logic pixel_valid;
        logic hsync;
        logic vsync;
        logic frame_start;
    } pixel_bus_t;

endpackage
