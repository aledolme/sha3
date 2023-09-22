module keccak_round_constants_gen(
    input [4:0] round_number,
    output [7:0] round_constant_signal_out
);

  // Internal signal declarations
  reg [63:0] round_constant_signal;

  always @ (round_number)
  begin
    case (round_number)
   5'b00000: round_constant_signal = 8'h01;
    5'b00001: round_constant_signal = 8'h32;
    5'b00010: round_constant_signal = 8'hBA;
    5'b00011: round_constant_signal = 8'hE0;
    5'b00100: round_constant_signal = 8'h3B;
    5'b00101: round_constant_signal = 8'h41;
    5'b00110: round_constant_signal = 8'hF1;
    5'b00111: round_constant_signal = 8'hA9;
    5'b01000: round_constant_signal = 8'h1A;
    5'b01001: round_constant_signal = 8'h18;
    5'b01010: round_constant_signal = 8'h69;
    5'b01011: round_constant_signal = 8'h4A;
    5'b01100: round_constant_signal = 8'h7B;
    5'b01101: round_constant_signal = 8'h9B;
    5'b01110: round_constant_signal = 8'hB9;
    5'b01111: round_constant_signal = 8'hA3;
    5'b10000: round_constant_signal = 8'hA2;
    5'b10001: round_constant_signal = 8'h90;
    5'b10010: round_constant_signal = 8'h2A;
    5'b10011: round_constant_signal = 8'hCA;
    5'b10100: round_constant_signal = 8'hF1;
    5'b10101: round_constant_signal = 8'hB0;
    5'b10110: round_constant_signal = 8'h41;
    5'b10111: round_constant_signal = 8'hE8;
    default: round_constant_signal = 8'h00;
    endcase
  end

  assign round_constant_signal_out = round_constant_signal;

endmodule