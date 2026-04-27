module ChipInterface (
    input logic clk, btn_rst,
    input logic btn_left, btn_right, btn_up, btn_down,
    output logic vga_r0, vga_r1,
    output logic vga_g0, vga_g1,
    output logic vga_b0, vga_b1,
    output logic vga_hs, vga_vs,
    output logic [7:0] led);

    logic [7:0] score;
    logic       blank;

    logic [15:0] player_x, player_y;
    logic [15:0] ghost_x, ghost_y;

    logic [1:0] red_p, green_p, blue_p;
    logic [1:0] red_g, green_g, blue_g;

    //logic for vga
    logic [15:0] col, row;
    logic enable_V_counter;
    logic en_cond;

    logic [1:0] red, green, blue;

    Synchronizer s0 (.clock(clk), .async(btn_rst), .sync(rst_n)),
                 s1 (.clock(clk), .async(btn_left), .sync(left)),
                 s2 (.clock(clk), .async(btn_right), .sync(right)),
                 s3 (.clock(clk), .async(btn_up), .sync(up)),
                 s4 (.clock(clk), .async(btn_down), .sync(down));

    assign en_cond = ((row == 16'd524) && (col == 16'd799));

    //Player position logic
    draw_player dp(.clk, .rst_n,
                   .row, .col,
                   .left, .right, .up, .down,
                   .red(red_p), .green(green_p), .blue(blue_p),
                   .en_cond,
                   .player_x, .player_y);

    //Ghost position logic
    // draw_ghost (.clk, .rst_n, .dflt,
    //             .row, .col,
    //             .btn_left, .btn_right, .btn_up, .btn_down,
    //             .red(red_g), .green(green_g), .blue(blue_g),
    //             .en_cond,
    //             .ghost_x, .ghost_y);

    assign red = red_p;
    assign green = green_p;
    assign blue = blue_p;

    horizontal_counter h_counter(.*);
    vertical_counter v_counter(.*);

    assign vga_hs = (col < 96) ? 1'b1:1'b0;
    assign vga_vs = (row < 2) ? 1'b1:1'b0;

    assign {vga_r1, vga_r0} = (((col < 784) && (col > 143)) && ((row < 515) && (row > 34))) ? red: 2'b00;
    assign {vga_g1, vga_g0} = (((col < 784) && (col > 143)) && ((row < 515) && (row > 34))) ? green: 2'b00;
    assign {vga_b1, vga_b0} = (((col < 784) && (col > 143)) && ((row < 515) && (row > 34))) ? blue: 2'b00;

    Pacman pacman(.clk, .rst_n,
                  .btn_left, .btn_right, .btn_up, .btn_down,
                  .score,
                  .player_x, .player_y,
                  .ghost_x, .ghost_y);

    assign led = score;

endmodule: ChipInterface