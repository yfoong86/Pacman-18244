//Module to draw basic map on the screen
module draw_basic_map (
    input logic clk, rst_n,
    input logic [15:0] row, col,
    input logic en_cond,
    input logic [15:0] player_x, player_y,
    output logic [1:0] red, green, blue,
    output logic collision_left, collision_right, collision_up, collision_down);

    //variable to keep track of coordinates of tiles
    logic [4:0][15:0] row_coords;
    logic [7:0][15:0] col_coords;

    logic [15:0] width;
    logic [15:0] row_size, row_size2, col_size, col_size2;
    
    assign width = 10;
    assign row_size = 96;
    assign row_size2 = 192;
    assign col_size = 80;
    assign col_size2 = 160;

    genvar i, j;
    generate
        //split into 5 rows
        for (i = 0; i < 5; i++) begin
            assign row_coords[i] = 35 + (row_size * i);
        end

        //split into 8 cols
        for (j = 0; j < 8; j++) begin
            assign col_coords[j] = 145 + (col_size * j);
        end
    endgenerate


    always_comb begin
        //line1
        if (((col < (col_coords[1] + col_size)) && (col > col_coords[1])) && 
            (row < (row_coords[2] + width)) && (row > row_coords[2])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line2
        else if (((col < (col_coords[2] + width)) && (col > col_coords[2])) && 
                 (row < (row_coords[2] + width)) && (row > row_coords[2] + width - row_size)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line3
        else if (((col < (col_coords[2] + col_size2)) && (col > col_coords[2])) && 
                 (row < (row_coords[1] + width)) && (row > row_coords[1])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line4
        else if (((col < (col_coords[1] + width)) && (col > col_coords[1])) && 
                 (row < (row_coords[4])) && (row > row_coords[4] - row_size)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line5
        else if (((col < (col_coords[1] + col_size2)) && (col > col_coords[1])) && 
                 (row < (row_coords[4] + width)) && (row > row_coords[4])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line6
        else if (((col < (col_coords[4] + width)) && (col > col_coords[4])) && 
                 (row < (row_coords[3])) && (row > row_coords[3] - row_size)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line7
        else if (((col < (col_coords[4] + col_size)) && (col > col_coords[4])) && 
            (row < (row_coords[3] + width)) && (row > row_coords[3])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line8
        else if (((col < (col_coords[5] + width)) && (col > col_coords[5])) && 
                 (row < (row_coords[4])) && (row > row_coords[4] - row_size)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line9
        else if (((col < (col_coords[5] + col_size)) && (col > col_coords[5])) && 
            (row < (row_coords[4] + width)) && (row > row_coords[4])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line10
        else if (((col < (col_coords[5] + col_size2)) && (col > col_coords[5])) && 
                 (row < (row_coords[2] + width)) && (row > row_coords[2])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line11
        else if (((col < (col_coords[5] + width)) && (col > col_coords[5])) && 
                 (row < (row_coords[2])) && (row > row_coords[2] - row_size)) {red, green, blue} = {2'b11, 2'b11, 2'b11};


        else {red, green, blue} = {2'b00, 2'b00, 2'b00};
    end

endmodule: draw_basic_map