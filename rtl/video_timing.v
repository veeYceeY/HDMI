
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


module video_timing(
	input i_pclk,
	input i_rstn,
	input i_en,
	
	input [15:0] i_cfg_hfp;
	input [15:0] i_cfg_hsyn;
	input [15:0] i_cfg_hbp;
	input [15:0] i_cfg_hactive;
		
	input [15:0] i_cfg_vfp;
	input [15:0] i_cfg_vsyn;
	input [15:0] i_cfg_vbp;
	input [15:0] i_cfg_vactive;
	



	output o_hsync,
	output o_vsync,
	output o_de
);

wire vsyn;
wire hsyn;
wire de;
wire fe;

o_vsyn<=vsyn;
o_hsyn<=hsyn;
o_de<=de & fe;



	always@(posedge i_pclk,negedge i_rstn) begin
		if(~i_rstn) begin
			hstate<=HFP;
		end else begin
			hstate<=hstate_nxt:
		end
	end
	
	always@(*) begin
		case(hstate) begin
		HFP: begin
			hsyn<=1'b1;
			de<=1'b0;
			line_end<=1'b0;
			if(hcnt<i_hfp) begin
				hcnt_inc<=1'b1;
				hcnt_clr<=1'b0;
			end else begin
				hcnt_inc<'b0;
				hcnt_clr<=1'b1;
				hstate_nxt<=HSYN;
			end
		end
		HSYN: begin
			hsyn<=1'b1;
			de<=1'b0;
			if(hcnt<i_hsyn) begin	
				hcnt_inc<=1'b1;
				hcnt_clr<=1'b0;
			end else begin
				hcnt_inc<=1'b0;
				hcnt_clr<=1'b1;
				hstate_nxt<=HBP;
			end

		end
		HBP: begin
			hsyn<=1'b0;
			de<=1'b0;
			if(hcnt<i_hbp) begin
				hcnt_inc<=1'b1;
				hcnt_clr<=1'b0;
			end else begin
				hcnt_inc<=1'b0;
				hcnt_clr<=1'b1;
				hstate_nxt<=HACT;
			end

		end
		HACT: begin
			hsyn<=1'b0;
			de<=1'b1;
			if(hcnt<i_hact) begin
				hcnt_inc<=1'b1;
				hcnt_clr<=1'b0;
			end else begin
				hcnt_inc<=1'b0;
				hcnt_clr<=1'b1;
				hstate_nxt<=HFP;
				line_end<=1'b1;
			end
		end
		default: begin

		end
		endcase;
	end

	always@(posedge i_pclk,negedge i_rstn) begin
		if(~i_rstn) begin
			vstate<=HFP;
		end else begin
			vstate<=vstate_nxt:
		end
	end
	
	always@(*) begin
		case(vstate) begin
		VFP: begin
			vsyn<=1'b0;
			fe<=1'b0;
			if(vcnt<i_vfp) begin
				vcnt_inc<=line_end;
				vcnt_clr<=1'b0;
			end else begin
				vcnt_inc<'b0;
				vcnt_clr<=1'b1;
				hstate_nxt<=VSYN;
			end
		end
		VSYN: begin
			vsyn<=1'b1;
			fe<=1'b0;
			if(vcnt<i_vsyn) begin	
				vcnt_inc<=line_end;;
				vcnt_clr<=1'b0;
			end else begin
				vcnt_inc<=1'b0;
				vcnt_clr<=1'b1;
				hstate_nxt<=VBP;
			end

		end
		VBP: begin
			vsyn<=1'b0;
			fe<=1'b0;
			if(vcnt<i_vbp) begin
				vcnt_inc<=line_end;
				vcnt_clr<=1'b0;
			end else begin
				vcnt_inc<=1'b0;
				vcnt_clr<=1'b1;
				hstate_nxt<=VACT;
			end

		end
		VACT: begin
			vsyn<=1'b0;
			fe<=1'b1;
			if(vcnt<i_vact) begin
				vcnt_inc<=ine_end;
				vcnt_clr<=1'b0;
			end else begin
				vcnt_inc<=1'b0;
				vcnt_clr<=1'b1;
				hstate_nxt<=VFP;
			end
		end
		default: begin

		end
		endcase;
	end

	always@(posedge i_clk, negedge i_rstn) begin
		if(~i_rstn) begin
			hcnt<=16'b0;
		end else begin
			if(hcnt_clr) begin
				hcnt<=16'b0;
			end else begin
				if(hcnt_inc) begin
					hcnt<=hcnt+1;
				end 
			end
		end 
	end

	always@(posedge i_clk, negedge i_rstn) begin
		if(~i_rstn) begin
			vcnt<=16'b0;
		end else begin
			if(vcnt_clr) begin
				vcnt<=16'b0;
			end else begin
				if(vcnt_inc) begin
					vcnt<=vcnt+1;
				end 
			end
		end 
	end



end module;
