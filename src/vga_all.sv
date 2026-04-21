module horizontal_counter 
(
    input logic clk,
    output reg [15:0] col,
    output logic enable_V_counter
);
    initial col = 0;
    always @(posedge clk) begin
        if (col < 799) begin
            col <= col + 1;
            enable_V_counter <= 0;
        end
        else begin
            col <= 0;
            enable_V_counter <= 1;
        end
    end
endmodule: horizontal_counter

module vertical_counter
(
    input logic clk, 
    input logic enable_V_counter,
    output reg [15:0] row
);
	initial row = 0;
    always @(posedge clk) begin
        if (enable_V_counter == 1'b1) begin
            if (row < 524) begin
                row <= row + 1;
            end
            else begin
                row <= 0;
            end
        end
    end
endmodule: vertical_counter