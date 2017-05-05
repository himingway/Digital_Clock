module detect_module (
	input CLK,
	input Pin_In,
	output H2L_Sig,
	output L2H_Sig
);

/**********************************/

parameter T100US = 13'd4_999;

/**********************************/

reg [12:0]Count1;
reg isEn;

always @ ( posedge CLK )
	isEn <= 1'b1;

/********************************************/

reg H2L_F1;
reg H2L_F2;
reg L2H_F1;
reg L2H_F2;

always @ ( posedge CLK )
	begin
		H2L_F1 <= Pin_In;
		H2L_F2 <= H2L_F1;
		L2H_F1 <= Pin_In;
		L2H_F2 <= L2H_F1;
	end
/***********************************/


assign H2L_Sig = isEn ? ( H2L_F2 & !H2L_F1 ) : 1'b0;
assign L2H_Sig = isEn ? ( !L2H_F2 & L2H_F1 ) : 1'b0;


/***********************************/

endmodule


