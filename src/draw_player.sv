module draw_player
    (input logic clk, rst_n,
     input logic [15:0] row, col,
     input logic left, right, up, down,
     input logic en_cond,
     output logic [1:0] red, green, blue,
     output logic [15:0] player_x, player_y);
        
    logic [15:0] player_size; // player size

    assign player_size = 16'd15;

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            player_x <= 16'd300;
            player_y <= 16'd400;
        end
        else if (en_cond) begin
            //x dir
            if (left && (player_x > (143 + player_size))) begin
                player_x <= player_x - 16'd5;
            end
            else if (right && (player_x < (784 - player_size))) begin
                player_x <= player_x + 16'd5;
            end
            
            //y dir
            if (up && (player_y > (34 + player_size))) begin
                player_y <= player_y - 16'd5;
            end
            else if (down && (player_y < (515 - player_size))) begin
                player_y <= player_y + 16'd5;
            end
        end
    end

    always_comb begin
        if (((col < (player_x + player_size)) && (col > player_x)) && 
            (row < (player_y + player_size)) && (row > player_y)) {red, green, blue} = {2'b00, 2'b00, 2'b11};
        else {red, green, blue} = {2'b00, 2'b00, 2'b00};
    end
    

endmodule: draw_player