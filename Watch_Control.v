`include "define.v"
module Watch_Control (
 	input wire clk_32_768K,    // Time
	input wire Button0_IN,
	input wire Button1_IN,
	input wire Button2_IN,
	input wire Button3_IN,
	output wire [1:0] Blink,
	output wire [7:0] SecBuffer,
	output wire [7:0] MinBuffer,
	output wire [7:0] HrBuffer,
	output wire [3:0] Week
);


wire Button0;
wire Button1;
wire Button2;
wire Button3;

wire Button_SetTaD0;
wire Button_SetTaD1;
wire Button_SetTaD2;
wire Button_SetTaD3;
wire Button_DisplayDate;

wire [5:0] Sec_Time;
wire [5:0] Min_Time;
wire [4:0] Hr_Time;

wire [5:0] Day_Date;
wire [3:0] Mon_Date;
wire [6:0] Year_Date;

wire Display;

reg Mode;

reg StateTime;
reg StateSetTime;

reg BlinkSec;
reg BlinkMin;
reg BlinkHr;

debounce_module   debounce0 (clk_32_768K,Button0_IN,Button0);
debounce_module2  debounce1 (clk_32_768K,Button1_IN,Button1);
debounce_module2  debounce2 (clk_32_768K,Button2_IN,Button2);
debounce_module   debounce3 (clk_32_768K,Button3_IN,Button3);


always @(posedge Button0) begin
	Mode <= Mode +1'b1;
	if (Mode == 1'd1)
		Mode <= 1'd0;
end

always @(*) begin
	case(Mode)
		`Time: begin
			StateTime     = 1'b1;
			StateSetTime   = 1'b0;
		end
		`Set_Time: begin
			StateTime     = 1'b0;
			StateSetTime   = 1'b1;
		end
	endcase
end

assign Button_SetTaD0 = StateSetTime & Button0;
assign Button_SetTaD1 = StateSetTime & Button1;
assign Button_SetTaD2 = StateSetTime & Button2;
assign Button_SetTaD3 = StateSetTime & Button3;

assign Button_DisplayDate = StateTime & Button3;

assign SecBuffer=~Button_DisplayDate?(Display?Day_Date:Sec_Time):Day_Date;
assign MinBuffer=~Button_DisplayDate?(Display?Mon_Date:Min_Time):Mon_Date;
assign HrBuffer =~Button_DisplayDate?(Display?Year_Date:Hr_Time):Year_Date;

TimeandDate TaD0 (
	.clk_32_768K(clk_32_768K),
	.Mode       (Mode),
	.Button0    (Button_SetTaD0),
	.Button1    (Button_SetTaD1),
	.Button2    (Button_SetTaD2),
	.Button3    (Button_SetTaD3),
	.Blink      (Blink),
	.Sec_Time   (Sec_Time),
	.Min_Time   (Min_Time),
	.Hr_Time    (Hr_Time),
	.Day_Date   (Day_Date),
	.Mon_Date   (Mon_Date),
	.Year_Date  (Year_Date),
	.Display    (Display)
);

Week wk0 (
	.Day_Date  (Day_Date),
	.Mon_Date  (Mon_Date),
	.Year_Date (Year_Date),
	.Week      (Week)
);

endmodule 

