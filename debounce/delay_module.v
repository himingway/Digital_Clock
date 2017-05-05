module delay_module(
	input CLK,
	input H2L_Sig,
	input L2H_Sig,
	output Pin_Out
);



/****************************************/

parameter T1MS = 3'd5;

/***************************************/
reg isCount;
reg [2:0]Count1;

always @ ( posedge CLK )
	if( isCount && Count1 == T1MS )
		Count1 <= 3'd0;
	else if( isCount )
		Count1 <= Count1 + 1'b1;
	else if( !isCount )
		Count1 <= 3'd0;

/****************************************/

reg [3:0]Count_MS;

always @ ( posedge CLK )
	if( isCount && Count1 == T1MS )
		Count_MS <= Count_MS + 1'b1;
	else if( !isCount )
		Count_MS <= 4'd0;

reg rPin_Out;
reg [1:0]i;

always @ ( posedge CLK )
	case ( i )
		2'd0 :
			if( H2L_Sig ) i <= 2'd1;
		else if( L2H_Sig ) i <= 2'd2;

		2'd1 :
			if( Count_MS == 4'd10 ) begin isCount <= 1'b0; rPin_Out <= 1'b1; i <= 2'd0; end
			else	isCount <= 1'b1;

		2'd2 :
			if( Count_MS == 4'd10 ) begin isCount <= 1'b0; rPin_Out <= 1'b0; i <= 2'd0; end
			else	isCount <= 1'b1;
	endcase

/********************************************/

assign Pin_Out = rPin_Out;

/********************************************/



endmodule
