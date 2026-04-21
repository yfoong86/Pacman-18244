module tb_draw_player;

    // DUT signals
    logic clk, rst_n;
    logic [15:0] row, col;
    logic btn_left, btn_right, btn_up, btn_down;
    logic en_cond;

    logic [1:0] red, green, blue;
    logic [15:0] player_x, player_y;

    // Instantiate DUT
    draw_player dut (
        .clk(clk),
        .rst_n(rst_n),
        .row(row),
        .col(col),
        .btn_left(btn_left),
        .btn_right(btn_right),
        .btn_up(btn_up),
        .btn_down(btn_down),
        .en_cond(en_cond),
        .red(red),
        .green(green),
        .blue(blue),
        .player_x(player_x),
        .player_y(player_y)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test tracking
    int pass_count = 0;
    int fail_count = 0;

    // Expected checker task
    task check_pixel(input logic [15:0] r, c,
                     input logic [5:0] expected_rgb);
        begin
            row = r;
            col = c;
            #1; // allow combinational logic to settle

            if ({red, green, blue} === expected_rgb) begin
                $display("PASS: row=%0d col=%0d -> RGB=%b",
                         r, c, {red, green, blue});
                pass_count++;
            end
            else begin
                $display("FAIL: row=%0d col=%0d -> got=%b expected=%b",
                         r, c, {red, green, blue}, expected_rgb);
                fail_count++;
            end
        end
    endtask

    initial begin
        // Init
        clk = 0;
        rst_n = 0;
        row = 0;
        col = 0;
        btn_left = 0;
        btn_right = 0;
        btn_up = 0;
        btn_down = 0;
        en_cond = 0;

        // Reset
        #20;
        rst_n = 1;

        // ----------------------------------------
        // TEST CASES
        // ----------------------------------------

        // Inside player (should be white = 6'b111111)
        check_pixel(16'd210, 16'd310, 6'b111111);
        check_pixel(16'd220, 16'd320, 6'b111111);

        // Outside player (should be black)
        check_pixel(16'd500, 16'd500, 6'b000000);
        check_pixel(16'd100, 16'd100, 6'b000000);

        // Boundary tests
        // Edge just inside
        check_pixel(16'd249, 16'd349, 6'b111111);

        // Edge just outside
        check_pixel(16'd251, 16'd351, 6'b000000);

        // ----------------------------------------
        // SUMMARY
        // ----------------------------------------
        $display("\n==========================");
        $display("TEST SUMMARY:");
        $display("PASS: %0d", pass_count);
        $display("FAIL: %0d", fail_count);
        $display("==========================");

        if (fail_count == 0)
            $display("ALL TESTS PASSED ✅");
        else
            $display("SOME TESTS FAILED ❌");

        $finish;
    end

endmodule