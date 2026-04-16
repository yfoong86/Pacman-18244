module draw_player
    (input logic clk, rst_n, dflt,
     input logic [9:0] row, col,
     input logic btn_left, btn_right, btn_up, btn_down,
     output logic [1:0] red, green, blue,
     output logic en_cond,
     output logic [9:0] player_x, player_y);
    
    // only update when at bottom right edge of display
    logic en_cond, // valid, p2_height, p2_width, p1_height, p1_width,
        p1_h, p1_v, p2_h, p2_v;

    assign en_cond = (row == 10'd599) && (col == 10'd799);
        
    logic [9:0] player_size; // player size

    assign player_size = 10'd2;

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            player_x <= 10'd16;
            player_y <= 10'd575;
        end
        else begin
            //x dir
            if (btn_left) begin
                player_x <= player_x - 10'd5;
            end
            else if (btn_right) begin
                player_x <= player_x + 10'd5;
            end
            
            //y dir
            if (btn_up) begin
                player_y <= player_y - 10'd5;
            end
            else if (btn_down) begin
                player_y <= player_y + 10'd5;
            end
        end
    end

    // do range checks and draw players 1 and 2
    OffsetCheck #(10) oc3(.val(row), .low(player_y), 
                         .delta(player_size), .is_between(p1_v));

    OffsetCheck #(10) oc4(.val(col), .low(player_x), 
                         .delta(player_size), .is_between(p1_h));

    
    always_comb begin
        {red, green, blue} = {2'b00, 2'b00, 2'b00};
        if (p1_v & p1_h) 
            {red, green, blue} = {2'b00, 2'b00, 2'b11};
    end
    

endmodule: draw_player