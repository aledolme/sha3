
module keccak_round(
    input wire [4:0][4:0][63:0] round_in,
    input wire [7:0] round_constant_signal,
    output wire [4:0][4:0][63:0] round_out
);



  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------
  localparam integer num_plane = 5;
  localparam integer num_sheet = 5;
  localparam integer logD = 4;
  localparam integer N = 64;
  
  
  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [4:0][4:0][63:0] theta_in, theta_out, pi_in, pi_out, rho_in, rho_out, chi_in, chi_out, iota_in, iota_out;
  reg [4:0][63:0] sum_sheet;

  //connecitons
  //order theta, pi, rho, chi, iota
  assign theta_in = round_in;
  assign pi_in = rho_out;
  assign rho_in = theta_out;
  assign chi_in = pi_out;
  assign iota_in = chi_out;
  assign round_out = iota_out;

  //chi
  genvar y, x, i;
  generate
    for (y = 0; y <= 4; y = y + 1) begin : i0000
      for (x = 0; x <= 2; x = x + 1) begin : i0001
        for (i = 0; i <= 63; i = i + 1) begin : i0002
          assign chi_out[y][x][i] = chi_in[y][x][i] ^ (!chi_in[y][x + 1][i] & chi_in[y][x + 2][i]);
        end
      end
    end
  endgenerate

  generate
    for (y = 0; y <= 4; y = y + 1) begin : i0011
      for (i = 0; i <= 63; i = i + 1) begin : i0021
        assign chi_out[y][3][i] = chi_in[y][3][i] ^ (!chi_in[y][4][i] & chi_in[y][0][i]);
      end
    end
  endgenerate

  generate
    for (y = 0; y <= 4; y = y + 1) begin : i0012
      for (i = 0; i <= 63; i = i + 1) begin : i0022
        assign chi_out[y][4][i] = chi_in[y][4][i] ^ (!chi_in[y][0][i] & chi_in[y][1][i]);
      end
    end
  endgenerate

  //theta
  //compute sum of columns
  generate
    for (x = 0; x <= 4; x = x + 1) begin : i0101
      for (i = 0; i <= 63; i = i + 1) begin : i0102
        assign sum_sheet[x][i] = theta_in[0][x][i] ^ theta_in[1][x][i] ^ theta_in[2][x][i] ^ theta_in[3][x][i] ^ theta_in[4][x][i];
      end
    end
  endgenerate

  generate
    for (y = 0; y <= 4; y = y + 1) begin : i0200
      for (x = 1; x <= 3; x = x + 1) begin : i0201
        assign theta_out[y][x][0] = theta_in[y][x][0] ^ sum_sheet[x - 1][0] ^ sum_sheet[x + 1][63];
        for (i = 1; i <= 63; i = i + 1) begin : i0202
          assign theta_out[y][x][i] = theta_in[y][x][i] ^ sum_sheet[x - 1][i] ^ sum_sheet[x + 1][i - 1];
        end
      end
    end
  endgenerate

  generate
    for (y = 0; y <= 4; y = y + 1) begin : i2001
      assign theta_out[y][0][0] = theta_in[y][0][0] ^ sum_sheet[4][0] ^ sum_sheet[1][63];
      for (i = 1; i <= 63; i = i + 1) begin : i2021
        assign theta_out[y][0][i] = theta_in[y][0][i] ^ sum_sheet[4][i] ^ sum_sheet[1][i - 1];
      end
    end
  endgenerate

  generate
    for (y = 0; y <= 4; y = y + 1) begin : i2002
      assign theta_out[y][4][0] = theta_in[y][4][0] ^ sum_sheet[3][0] ^ sum_sheet[0][63];
      for (i = 1; i <= 63; i = i + 1) begin : i2022
        assign theta_out[y][4][i] = theta_in[y][4][i] ^ sum_sheet[3][i] ^ sum_sheet[0][i - 1];
      end
    end
  endgenerate

  // pi
    generate
        for(y = 0; y <= 4; y++)
            for(x = 0; x <= 4; x++)
                for(i = 0; i <= N-1; i++)
                    assign pi_out[(2*x+3*y) % 5][0*x+1*y][i] = pi_in[y][x][i];
    endgenerate


//RHO
// Group 0
generate
    for (i = 0; i < 64; i = i + 1) begin : i4001
        assign rho_out[0][0][i] = rho_in[0][0][i];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4002
        assign rho_out[0][1][i] = rho_in[0][1][(i - 1) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4003
        assign rho_out[0][2][i] = rho_in[0][2][(i - 62) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4004
        assign rho_out[0][3][i] = rho_in[0][3][(i - 28) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4005
        assign rho_out[0][4][i] = rho_in[0][4][(i - 27) & 63];
    end
endgenerate

// Group 1
generate
    for (i = 0; i < 64; i = i + 1) begin : i4011
        assign rho_out[1][0][i] = rho_in[1][0][(i - 36) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4012
        assign rho_out[1][1][i] = rho_in[1][1][(i - 44) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4013
        assign rho_out[1][2][i] = rho_in[1][2][(i - 6) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4014
        assign rho_out[1][3][i] = rho_in[1][3][(i - 55) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4015
        assign rho_out[1][4][i] = rho_in[1][4][(i - 20) & 63];
    end
endgenerate

// Group 2
generate
    for (i = 0; i < 64; i = i + 1) begin : i4021
        assign rho_out[2][0][i] = rho_in[2][0][(i - 3) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4022
        assign rho_out[2][1][i] = rho_in[2][1][(i - 10) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4023
        assign rho_out[2][2][i] = rho_in[2][2][(i - 43) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4024
        assign rho_out[2][3][i] = rho_in[2][3][(i - 25) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4025
        assign rho_out[2][4][i] = rho_in[2][4][(i - 39) & 63];
    end
endgenerate

// Group 3
generate
    for (i = 0; i < 64; i = i + 1) begin : i4031
        assign rho_out[3][0][i] = rho_in[3][0][(i - 41) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4032
        assign rho_out[3][1][i] = rho_in[3][1][(i - 45) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4033
        assign rho_out[3][2][i] = rho_in[3][2][(i - 15) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4034
        assign rho_out[3][3][i] = rho_in[3][3][(i - 21) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4035
        assign rho_out[3][4][i] = rho_in[3][4][(i - 8) & 63];
    end
endgenerate

// Group 4
generate
    for (i = 0; i < 64; i = i + 1) begin : i4041
        assign rho_out[4][0][i] = rho_in[4][0][(i - 18) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4042
        assign rho_out[4][1][i] = rho_in[4][1][(i - 2) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4043
        assign rho_out[4][2][i] = rho_in[4][2][(i - 61) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4044
        assign rho_out[4][3][i] = rho_in[4][3][(i - 56) & 63];
    end

    for (i = 0; i < 64; i = i + 1) begin : i4045
        assign rho_out[4][4][i] = rho_in[4][4][(i - 14) & 63];
    end
endgenerate
        

  // iota
  generate
    for (y = 1; y <= 4; y = y + 1) begin : i5001
      for (x = 0; x <= 4; x = x + 1) begin : i5002
        for (i = 0; i <= 63; i = i + 1) begin : i5003
          assign iota_out[y][x][i] = iota_in[y][x][i];
        end
      end
    end
  endgenerate

  generate
    for (x = 1; x <= 4; x = x + 1) begin : i5012
      for (i = 0; i <= 63; i = i + 1) begin : i5013
        assign iota_out[0][x][i] = iota_in[0][x][i];
      end
    end
  endgenerate

assign iota_out[0][0][0] = iota_in[0][0][0] ^ round_constant_signal[0];
assign iota_out[0][0][1] = iota_in[0][0][1] ^ round_constant_signal[1];
assign iota_out[0][0][2] = iota_in[0][0][2] ^ round_constant_signal[2];
assign iota_out[0][0][3] = iota_in[0][0][3] ^ round_constant_signal[3];
assign iota_out[0][0][4] = iota_in[0][0][4];
assign iota_out[0][0][5] = iota_in[0][0][5];
assign iota_out[0][0][6] = iota_in[0][0][6];
assign iota_out[0][0][7] = iota_in[0][0][7] ^ round_constant_signal[4];
assign iota_out[0][0][8] = iota_in[0][0][8];
assign iota_out[0][0][9] = iota_in[0][0][9];
assign iota_out[0][0][10] = iota_in[0][0][10];
assign iota_out[0][0][11] = iota_in[0][0][11];
assign iota_out[0][0][12] = iota_in[0][0][12];
assign iota_out[0][0][13] = iota_in[0][0][13];
assign iota_out[0][0][14] = iota_in[0][0][14];
assign iota_out[0][0][15] = iota_in[0][0][15] ^ round_constant_signal[5];
assign iota_out[0][0][16] = iota_in[0][0][16];
assign iota_out[0][0][17] = iota_in[0][0][17];
assign iota_out[0][0][18] = iota_in[0][0][18];
assign iota_out[0][0][19] = iota_in[0][0][19];
assign iota_out[0][0][20] = iota_in[0][0][20];
assign iota_out[0][0][21] = iota_in[0][0][21];
assign iota_out[0][0][22] = iota_in[0][0][22];
assign iota_out[0][0][23] = iota_in[0][0][23];
assign iota_out[0][0][24] = iota_in[0][0][24];
assign iota_out[0][0][25] = iota_in[0][0][25];
assign iota_out[0][0][26] = iota_in[0][0][26];
assign iota_out[0][0][27] = iota_in[0][0][27];
assign iota_out[0][0][28] = iota_in[0][0][28];
assign iota_out[0][0][29] = iota_in[0][0][29];
assign iota_out[0][0][30] = iota_in[0][0][30];
assign iota_out[0][0][31] = iota_in[0][0][31] ^ round_constant_signal[6];
assign iota_out[0][0][32] = iota_in[0][0][32];
assign iota_out[0][0][33] = iota_in[0][0][33];
assign iota_out[0][0][34] = iota_in[0][0][34];
assign iota_out[0][0][35] = iota_in[0][0][35];
assign iota_out[0][0][36] = iota_in[0][0][36];
assign iota_out[0][0][37] = iota_in[0][0][37];
assign iota_out[0][0][38] = iota_in[0][0][38];
assign iota_out[0][0][39] = iota_in[0][0][39];
assign iota_out[0][0][40] = iota_in[0][0][40];
assign iota_out[0][0][41] = iota_in[0][0][41];
assign iota_out[0][0][42] = iota_in[0][0][42];
assign iota_out[0][0][43] = iota_in[0][0][43];
assign iota_out[0][0][44] = iota_in[0][0][44];
assign iota_out[0][0][45] = iota_in[0][0][45];
assign iota_out[0][0][46] = iota_in[0][0][46];
assign iota_out[0][0][47] = iota_in[0][0][47];
assign iota_out[0][0][48] = iota_in[0][0][48];
assign iota_out[0][0][49] = iota_in[0][0][49];
assign iota_out[0][0][50] = iota_in[0][0][50];
assign iota_out[0][0][51] = iota_in[0][0][51];
assign iota_out[0][0][52] = iota_in[0][0][52];
assign iota_out[0][0][53] = iota_in[0][0][53];
assign iota_out[0][0][54] = iota_in[0][0][54];
assign iota_out[0][0][55] = iota_in[0][0][55];
assign iota_out[0][0][56] = iota_in[0][0][56];
assign iota_out[0][0][57] = iota_in[0][0][57];
assign iota_out[0][0][58] = iota_in[0][0][58];
assign iota_out[0][0][59] = iota_in[0][0][59];
assign iota_out[0][0][60] = iota_in[0][0][60];
assign iota_out[0][0][61] = iota_in[0][0][61];
assign iota_out[0][0][62] = iota_in[0][0][62];
assign iota_out[0][0][63] = iota_in[0][0][63] ^ round_constant_signal[7];   

endmodule