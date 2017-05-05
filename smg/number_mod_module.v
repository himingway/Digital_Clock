module number_mod_module (
	input CLK,
	input [23:0]Number_Data,
	output [3:0]Ten_Data0,
	output [3:0]One_Data0,
	output [3:0]Ten_Data1,
	output [3:0]One_Data1,
	output [3:0]Ten_Data2,
	output [3:0]One_Data2
);


/*********************************/

reg [31:0]rTen0;
reg [31:0]rOne0;
reg [31:0]rTen1;
reg [31:0]rOne1;
reg [31:0]rTen2;
reg [31:0]rOne2;

always @ ( posedge CLK ) begin
	rTen0 <= Number_Data[7:0]   / 10;
	rOne0 <= Number_Data[7:0]   % 10;
	rTen1 <= Number_Data[15:8]  / 10;
	rOne1 <= Number_Data[15:8]  % 10;
	rTen2 <= Number_Data[23:16] / 10;
	rOne2 <= Number_Data[23:16] % 10;
end

/***********************************/

assign Ten_Data0 = rTen0[3:0];
assign One_Data0 = rOne0[3:0];
assign Ten_Data1 = rTen1[3:0];
assign One_Data1 = rOne1[3:0];
assign Ten_Data2 = rTen2[3:0];
assign One_Data2 = rOne2[3:0];

/***********************************/

endmodule


