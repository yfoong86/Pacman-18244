`default_nettype none

module tt_um_pacman (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.

  logic [1:0] data_in, range;
  logic go, finish, error;

  assign uio_oe[3:0] = 4'd0;
  assign uio_oe[6:4] = 3'b111;
  assign uio_oe[7] = 1'b1;

  assign go = uio_in[0];
  assign finish = uio_in[1];
  assign data_in = uio_in[3:2];

  assign uio_out[3:0] = 4'd0; 
  assign uio_out[5:4] = range;
  assign uio_out[6] = error;
  assign uio_out[7] = 1'b0;

  assign uo_out = 8'd50;
 
  ChipInterface dut(.clock(clk), .reset(~rst_n), 
                    .data_in, .go, .finish, .range, .error);

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in, range, error, uio_in[7:4], 1'b0};

endmodule