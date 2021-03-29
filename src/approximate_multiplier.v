module approximate_multiplier (
    input  [7:0]  x,
    input  [7:0]  y,
    output [15:0] z
);

wire  [7:0] part1 =  y & {8{x[0]}};
wire  [8:0] part2 = (y & {8{x[1]}}) << 1;
wire  [9:0] part3 = (y & {8{x[2]}}) << 2;
wire [10:0] part4 = (y & {8{x[3]}}) << 3;

wire [7:0] part5 = (y & {8{x[4]}});
wire [7:0] part6 = (y & {8{x[5]}});
wire [7:0] part7 = (y & {8{x[6]}});
wire [7:0] part8 = (y & {8{x[7]}});


wire [3:0] part3_com_b;
assign part3_com_b[3] = part3[9]|part4[9];
assign part3_com_b[2] = part2[8]|part3[8]|part4[8];
assign part3_com_b[1] = part1[7]|part2[7]|part3[7]|part4[7];
assign part3_com_b[0] = part1[5]|part2[5]|part3[5]|part4[5] |(part1[6]&part2[6]&part3[6]&part4[6]);

wire [4:0] part3_com_t;
assign part3_com_t[4] = part4[10];
assign part3_com_t[3] = part3[9]&part4[9];
assign part3_com_t[2] = part1[6]&part2[6]&part3[6]&part4[6];
assign part3_com_t[1] = part1[6]|part2[6]|part3[6]|part4[6];
assign part3_com_t[0] = part1[4]|part2[4]|part3[4]|part4[4];


wire [10:0] new_part1 = {part8[7:5], part5};
wire [8:0]  new_part2 = {part7[7], part6};
wire [6:0]  new_part3 = {part7[6:0]};
wire [5:0]  new_part4 = {part8[4:0], part3_com_b[0]};
wire [4:0]  new_part5 = part3_com_t;
wire [2:0]  new_part6 = part3_com_b[3:1];

assign z = ({new_part1, 4'b0} +  {new_part4, 6'b0}) + ({new_part2, 5'b0} + {new_part3, 6'b0}) + ({new_part5, 6'b0} + {new_part6, 7'b0});

endmodule