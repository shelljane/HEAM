module approximate_multiplier (
    input  [7:0]  x,
    input  [7:0]  y,
    output [15:0] z
);

wire [3:0] x_mid = x[7:4];
wire [11:0] z_mid = x_mid*y;

wire [7:0] part1 =  y & {8{x[0]}};
wire [7:0] part2 = (y & {8{x[1]}});
wire [7:0] part3 = (y & {8{x[2]}});
wire [7:0] part4 = (y & {8{x[3]}});

wire [10:0] new_part1;
wire [10:0] new_part2;
wire [10:0] new_part3;

assign new_part1[0] = 0;
assign new_part1[1] = 0;
assign new_part1[2] = 0;
assign new_part1[3] = 0;
assign new_part1[4] = 0;
assign new_part1[5] = 0;
assign new_part1[6] = 0;
assign new_part1[7] = 0;
assign new_part1[8] = part1[7]|part2[6];
assign new_part1[9] = part3[6]&part4[5];
assign new_part1[10] = part4[7];

assign new_part2[0] = 0;
assign new_part2[1] = 0;
assign new_part2[2] = 0;
assign new_part2[3] = 0;
assign new_part2[4] = 0;
assign new_part2[5] = 0;
assign new_part2[6] = 0;
assign new_part2[7] = 0;
assign new_part2[8] = part2[7];
assign new_part2[9] = part3[6]|part4[5];
assign new_part2[10] = 0;

assign new_part3[0] = 0;
assign new_part3[1] = 0;
assign new_part3[2] = 0;
assign new_part3[3] = 0;
assign new_part3[4] = 0;
assign new_part3[5] = 0;
assign new_part3[6] = 0;
assign new_part3[7] = 0;
assign new_part3[8] = 0;
assign new_part3[9] = part3[7]|part4[6];
assign new_part3[10] = 0;


assign z = {z_mid, 4'b0} + new_part1 + new_part2 + new_part3;

endmodule