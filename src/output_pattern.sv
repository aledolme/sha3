module output_pattern(
    input wire [511:0]   output_pattern_in,
    output wire [511:0]  output_pattern_out
);
	
	assign output_pattern_out[7:0] = output_pattern_in[511:504];
    assign output_pattern_out[15:8] = output_pattern_in[503:496];
    assign output_pattern_out[23:16] = output_pattern_in[495:488];
    assign output_pattern_out[31:24] = output_pattern_in[487:480];
    assign output_pattern_out[39:32] = output_pattern_in[479:472];
    assign output_pattern_out[47:40] = output_pattern_in[471:464];
    assign output_pattern_out[55:48] = output_pattern_in[463:456];
    assign output_pattern_out[63:56] = output_pattern_in[455:448];
    assign output_pattern_out[71:64] = output_pattern_in[447:440];
    assign output_pattern_out[79:72] = output_pattern_in[439:432];
    assign output_pattern_out[87:80] = output_pattern_in[431:424];
    assign output_pattern_out[95:88] = output_pattern_in[423:416];
    assign output_pattern_out[103:96] = output_pattern_in[415:408];
    assign output_pattern_out[111:104] = output_pattern_in[407:400];
    assign output_pattern_out[119:112] = output_pattern_in[399:392];
    assign output_pattern_out[127:120] = output_pattern_in[391:384];
    assign output_pattern_out[135:128] = output_pattern_in[383:376];
    assign output_pattern_out[143:136] = output_pattern_in[375:368];
    assign output_pattern_out[151:144] = output_pattern_in[367:360];
    assign output_pattern_out[159:152] = output_pattern_in[359:352];
    assign output_pattern_out[167:160] = output_pattern_in[351:344];
    assign output_pattern_out[175:168] = output_pattern_in[343:336];
    assign output_pattern_out[183:176] = output_pattern_in[335:328];
    assign output_pattern_out[191:184] = output_pattern_in[327:320];
    assign output_pattern_out[199:192] = output_pattern_in[319:312];
    assign output_pattern_out[207:200] = output_pattern_in[311:304];
    assign output_pattern_out[215:208] = output_pattern_in[303:296];
    assign output_pattern_out[223:216] = output_pattern_in[295:288];
    assign output_pattern_out[231:224] = output_pattern_in[287:280];
    assign output_pattern_out[239:232] = output_pattern_in[279:272];
    assign output_pattern_out[247:240] = output_pattern_in[271:264];
    assign output_pattern_out[255:248] = output_pattern_in[263:256];
    assign output_pattern_out[263:256] = output_pattern_in[255:248];
    assign output_pattern_out[271:264] = output_pattern_in[247:240];
    assign output_pattern_out[279:272] = output_pattern_in[239:232];
    assign output_pattern_out[287:280] = output_pattern_in[231:224];
    assign output_pattern_out[295:288] = output_pattern_in[223:216];
    assign output_pattern_out[303:296] = output_pattern_in[215:208];
    assign output_pattern_out[311:304] = output_pattern_in[207:200];
    assign output_pattern_out[319:312] = output_pattern_in[199:192];
    assign output_pattern_out[327:320] = output_pattern_in[191:184];
    assign output_pattern_out[335:328] = output_pattern_in[183:176];
    assign output_pattern_out[343:336] = output_pattern_in[175:168];
    assign output_pattern_out[351:344] = output_pattern_in[167:160];
    assign output_pattern_out[359:352] = output_pattern_in[159:152];
    assign output_pattern_out[367:360] = output_pattern_in[151:144];
    assign output_pattern_out[375:368] = output_pattern_in[143:136];
    assign output_pattern_out[383:376] = output_pattern_in[135:128];
    assign output_pattern_out[391:384] = output_pattern_in[127:120];
    assign output_pattern_out[399:392] = output_pattern_in[119:112];
    assign output_pattern_out[407:400] = output_pattern_in[111:104];
    assign output_pattern_out[415:408] = output_pattern_in[103:96];
    assign output_pattern_out[423:416] = output_pattern_in[95:88];
    assign output_pattern_out[431:424] = output_pattern_in[87:80];
    assign output_pattern_out[439:432] = output_pattern_in[79:72];
    assign output_pattern_out[447:440] = output_pattern_in[71:64];
    assign output_pattern_out[455:448] = output_pattern_in[63:56];
    assign output_pattern_out[463:456] = output_pattern_in[55:48];
    assign output_pattern_out[471:464] = output_pattern_in[47:40];
    assign output_pattern_out[479:472] = output_pattern_in[39:32];
    assign output_pattern_out[487:480] = output_pattern_in[31:24];
    assign output_pattern_out[495:488] = output_pattern_in[23:16];
    assign output_pattern_out[503:496] = output_pattern_in[15:8];
    assign output_pattern_out[511:504] = output_pattern_in[7:0];
	
endmodule : output_pattern
