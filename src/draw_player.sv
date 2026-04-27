module draw_player
    (input logic clk, rst_n,
     input logic [15:0] row, col,
     input logic left, right, up, down,
     input logic en_cond,
     output logic [1:0] red, green, blue,
     output logic [15:0] player_x, player_y);
    
    // only update when at bottom right edge of display
    // valid, p2_height, p2_width, p1_height, p1_width,
    logic p1_h, p1_v, p2_h, p2_v;
        
    logic [15:0] player_size; // player size

    assign player_size = 16'd10;

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            player_x <= 16'd300;
            player_y <= 16'd400;
        end
        else if (en_cond) begin
            //x dir
            if (left) begin
                player_x <= player_x - 16'd5;
            end
            else if (right) begin
                player_x <= player_x + 16'd5;
            end
            
            //y dir
            if (up) begin
                player_y <= player_y - 16'd5;
            end
            else if (down) begin
                player_y <= player_y + 16'd5;
            end
        end
    end

    always_comb begin
        // if ((row < 16'd100) && (col < 16'd100)) {red, green, blue} = {2'b00, 2'b00, 2'b11};
        // else {red, green, blue} = {2'b00, 2'b00, 2'b00};

        if (((col < (player_x + player_size)) && (col > (player_x - player_size))) && 
            (row < (player_y + player_size)) && (row > (player_y - player_size))) {red, green, blue} = {2'b00, 2'b00, 2'b11};
        else {red, green, blue} = {2'b00, 2'b00, 2'b00};
    end
    

endmodule: draw_player