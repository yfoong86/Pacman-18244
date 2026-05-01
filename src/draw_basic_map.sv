//Module to draw basic map on the screen
module draw_basic_map (
    input logic clk, rst_n,
    input logic [15:0] row, col,
    input logic en_cond,
    input logic [15:0] nplayer_x, nplayer_y,
    output logic [1:0] red, green, blue,
    output logic collision);

    //variable to keep track of coordinates of tiles
    logic [4:0][15:0] row_coords;
    logic [7:0][15:0] col_coords;

    logic [15:0] width, player_size;
    logic [15:0] row_size, row_size2, col_size, col_size2, col_size4;
    
    assign player_size = 15;
    assign width = 10;
    assign row_size = 96;
    assign row_size2 = 192;
    assign col_size = 80;
    assign col_size2 = 160;
    assign col_size4 = 320;

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

        //border
        if (row < (35 + width)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        else if (row > (515 - width)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        else if (col < (144 + width)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        else if (col > (785 - width)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line1
        else if (((col < (col_coords[1] + col_size)) && (col > col_coords[1])) && 
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
        else if (((col < (col_coords[2] + col_size4)) && (col > col_coords[2])) && 
            (row < (row_coords[3] + width)) && (row > row_coords[3])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line8
        else if (((col < (col_coords[5] + width)) && (col > col_coords[5])) && 
                 (row < (row_coords[4])) && (row > row_coords[4] - row_size)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line9
        else if (((col < (col_coords[5] + col_size2)) && (col > col_coords[5])) && 
            (row < (row_coords[4] + width)) && (row > row_coords[4])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line10
        else if (((col < (col_coords[5] + col_size2)) && (col > col_coords[5])) && 
                 (row < (row_coords[2] + width)) && (row > row_coords[2])) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        //line11
        else if (((col < (col_coords[5] + width)) && (col > col_coords[5])) && 
                 (row < (row_coords[2])) && (row > row_coords[2] - row_size)) {red, green, blue} = {2'b11, 2'b11, 2'b11};

        else {red, green, blue} = {2'b00, 2'b00, 2'b00};
    end

    //collision detection with map
    always_comb begin
        collision = 1'b0;

        //line1
        if (((nplayer_x < (col_coords[1] + col_size)) && (nplayer_x > (col_coords[1] - player_size))) && 
             (nplayer_y < (row_coords[2] + width)) && (nplayer_y > (row_coords[2] - player_size))) collision = 1'b1;

        //line2
        else if (((nplayer_x < (col_coords[2] + width)) && (nplayer_x > (col_coords[2] - player_size))) && 
                 (nplayer_y < (row_coords[2] + width)) && (nplayer_y > (row_coords[2] + width - row_size - player_size))) collision = 1'b1;

        //line3
        else if (((nplayer_x < (col_coords[2] + col_size2)) && (nplayer_x > (col_coords[2] - player_size))) && 
                 (nplayer_y < (row_coords[1] + width)) && (nplayer_y > (row_coords[1] - player_size))) collision = 1'b1;

        //line4
        else if (((nplayer_x < (col_coords[1] + width)) && (nplayer_x > (col_coords[1] - player_size))) && 
                 (nplayer_y < (row_coords[4])) && (nplayer_y > (row_coords[4] - row_size - player_size))) collision = 1'b1;

        //line5
        else if (((nplayer_x < (col_coords[1] + col_size2)) && (nplayer_x > (col_coords[1] - player_size))) && 
                 (nplayer_y < (row_coords[4] + width)) && (nplayer_y > (row_coords[4] - player_size))) collision = 1'b1;

        //line6
        else if (((nplayer_x < (col_coords[4] + width)) && (nplayer_x > (col_coords[4] - player_size))) && 
                 (nplayer_y < (row_coords[3])) && (nplayer_y > (row_coords[3] - row_size - player_size))) collision = 1'b1;

        //line7
        else if (((nplayer_x < (col_coords[2] + col_size4)) && (nplayer_x > (col_coords[2] - player_size))) && 
                 (nplayer_y < (row_coords[3] + width)) && (nplayer_y > (row_coords[3] - player_size))) collision = 1'b1;

        //line8
        else if (((nplayer_x < (col_coords[5] + width)) && (nplayer_x > (col_coords[5] - player_size))) && 
                 (nplayer_y < (row_coords[4])) && (nplayer_y > (row_coords[4] - row_size - player_size))) collision = 1'b1;

        //line9
        else if (((nplayer_x < (col_coords[5] + col_size2)) && (nplayer_x > (col_coords[5] - player_size))) && 
                 (nplayer_y < (row_coords[4] + width)) && (nplayer_y > (row_coords[4] - player_size))) collision = 1'b1;

        //line10
        else if (((nplayer_x < (col_coords[5] + col_size2)) && (nplayer_x > (col_coords[5] - player_size))) && 
                 (nplayer_y < (row_coords[2] + width)) && (nplayer_y > (row_coords[2] - player_size))) collision = 1'b1;

        //line11
        else if (((nplayer_x < (col_coords[5] + width)) && (nplayer_x > (col_coords[5] - player_size))) && 
                 (nplayer_y < (row_coords[2])) && (nplayer_y > (row_coords[2] - row_size - player_size))) collision = 1'b1;

    end

endmodule: draw_basic_map