`include "define.v"
module TimeandDate (
	input wire clk_32_768K, // Time 	
	input wire Mode,
	input wire Button0,
	input wire Button1,
	input wire Button2,
	input wire Button3,
	output reg [1:0] Blink,
	output reg [5:0] Sec_Time,
	output reg [5:0] Min_Time,
	output reg [4:0] Hr_Time,
	output reg [5:0] Day_Date,
	output reg [3:0] Mon_Date,
	output reg [6:0] Year_Date,
	output reg Display
);

reg [12:0] Count_clk_8192Hz;
reg clk_8192HZ;
reg [2:0] Edit;
reg [1:0] Counter_T;

always @(posedge clk_32_768K) begin
	if (Count_clk_8192Hz ==  `Count_clk_8192Hz) begin
		Count_clk_8192Hz <= 12'd0;
		clk_8192HZ <= ~ clk_8192HZ;
	end
	else begin
		Count_clk_8192Hz <= Count_clk_8192Hz + 1'b1;
	end
end

always @(posedge clk_8192HZ) begin
	Counter_T = Counter_T + 1'b1;
	if(Counter_T == 2'd2) begin
		Counter_T = 2'd0;
		Sec_Time = Sec_Time + 1'b1;
		if(Sec_Time == 6'd60) begin
			Sec_Time = 6'd0;
			Min_Time = Min_Time + 1'b1;
			if(Min_Time == 6'd60) begin
				Min_Time = 6'd0;
				Hr_Time = Hr_Time + 1'b1;
				if(Hr_Time == 5'd24) begin
					Hr_Time = 5'd0;
					Day_Date = Day_Date + 1'b1; 
					if((Mon_Date == 4'd2)&&(Day_Date == 6'd29)&&((Year_Date % 4) != 0)) begin
						Day_Date = 6'd1;
						Mon_Date = Mon_Date +1'b1;
						if(Mon_Date == 4'd12) begin
							Mon_Date = 4'd1;
							Year_Date = Year_Date + 1'b1;
							if(Year_Date == 7'd99) begin
								Year_Date = 7'd0;
							end
						end
					end
					else if((Mon_Date == 4'd2)&&(Day_Date == 6'd30)) begin
						Day_Date = 6'd1;
						Mon_Date = Mon_Date +1'b1;
						if(Mon_Date == 4'd12) begin
							Mon_Date = 4'd1;
							Year_Date = Year_Date + 1'b1;
							if(Year_Date == 7'd99) begin
								Year_Date = 7'd0;
							end
						end
					end
					else if((Mon_Date == 4'd0)&&(Mon_Date == 4'd1)&&(Mon_Date == 4'd3)&&(Mon_Date == 4'd5)
					&&(Mon_Date == 4'd7)&&(Mon_Date == 4'd8)&&(Mon_Date == 4'd10)
					&&(Mon_Date == 4'd12)&&(Day_Date == 6'd32)) begin
						Day_Date = 6'd1;
						Mon_Date = Mon_Date +1'b1;
						if(Mon_Date == 4'd12) begin
							Mon_Date = 4'd1;
							Year_Date = Year_Date + 1'b1;
							if(Year_Date == 7'd99) begin
								Year_Date = 7'd0;
							end
						end
					end
					else if(Day_Date == 6'd31) begin
						Day_Date = 6'd1;
						Mon_Date = Mon_Date +1'b1;
						if(Mon_Date == 4'd13) begin
							Mon_Date = 4'd1;
							Year_Date = Year_Date + 1'b1;
							if(Year_Date == 7'd100) begin
								Year_Date = 7'd0;
							end
						end
					end
				end
			end
		end
	end
	if(Mode == `Set_Time) begin
		case (Edit)
			`Set_Sec: begin
				if(Button1 || Button2) 
					Sec_Time = 6'd0; 
			end
			`Set_Min: begin 
				if(Button1) 
					Min_Time = Min_Time + 1'b1;
				if(Button2)
					Min_Time = 6'd0;
				if(Min_Time == 6'd60)
					Min_Time = 6'd0;
			end
			`Set_Hr : begin
				if(Button1) 
					Hr_Time  = Hr_Time + 1'b1;
				if(Button2)
					Hr_Time  = 5'd0;
				if(Hr_Time == 5'd24)
					Hr_Time = 5'd0;
			end
			`Set_Day: begin
				if(Button1) begin
					Day_Date  = Day_Date + 1'b1;
					if((Mon_Date == 4'd2)&&(Day_Date == 5'd29)&&((Year_Date % 4) != 0)) begin
						Day_Date = 5'd1;
					end
					else if((Mon_Date == 4'd2)&&(Day_Date == 6'd30)) begin
						Day_Date = 6'd1;
					end
					else if((Mon_Date == 4'd0)&&(Mon_Date == 4'd1)&&(Mon_Date == 4'd3)&&(Mon_Date == 4'd5)
					&&(Mon_Date == 4'd7)&&(Mon_Date == 4'd8)&&(Mon_Date == 4'd10)
					&&(Mon_Date == 4'd12)&&(Day_Date == 6'd32)) begin
						Day_Date = 5'd1;
					end
					else if(Day_Date == 5'd31) begin
						Day_Date = 5'd1;
					end
				end
				if(Button2)
					Day_Date = 5'd1;
			end
			`Set_Mon: begin
				if(Button1) 
					Mon_Date  = Mon_Date + 1'b1;
				if(Button2)
					Mon_Date  = 4'd1;
				if(Mon_Date == 4'd13)
					Mon_Date = 4'd1;
			end
			`Set_Year: begin
				if(Button1) 
					Year_Date = Year_Date + 1'b1;
				if(Button2)
					Year_Date = Year_Date - 1'b1;
				if(Year_Date == 7'd100)
					Year_Date = 7'd0;
				if(Year_Date == 7'b111_1111)
					Year_Date = 7'd0;
			end
		endcase
	end
end

always@(*)begin
	if(Mode == `Time) begin
		Blink = 2'b00;
		Display = 1'b0;
	end
	else if(Mode == `Set_Time) begin
		case (Edit)
			`Set_Sec: begin Blink = 2'b01; Display = 1'b0; end
			`Set_Min: begin Blink = 2'b10; Display = 1'b0; end
			`Set_Hr : begin Blink = 2'b11; Display = 1'b0; end
			`Set_Day: begin Blink = 2'b01; Display = 1'b1; end
			`Set_Mon: begin Blink = 2'b10; Display = 1'b1; end
			`Set_Year:begin Blink = 2'b11; Display = 1'b1; end
			default : begin Blink = 2'b00; Display = 1'b0; end
		endcase
	end
	else if(Button0)
		Blink = 2'b00;
end
always @(posedge Button3 or posedge Button0) begin
	if(Button0) begin
		Edit <= 3'd0;
	end
	else if (Edit == 3'd5)
		Edit <=3'd0;
	else
		Edit <= Edit +1'b1;
end

endmodule