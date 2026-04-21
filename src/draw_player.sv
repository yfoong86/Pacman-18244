module draw_player
    (input logic clk, rst_n,
     input logic [15:0] row, col,
     input logic btn_left, btn_right, btn_up, btn_down,
     input logic en_cond,
     output logic [1:0] red, green, blue,
     output logic [15:0] player_x, player_y);
    
    // only update when at bottom right edge of display
    // valid, p2_height, p2_width, p1_height, p1_width,
    logic p1_h, p1_v, p2_h, p2_v;
        
    logic [9:0] player_size; // player size

    assign player_size = 16'd50;

    assign player_x = 16'd200;
    assign player_y = 16'd300;

    // always_ff @(posedge clk, negedge rst_n) begin
    //     if (~rst_n) begin
    //         player_x <= 16'd16;
    //         player_y <= 16'd575;
    //     end
    //     else begin
    //         //x dir
    //         if (btn_left) begin
    //             player_x <= player_x - 16'd5;
    //         end
    //         else if (btn_right) begin
    //             player_x <= player_x + 16'd5;
    //         end
            
    //         //y dir
    //         if (btn_up) begin
    //             player_y <= player_y - 16'd5;
    //         end
    //         else if (btn_down) begin
    //             player_y <= player_y + 16'd5;
    //         end
    //     end
    // end

    // do range checks and draw players 1 and 2

    // assign {red, green, blue} = {2'b00, 2'b00, 2'b00};
    // assign {red, green, blue} = {2'b00, 2'b00, 2'b11};
    //     if (p1_v & p1_h) {red, green, blue} = {2'b00, 2'b00, 2'b11};
    //     else {red, green, blue} = {2'b00, 2'b00, 2'b00};
    // end

    always_comb begin
        if (((row < (player_x + player_size))) && (col < (player_y + player_size))) {red, green, blue} = {2'b11, 2'b11, 2'b11};
        else {red, green, blue} = {2'b00, 2'b00, 2'b00};
    end
    

endmodule: draw_player