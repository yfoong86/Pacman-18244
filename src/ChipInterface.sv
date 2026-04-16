module ChipInterface (
    input logic clk, rst_n,
    input logic btn_left, btn_right, btn_up, btn_down,
    output logic vga_r0, vga_r1,
    output logic vga_g0, vga_g1,
    output logic vga_b0, vga_b1,
    output logic vga_hs, vga_vs,
    output logic [7:0] led);

    logic [7:0] score;
    logic       blank;
    logic [9:0] row, col;

    logic [9:0] player_x, player_y;
    logic [9:0] ghost_x, ghost_y;

    logic dflt;
    logic [1:0] red_p, green_p, blue_p;
    logic [1:0] red_g, green_g, blue_g;

    vga VGA(.clock_40MHz(clk), .reset(~rst_n), .HS(vga_hs), .VS(vga_vs), .blank, .row, .col);


    //Player position logic
    draw_player(.clk, .rst_n, .dflt,
                .row, .col,
                .btn_left, .btn_right, .btn_up, .btn_down,
                .red(red_p), .green(green_p), .blue(blue_p),
                .en_cond,
                .player_x, .player_y);

    //Ghost position logic
    draw_ghost (.clk, .rst_n, .dflt,
                .row, .col,
                .btn_left, .btn_right, .btn_up, .btn_down,
                .red(red_g), .green(green_g), .blue(blue_g),
                .en_cond,
                .ghost_x, .ghost_y);

    always_comb begin
        vga_r0 = red_p[0] || red_g[0];
        vga_r1 = red_p[1] || red_g[1];

        vga_g0 = green_p[0] || green_g[0];
        vga_g1 = green_p[1] || green_g[1];

        vga_b0 = blue_p[0] || blue_g[0];
        vga_b1 = blue_p[1] || blue_g[1];
    end

    Pacman pacman(.clk, .rst_n,
                  .btn_left, .btn_right, .btn_up, .btn_down,
                  .score,
                  .player_x, .player_y,
                  .ghost_x, .ghost_y);

    assign led = score;

endmodule: ChipInterface