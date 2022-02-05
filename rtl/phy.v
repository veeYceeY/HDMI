


module phy(
	input i_pclk,
	input i_pclkx5,
	input i_rstn,

	input i_data0[9:0],
	input i_data1[9:0],
	input i_data2[9:0],

	output o_tx0_n,
	output o_tx0_p,

	output o_tx1_n,
	output o_tx1_p,

	output o_tx2_n,
	output o_tx2_p,
	
	output o_clk_n,
	output o_clk_p
);


channel_10b u_ch0 (
	i_pclk.(i_pclk),
	i_pclkx5.(i_pclkx5),
	i_rstn(i_rstn),
	i_data(i_data0);
	o_tx.(tx0)
	);


channel_10b u_ch1 (
	i_pclk.(i_pclk),
	i_pclkx5.(i_pclkx5),
	i_rstn(i_rstn),
	i_data(i_data1);
	o_tx.(tx1)
	);


channel_10b u_ch2 (
	i_pclk.(i_pclk),
	i_pclkx5(i_pclkx5),
	i_rstn(i_rstn),
	i_data(i_data2);
	o_tx.(tx2)
	);

end module;
