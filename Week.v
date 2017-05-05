module Week (
	input wire [5:0] Day_Date,
	input wire [3:0] Mon_Date,
	input wire [6:0] Year_Date,

	output reg [2:0] Week,
	output reg [31:0] rDay_Date,
	output reg [31:0] rMon_Date,
	output reg [31:0] rYear_Date
);

always @(*) begin
	rDay_Date = Day_Date;
	rMon_Date = Mon_Date;
	rYear_Date = Year_Date+11'd2000;
	if((rMon_Date==4'd1)||(rMon_Date==4'd2)) begin
		rMon_Date = rMon_Date + 4'd12;
		rYear_Date = rYear_Date - 1'b1;
	end
	Week = (rDay_Date + rMon_Date*2 + (rMon_Date+1)*3/5 + rYear_Date 
		+ rYear_Date/4 - rYear_Date/100 + rYear_Date/400) % 7 + 1;
end	
endmodule