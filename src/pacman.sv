module Pacman (
    input logic clk, rst_n,
    input logic btn_left, btn_right, btn_up, btn_down,
    input logic [9:0] player_x, player_y,
    input logic [9:0] ghost_x, ghost_y,
    output logic [7:0] score);

    //score logic
    //TODO: fill in later
    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) score <= 8'h0;
        else score <= score + 1;
    end


endmodule: Pacman