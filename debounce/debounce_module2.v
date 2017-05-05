module debounce_module2(
	input clk_32_768K,
	input key,
	output reg key_out
);

reg state;
reg[14:0] cnt;

always@(*)
begin
	if(key == 0)
		state = 1;  
	else if(cnt==15'd1_7000)
		state = 0;
end

always@(posedge clk_32_768K)
begin
	if(state == 1)
		cnt<=cnt+1'b1;
	else
		cnt<=0;
end

always@(posedge clk_32_768K)
begin
	if(state == 1)
		key_out <=1'b1;
	else
		key_out <=1'b0;
end

endmodule