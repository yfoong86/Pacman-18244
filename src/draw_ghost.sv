module draw_ghost
    (input logic clk, rst_n, dflt,
     input logic [9:0] row, col,
     input logic btn_left, btn_right, btn_up, btn_down,
     output logic [1:0] red, green, blue,
     output logic en_cond,
     output logic [9:0] ghost_x, ghost_y);
    
    // only update when at bottom right edge of display
    logic en_cond, // valid, p2_height, p2_width, p1_height, p1_width,
        p1_h, p1_v, p2_h, p2_v;

    assign en_cond = (row == 10'd599) && (col == 10'd799);
        
    logic [9:0] ghost_size; // ghost size

    assign ghost_size = 10'd2;

    always_ff @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            ghost_x <= 10'd775;
            ghost_y <= 10'd16;
        end
        else begin
            //x dir
            if (btn_left) begin
                ghost_x <= ghost_x - 10'd5;
            end
            else if (btn_right) begin
                ghost_x <= ghost_x + 10'd5;
            end
            
            //y dir
            if (btn_up) begin
                ghost_y <= ghost_y - 10'd5;
            end
            else if (btn_down) begin
                ghost_y <= ghost_y + 10'd5;
            end
        end
    end

    // do range checks and draw ghosts 1 and 2
    OffsetCheck #(10) oc3(.val(row), .low(ghost_y), 
                         .delta(ghost_size), .is_between(p1_v));

    OffsetCheck #(10) oc4(.val(col), .low(ghost_x), 
                         .delta(ghost_size), .is_between(p1_h));

    
    always_comb begin
        {red, green, blue} = {2'b00, 2'b00, 2'b00};
        if (p1_v & p1_h) 
            {red, green, blue} = {2'b00, 2'b00, 2'b11};
    end
    

endmodule: draw_ghost