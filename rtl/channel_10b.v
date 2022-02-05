
///////////////////////////////////////////////////////////////////
//       _____         __            ____   ____
//      /  _  \  __ __|  | __        \   \ /   /
//     /  /_\  \|  |  \  |/ /  ______ \   Y   / 
//    /    |    \  |  /    <  /_____/  \     /  
//    \____|__  /____/|__|_ \           \___/   
//            \/           \/                   
//
///////////////////////////////////////////////////////////////////
//Author      : Vipin.VC
//Project     : HDMI
//Description : HDMI transmitter
//              
//              
// 
//File type   : Verilog RTL
//Description : 
//



module channel_10b(
	input i_pclk ,
	input i_pclkx5
	input i_rstn,
	
	input [9:0] i_data;
	output o_tx
);



wire rst;
assign rst = ~i_rstn;

	OSERDES2 #(
		.DATA_RATE_DQ("DDR"),
		.DATA_RATE_TQ("SDR"),
		.DATA_WIDTH(10),
		.SERDES_MODE("MASTER"),
		.TRISTATE_WIDTH(1),
		.TBYTE_CTL("FALSE"),
		.TBYTE_SRC("FALSE")
	) master0(
		.DQ(o_tx),
		.OFB(),
		.TQ(),
		.TFB(),
		.SHIFTOUT1(),
		.SHIFTOUT2(),
		.TBYTEOUT(),
		.CLK(i_pclkx5),
		.CLKDIV(i_pclk),
		.D1(i_data[0]),
		.D2(i_data[1]),
		.D3(i_data[2]),
		.D4(i_data[3]),
		.D5(i_data[4]),
		.D6(i_data[5]),
		.D7(i_data[6]),
		.D8(i_data[7]),
		.TCE(1'b1),
		.OCE(1'b1),
		.TBYTEIN(1'b0),
		.RST(rst),
		.SHIFTIN1(carry1),
		.SHIFTIN2(carry2),
		.T1(1'b0),
		.T2(1'b0),
		.T3(1'b0),
		.T4(1'b0)
	);

	OSERDES2 #(
		.DATA_RATE_DQ("DDR"),
		.DATA_RATE_TQ("SDR"),
		.DATA_WIDTH(10),
		.SERDES_MODE("MASTER"),
		.TRISTATE_WIDTH(1),
		.TBYTE_CTL("FALSE"),
		.TBYTE_SRC("FALSE")
	) slave0(
		.DQ(),
		.OFB(),
		.TQ(),
		.TFB(),
		.SHIFTOUT1(carry1),
		.SHIFTOUT2(carry2),
		.TBYTEOUT(),
		.CLK(i_pclkx5),
		.CLKDIB(i_pclk),
		.D1(1'b0),
		.D2(1'b0),
		.D3(i_data[8]),
		.D4(i_data[9]),
		.D5(1'b0),
		.D6(1'b0),
		.D7(1'b0),
		.D8(1'b0),
		.TCE(1'b1),
		.OCE(1'b1),
		.TBYTEIN(1'b0),
		.RST(rst),
		.SHIFTIN1(1'b0),
		.SHIFTIN2(1'b0),
		.T1(1'b0),
		.T2(1'b0),
		.T3(1'b0),
		.T4(1'b0)
	);

end module;
