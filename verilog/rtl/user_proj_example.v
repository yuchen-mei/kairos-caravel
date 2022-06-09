module DW_fp_dp4_inst_pipe (
	inst_clk,
	inst_a,
	inst_b,
	inst_c,
	inst_d,
	inst_e,
	inst_f,
	inst_g,
	inst_h,
	inst_rnd,
	z_inst,
	status_inst
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	parameter ARCH_TYPE = 1;
	parameter NUM_STAGES = 4;
	input wire inst_clk;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_a;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_b;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_c;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_d;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_e;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_f;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_g;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_h;
	input wire [2:0] inst_rnd;
	output wire [SIG_WIDTH + EXP_WIDTH:0] z_inst;
	output wire [7:0] status_inst;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_a_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_b_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_c_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_d_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_e_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_f_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_g_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_h_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe1;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe2;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe3;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe4;
	wire [SIG_WIDTH + EXP_WIDTH:0] z_inst_internal;
	reg [7:0] status_inst_pipe1;
	reg [7:0] status_inst_pipe2;
	reg [7:0] status_inst_pipe3;
	reg [7:0] status_inst_pipe4;
	wire [7:0] status_inst_internal;
	DW_fp_dp4 #(
		.sig_width(SIG_WIDTH),
		.exp_width(EXP_WIDTH),
		.ieee_compliance(IEEE_COMPLIANCE),
		.arch_type(ARCH_TYPE)
	) U1(
		.a(inst_a_reg),
		.b(inst_b_reg),
		.c(inst_c_reg),
		.d(inst_d_reg),
		.e(inst_e_reg),
		.f(inst_f_reg),
		.g(inst_g_reg),
		.h(inst_h_reg),
		.rnd(inst_rnd),
		.z(z_inst_internal),
		.status(status_inst_internal)
	);
	always @(posedge inst_clk) begin
		inst_a_reg <= inst_a;
		inst_b_reg <= inst_b;
		inst_c_reg <= inst_c;
		inst_d_reg <= inst_d;
		inst_e_reg <= inst_e;
		inst_f_reg <= inst_f;
		inst_g_reg <= inst_g;
		inst_h_reg <= inst_h;
		z_inst_pipe1 <= z_inst_internal;
		z_inst_pipe2 <= z_inst_pipe1;
		z_inst_pipe3 <= z_inst_pipe2;
		z_inst_pipe4 <= z_inst_pipe3;
		status_inst_pipe1 <= status_inst_internal;
		status_inst_pipe2 <= status_inst_pipe1;
		status_inst_pipe3 <= status_inst_pipe2;
		status_inst_pipe4 <= status_inst_pipe3;
	end
	assign z_inst = (NUM_STAGES == 5 ? z_inst_pipe4 : (NUM_STAGES == 4 ? z_inst_pipe3 : (NUM_STAGES == 3 ? z_inst_pipe2 : z_inst_pipe1)));
	assign status_inst = (NUM_STAGES == 5 ? status_inst_pipe4 : (NUM_STAGES == 4 ? status_inst_pipe3 : (NUM_STAGES == 3 ? status_inst_pipe2 : status_inst_pipe1)));
endmodule
module DW_fp_mac_DG_inst_pipe (
	inst_clk,
	inst_a,
	inst_b,
	inst_c,
	inst_rnd,
	inst_DG_ctrl,
	z_inst,
	status_inst
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	parameter NUM_STAGES = 4;
	input wire inst_clk;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_a;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_b;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_c;
	input wire [2:0] inst_rnd;
	input wire inst_DG_ctrl;
	output wire [SIG_WIDTH + EXP_WIDTH:0] z_inst;
	output wire [7:0] status_inst;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_a_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_b_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_c_reg;
	reg inst_DG_ctrl_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe1;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe2;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe3;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe4;
	wire [SIG_WIDTH + EXP_WIDTH:0] z_inst_internal;
	reg [7:0] status_inst_pipe1;
	reg [7:0] status_inst_pipe2;
	reg [7:0] status_inst_pipe3;
	reg [7:0] status_inst_pipe4;
	wire [7:0] status_inst_internal;
	DW_fp_mac_DG #(
		.sig_width(SIG_WIDTH),
		.exp_width(EXP_WIDTH),
		.ieee_compliance(IEEE_COMPLIANCE)
	) DW_fp_mac_DG_inst(
		.a(inst_a_reg),
		.b(inst_b_reg),
		.c(inst_c_reg),
		.rnd(inst_rnd),
		.DG_ctrl(inst_DG_ctrl_reg),
		.z(z_inst_internal),
		.status(status_inst_internal)
	);
	always @(posedge inst_clk) begin
		inst_a_reg <= inst_a;
		inst_b_reg <= inst_b;
		inst_c_reg <= inst_c;
		inst_DG_ctrl_reg <= inst_DG_ctrl;
		z_inst_pipe1 <= z_inst_internal;
		z_inst_pipe2 <= z_inst_pipe1;
		z_inst_pipe3 <= z_inst_pipe2;
		z_inst_pipe4 <= z_inst_pipe3;
		status_inst_pipe1 <= status_inst_internal;
		status_inst_pipe2 <= status_inst_pipe1;
		status_inst_pipe3 <= status_inst_pipe2;
		status_inst_pipe4 <= status_inst_pipe3;
	end
	assign z_inst = (NUM_STAGES == 5 ? z_inst_pipe4 : (NUM_STAGES == 4 ? z_inst_pipe3 : (NUM_STAGES == 3 ? z_inst_pipe2 : z_inst_pipe1)));
	assign status_inst = (NUM_STAGES == 5 ? status_inst_pipe4 : (NUM_STAGES == 4 ? status_inst_pipe3 : (NUM_STAGES == 3 ? status_inst_pipe2 : status_inst_pipe1)));
endmodule
module DW_lp_fp_multifunc_DG_inst_pipe (
	inst_clk,
	inst_a,
	inst_func,
	inst_rnd,
	inst_DG_ctrl,
	z_inst,
	status_inst
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	parameter NUM_STAGES = 4;
	input wire inst_clk;
	input wire [SIG_WIDTH + EXP_WIDTH:0] inst_a;
	input wire [2:0] inst_func;
	input wire [2:0] inst_rnd;
	input wire inst_DG_ctrl;
	output wire [SIG_WIDTH + EXP_WIDTH:0] z_inst;
	output wire [7:0] status_inst;
	reg [SIG_WIDTH + EXP_WIDTH:0] inst_a_reg;
	reg [15:0] inst_func_reg;
	reg inst_DG_ctrl_reg;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe1;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe2;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe3;
	reg [SIG_WIDTH + EXP_WIDTH:0] z_inst_pipe4;
	wire [SIG_WIDTH + EXP_WIDTH:0] z_inst_internal;
	reg [7:0] status_inst_pipe1;
	reg [7:0] status_inst_pipe2;
	reg [7:0] status_inst_pipe3;
	reg [7:0] status_inst_pipe4;
	wire [7:0] status_inst_internal;
	DW_lp_fp_multifunc_DG #(
		.sig_width(SIG_WIDTH),
		.exp_width(EXP_WIDTH),
		.ieee_compliance(IEEE_COMPLIANCE),
		.func_select(127),
		.pi_multiple(0)
	) DW_lp_fp_multifunc_DG_inst(
		.a(inst_a_reg),
		.func(inst_func_reg),
		.rnd(inst_rnd),
		.DG_ctrl(inst_DG_ctrl_reg),
		.z(z_inst_internal),
		.status(status_inst_internal)
	);
	always @(posedge inst_clk) begin
		inst_a_reg <= inst_a;
		inst_DG_ctrl_reg <= inst_DG_ctrl;
		case (inst_func)
			3'b000: inst_func_reg <= 16'b0000000000000001;
			3'b001: inst_func_reg <= 16'b0000000000000010;
			3'b010: inst_func_reg <= 16'b0000000000000100;
			3'b011: inst_func_reg <= 16'b0000000000001000;
			3'b100: inst_func_reg <= 16'b0000000000010000;
			3'b101: inst_func_reg <= 16'b0000000000100000;
			3'b110: inst_func_reg <= 16'b0000000001000000;
			default: inst_func_reg <= 16'b0000000000000000;
		endcase
		z_inst_pipe1 <= z_inst_internal;
		z_inst_pipe2 <= z_inst_pipe1;
		z_inst_pipe3 <= z_inst_pipe2;
		z_inst_pipe4 <= z_inst_pipe3;
		status_inst_pipe1 <= status_inst_internal;
		status_inst_pipe2 <= status_inst_pipe1;
		status_inst_pipe3 <= status_inst_pipe2;
		status_inst_pipe4 <= status_inst_pipe3;
	end
	assign z_inst = (NUM_STAGES == 5 ? z_inst_pipe4 : (NUM_STAGES == 4 ? z_inst_pipe3 : (NUM_STAGES == 3 ? z_inst_pipe2 : z_inst_pipe1)));
	assign status_inst = (NUM_STAGES == 5 ? status_inst_pipe4 : (NUM_STAGES == 4 ? status_inst_pipe3 : (NUM_STAGES == 3 ? status_inst_pipe2 : status_inst_pipe1)));
endmodule
module LU_systolic (
	clk,
	rst_n,
	vld,
	en,
	mat_in,
	l_out,
	u_out
);
	parameter DWIDTH = 32;
	parameter MATSIZE = 3;
	input wire clk;
	input wire rst_n;
	input wire vld;
	input wire en;
	input wire [((MATSIZE * MATSIZE) * DWIDTH) - 1:0] mat_in;
	output wire [((MATSIZE * MATSIZE) * DWIDTH) - 1:0] l_out;
	output reg [((MATSIZE * MATSIZE) * DWIDTH) - 1:0] u_out;
	reg [DWIDTH - 1:0] vec_in_r [MATSIZE - 1:0];
	wire [DWIDTH - 1:0] ucircle_out [MATSIZE - 1:0];
	wire [DWIDTH - 1:0] asquare_out [((MATSIZE * (MATSIZE - 1)) / 2) - 1:0];
	wire [DWIDTH - 1:0] usquare_out [((MATSIZE * (MATSIZE - 1)) / 2) - 1:0];
	reg [3:0] glb_cnt;
	reg [2:0] state_r;
	genvar i;
	genvar j;
	generate
		for (i = 0; i < MATSIZE; i = i + 1) begin : genblk1
			assign l_out[((i * MATSIZE) + i) * DWIDTH+:DWIDTH] = 32'h3f800000;
		end
		for (i = 0; i < (MATSIZE - 1); i = i + 1) begin : genblk2
			for (j = i + 1; j < MATSIZE; j = j + 1) begin : genblk1
				assign l_out[((i * MATSIZE) + j) * DWIDTH+:DWIDTH] = 32'h00000000;
			end
		end
		for (i = 1; i < MATSIZE; i = i + 1) begin : genblk3
			for (j = 0; j < i; j = j + 1) begin : genblk1
				wire [DWIDTH:1] sv2v_tmp_3DCFC;
				assign sv2v_tmp_3DCFC = 32'h00000000;
				always @(*) u_out[((i * MATSIZE) + j) * DWIDTH+:DWIDTH] = sv2v_tmp_3DCFC;
			end
		end
	endgenerate
	always @(posedge clk)
		if (~rst_n || ~vld)
			glb_cnt <= 'h0;
		else if (en)
			glb_cnt <= glb_cnt + 1'b1;
	always @(posedge clk)
		case (glb_cnt)
			4'h4: u_out[0+:DWIDTH] <= usquare_out[1];
			4'h5: u_out[DWIDTH+:DWIDTH] <= usquare_out[1];
			4'h6: begin
				u_out[2 * DWIDTH+:DWIDTH] <= usquare_out[1];
				u_out[(MATSIZE + 1) * DWIDTH+:DWIDTH] <= usquare_out[2];
			end
			4'h7: u_out[(MATSIZE + 2) * DWIDTH+:DWIDTH] <= usquare_out[2];
			4'h8: u_out[((2 * MATSIZE) + 2) * DWIDTH+:DWIDTH] <= ucircle_out[2];
		endcase
	always @(posedge clk)
		if (~rst_n || ~vld) begin
			state_r <= 'h0;
			vec_in_r[0] <= 'h0;
			vec_in_r[1] <= 'h0;
			vec_in_r[2] <= 'h0;
		end
		else if (en)
			case (state_r)
				4'h0: begin
					vec_in_r[0] <= mat_in[0+:DWIDTH];
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h1;
				end
				4'h1: begin
					vec_in_r[0] <= mat_in[DWIDTH+:DWIDTH];
					vec_in_r[1] <= mat_in[MATSIZE * DWIDTH+:DWIDTH];
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h2;
				end
				4'h2: begin
					vec_in_r[0] <= mat_in[2 * DWIDTH+:DWIDTH];
					vec_in_r[1] <= mat_in[(MATSIZE + 1) * DWIDTH+:DWIDTH];
					vec_in_r[2] <= mat_in[(2 * MATSIZE) * DWIDTH+:DWIDTH];
					state_r <= 4'h3;
				end
				4'h3: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= mat_in[(MATSIZE + 2) * DWIDTH+:DWIDTH];
					vec_in_r[2] <= mat_in[((2 * MATSIZE) + 1) * DWIDTH+:DWIDTH];
					state_r <= 4'h4;
				end
				4'h4: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= mat_in[((2 * MATSIZE) + 2) * DWIDTH+:DWIDTH];
					state_r <= 4'h5;
				end
				4'h5: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h5;
				end
				default: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h0;
				end
			endcase
	circle_PE_LU #(.DWIDTH(DWIDTH)) circle_PE_LU_U11(
		.clk(clk),
		.rst_n(rst_n),
		.vld(vld),
		.en(en),
		.ain(vec_in_r[0]),
		.uout(ucircle_out[0])
	);
	square_PE_LU #(.DWIDTH(DWIDTH)) square_PE_LU_U21(
		.clk(clk),
		.rst_n(rst_n),
		.vld(vld),
		.en(en),
		.i(3'h2),
		.j(3'h1),
		.ain(vec_in_r[1]),
		.uin(ucircle_out[0]),
		.aout(asquare_out[0]),
		.uout(usquare_out[0]),
		.l(l_out[MATSIZE * DWIDTH+:DWIDTH])
	);
	circle_PE_LU #(.DWIDTH(DWIDTH)) circle_PE_LU_U22(
		.clk(clk),
		.rst_n(rst_n),
		.vld(vld),
		.en(en),
		.ain(asquare_out[0]),
		.uout(ucircle_out[1])
	);
	square_PE_LU #(.DWIDTH(DWIDTH)) square_PE_LU_U31(
		.clk(clk),
		.rst_n(rst_n),
		.vld(vld),
		.en(en),
		.i(3'h3),
		.j(3'h1),
		.ain(vec_in_r[2]),
		.uin(usquare_out[0]),
		.aout(asquare_out[1]),
		.uout(usquare_out[1]),
		.l(l_out[(2 * MATSIZE) * DWIDTH+:DWIDTH])
	);
	square_PE_LU #(.DWIDTH(DWIDTH)) square_PE_LU_U32(
		.clk(clk),
		.rst_n(rst_n),
		.vld(vld),
		.en(en),
		.i(3'h3),
		.j(3'h2),
		.ain(asquare_out[1]),
		.uin(ucircle_out[1]),
		.aout(asquare_out[2]),
		.uout(usquare_out[2]),
		.l(l_out[((2 * MATSIZE) + 1) * DWIDTH+:DWIDTH])
	);
	circle_PE_LU #(.DWIDTH(DWIDTH)) circle_PE_LU_U33(
		.clk(clk),
		.rst_n(rst_n),
		.vld(vld),
		.en(en),
		.ain(asquare_out[2]),
		.uout(ucircle_out[2])
	);
endmodule
module TriMat_inv (
	clk,
	rst_n,
	vld,
	en,
	mat_in,
	mat_out
);
	parameter DWIDTH = 32;
	parameter MATSIZE = 3;
	input wire clk;
	input wire rst_n;
	input wire vld;
	input wire en;
	input wire [((MATSIZE * MATSIZE) * DWIDTH) - 1:0] mat_in;
	output reg [((MATSIZE * MATSIZE) * DWIDTH) - 1:0] mat_out;
	wire [DWIDTH - 1:0] zcircle_out [MATSIZE - 1:0];
	wire [DWIDTH - 1:0] zsquare_out [((MATSIZE * (MATSIZE - 1)) / 2) - 1:0];
	wire [DWIDTH - 1:0] xsquare_out [((MATSIZE * (MATSIZE - 1)) / 2) - 1:0];
	reg [DWIDTH - 1:0] vec_in_r [MATSIZE - 1:0];
	genvar i;
	generate
		for (i = 1; i < MATSIZE; i = i + 1) begin : genblk1
			genvar j;
			for (j = 0; j < i; j = j + 1) begin : genblk1
				wire [DWIDTH:1] sv2v_tmp_679E7;
				assign sv2v_tmp_679E7 = 32'h00000000;
				always @(*) mat_out[((i * MATSIZE) + j) * DWIDTH+:DWIDTH] = sv2v_tmp_679E7;
			end
		end
	endgenerate
	reg [3:0] state_r;
	reg [3:0] glb_cnt;
	always @(posedge clk)
		if (~rst_n || ~vld)
			glb_cnt <= 'h0;
		else if (en)
			glb_cnt <= glb_cnt + 1'b1;
	always @(posedge clk)
		case (glb_cnt)
			4'h4: mat_out[0+:DWIDTH] <= zsquare_out[1];
			4'h5: mat_out[DWIDTH+:DWIDTH] <= zsquare_out[2];
			4'h6: begin
				mat_out[2 * DWIDTH+:DWIDTH] <= zcircle_out[2];
				mat_out[(MATSIZE + 1) * DWIDTH+:DWIDTH] <= zsquare_out[2];
			end
			4'h7: mat_out[(MATSIZE + 2) * DWIDTH+:DWIDTH] <= zcircle_out[2];
			4'h8: mat_out[((2 * MATSIZE) + 2) * DWIDTH+:DWIDTH] <= zcircle_out[2];
		endcase
	always @(posedge clk)
		if (~rst_n || ~vld) begin
			state_r <= 'h0;
			vec_in_r[0] <= 'h0;
			vec_in_r[1] <= 'h0;
			vec_in_r[2] <= 'h0;
		end
		else if (en)
			case (state_r)
				4'h0: begin
					vec_in_r[0] <= 32'h3f800000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h1;
				end
				4'h1: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h2;
				end
				4'h2: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h3f800000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h3;
				end
				4'h3: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h4;
				end
				4'h4: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h3f800000;
					state_r <= 4'h5;
				end
				4'h5: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h5;
				end
				default: begin
					vec_in_r[0] <= 32'h00000000;
					vec_in_r[1] <= 32'h00000000;
					vec_in_r[2] <= 32'h00000000;
					state_r <= 4'h0;
				end
			endcase
	circle_PE_Tri #(.DWIDTH(DWIDTH)) circle_PE_Tri_U11(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.xin(vec_in_r[0]),
		.cir_x(mat_in[0+:DWIDTH]),
		.zout(zcircle_out[0])
	);
	square_PE_Tri #(.DWIDTH(DWIDTH)) square_PE_Tri_U12(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.xin(vec_in_r[1]),
		.sqr_x(mat_in[DWIDTH+:DWIDTH]),
		.zin(zcircle_out[0]),
		.xout(xsquare_out[0]),
		.zout(zsquare_out[0])
	);
	square_PE_Tri #(.DWIDTH(DWIDTH)) square_PE_Tri_U13(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.xin(vec_in_r[2]),
		.sqr_x(mat_in[2 * DWIDTH+:DWIDTH]),
		.zin(zsquare_out[0]),
		.xout(xsquare_out[1]),
		.zout(zsquare_out[1])
	);
	circle_PE_Tri #(.DWIDTH(DWIDTH)) circle_PE_Tri_U22(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.xin(xsquare_out[0]),
		.cir_x(mat_in[(MATSIZE + 1) * DWIDTH+:DWIDTH]),
		.zout(zcircle_out[1])
	);
	square_PE_Tri #(.DWIDTH(DWIDTH)) square_PE_Tri_U23(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.xin(xsquare_out[1]),
		.sqr_x(mat_in[(MATSIZE + 2) * DWIDTH+:DWIDTH]),
		.zin(zcircle_out[1]),
		.xout(xsquare_out[2]),
		.zout(zsquare_out[2])
	);
	circle_PE_Tri #(.DWIDTH(DWIDTH)) circle_PE_Tri_U33(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.xin(xsquare_out[2]),
		.cir_x(mat_in[((2 * MATSIZE) + 2) * DWIDTH+:DWIDTH]),
		.zout(zcircle_out[2])
	);
endmodule
module accelerator (
	clk,
	rst_n,
	input_data,
	input_rdy,
	input_vld,
	output_data,
	output_rdy,
	output_vld
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	parameter INPUT_FIFO_WIDTH = 16;
	parameter OUTPUT_FIFO_WIDTH = 8;
	parameter CONFIG_DATA_WIDTH = 16;
	parameter VECTOR_LANES = 16;
	parameter DATAPATH = 256;
	parameter INSTR_MEM_BANK_DEPTH = 512;
	parameter INSTR_MEM_ADDR_WIDTH = $clog2(INSTR_MEM_BANK_DEPTH);
	parameter DATA_MEM_BANK_DEPTH = 256;
	parameter DATA_MEM_ADDR_WIDTH = $clog2(DATA_MEM_BANK_DEPTH);
	input wire clk;
	input wire rst_n;
	input wire [INPUT_FIFO_WIDTH - 1:0] input_data;
	output wire input_rdy;
	input wire input_vld;
	output wire [OUTPUT_FIFO_WIDTH - 1:0] output_data;
	input wire output_rdy;
	output wire output_vld;
	localparam DATA_WIDTH = (SIG_WIDTH + EXP_WIDTH) + 1;
	localparam ADDR_WIDTH = 12;
	wire [INPUT_FIFO_WIDTH - 1:0] input_fifo_dout;
	wire params_fifo_deq;
	wire instr_fifo_deq;
	wire input_fifo_deq;
	wire input_fifo_empty_n;
	wire input_rdy_w;
	wire [OUTPUT_FIFO_WIDTH - 1:0] output_fifo_din;
	wire output_fifo_enq;
	wire output_fifo_full_n;
	wire output_vld_w;
	wire instr_wen;
	wire input_wen;
	wire output_wb_ren;
	wire instr_full_n;
	wire input_full_n;
	wire output_empty_n;
	wire [INSTR_MEM_ADDR_WIDTH - 1:0] instr_wadr;
	wire [DATA_MEM_ADDR_WIDTH - 1:0] input_wadr;
	wire [DATA_MEM_ADDR_WIDTH - 1:0] output_wb_radr;
	wire mat_inv_en;
	wire mat_inv_vld;
	wire mvp_core_en;
	wire [11:0] mvp_mem_addr;
	wire mvp_mem_we;
	wire mvp_mem_ren;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mvp_mem_wdata;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mvp_mem_rdata;
	wire [2:0] width;
	wire [INSTR_MEM_ADDR_WIDTH - 1:0] instr_mem_addr;
	wire instr_mem_csb;
	wire instr_mem_web;
	wire [DATA_WIDTH - 1:0] instr_mem_wdata;
	wire [DATA_WIDTH - 1:0] instr_mem_rdata;
	wire [INSTR_MEM_ADDR_WIDTH - 1:0] pc;
	wire [31:0] instr;
	wire [DATA_MEM_ADDR_WIDTH - 1:0] data_mem_addr;
	wire data_mem_csb;
	wire data_mem_web;
	wire [(DATAPATH / 32) - 1:0] data_mem_wmask0;
	wire [DATAPATH - 1:0] data_mem_wdata;
	wire [DATAPATH - 1:0] data_mem_rdata;
	wire [DATAPATH - 1:0] output_wb_data;
	wire mat_inv_vld_out;
	wire [(9 * DATA_WIDTH) - 1:0] mat_inv_out_l;
	wire [(9 * DATA_WIDTH) - 1:0] mat_inv_out_u;
	wire [DATAPATH - 1:0] input_aggregator_dout;
	wire [DATA_WIDTH - 1:0] instr_aggregator_dout;
	mvp_core #(
		.SIG_WIDTH(SIG_WIDTH),
		.EXP_WIDTH(EXP_WIDTH),
		.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
		.VECTOR_LANES(VECTOR_LANES),
		.ADDR_WIDTH(ADDR_WIDTH),
		.INSTR_MEM_ADDR_WIDTH(INSTR_MEM_ADDR_WIDTH),
		.DATA_MEM_ADDR_WIDTH(DATA_MEM_ADDR_WIDTH)
	) mvp_core_inst(
		.clk(clk),
		.rst_n(rst_n),
		.en(mvp_core_en),
		.pc(pc),
		.instr(instr),
		.mem_addr(mvp_mem_addr),
		.mem_we(mvp_mem_we),
		.mem_ren(mvp_mem_ren),
		.mem_wdata(mvp_mem_wdata),
		.mem_rdata(mvp_mem_rdata),
		.width(width)
	);
	mat_inv mat_inv_inst(
		.clk(clk),
		.rst_n(rst_n),
		.en(mat_inv_en),
		.vld(mat_inv_vld),
		.mat_in(mvp_mem_wdata[0+:DATA_WIDTH * 9]),
		.vld_out(mat_inv_vld_out),
		.mat_inv_out_l(mat_inv_out_l),
		.mat_inv_out_u(mat_inv_out_u)
	);
	ram_sync_1rw1r #(
		.DATA_WIDTH(32),
		.ADDR_WIDTH(INSTR_MEM_ADDR_WIDTH),
		.DEPTH(INSTR_MEM_BANK_DEPTH)
	) instr_mem(
		.clk(clk),
		.csb0(instr_wen || instr_mem_csb),
		.web0(instr_wen || instr_mem_web),
		.addr0((instr_wen ? instr_wadr : instr_mem_addr)),
		.wmask0(1'b1),
		.din0(instr_aggregator_dout),
		.dout0(instr_mem_rdata),
		.csb1(~instr_full_n),
		.addr1(pc),
		.dout1(instr)
	);
	ram_sync_1rw1r #(
		.DATA_WIDTH(DATAPATH),
		.ADDR_WIDTH(DATA_MEM_ADDR_WIDTH),
		.DEPTH(DATA_MEM_BANK_DEPTH)
	) data_mem(
		.clk(clk),
		.csb0(input_wen || data_mem_csb),
		.web0(input_wen || data_mem_web),
		.addr0((input_wen ? input_wadr : data_mem_addr)),
		.wmask0((input_wen ? 8'hff : data_mem_wmask0)),
		.din0((input_wen ? input_aggregator_dout : data_mem_wdata)),
		.dout0(data_mem_rdata),
		.csb1(output_wb_ren),
		.addr1(output_wb_radr),
		.dout1(output_wb_data)
	);
	memory_controller #(
		.ADDR_WIDTH(ADDR_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.VECTOR_LANES(VECTOR_LANES),
		.DATAPATH(DATAPATH),
		.INSTR_MEM_ADDR_WIDTH(INSTR_MEM_ADDR_WIDTH),
		.DATA_MEM_ADDR_WIDTH(DATA_MEM_ADDR_WIDTH)
	) mem_ctrl_inst(
		.clk(clk),
		.mem_addr(mvp_mem_addr),
		.mem_we(mvp_mem_we),
		.mem_ren(mvp_mem_ren),
		.mem_wdata(mvp_mem_wdata),
		.mem_rdata(mvp_mem_rdata),
		.width(width),
		.instr_mem_addr(instr_mem_addr),
		.instr_mem_csb(instr_mem_csb),
		.instr_mem_web(instr_mem_web),
		.instr_mem_wdata(instr_mem_wdata),
		.instr_mem_rdata(instr_mem_rdata),
		.data_mem_addr(data_mem_addr),
		.data_mem_csb(data_mem_csb),
		.data_mem_web(data_mem_web),
		.data_mem_wmask(data_mem_wmask0),
		.data_mem_wdata(data_mem_wdata),
		.data_mem_rdata(data_mem_rdata),
		.mat_inv_in_l(mat_inv_out_l),
		.mat_inv_in_u(mat_inv_out_u)
	);
	fifo #(
		.DATA_WIDTH(INPUT_FIFO_WIDTH),
		.FIFO_DEPTH(3),
		.COUNTER_WIDTH(1)
	) input_fifo_inst(
		.clk(clk),
		.rst_n(rst_n),
		.din(input_data),
		.enq(input_rdy_w && input_vld),
		.full_n(input_rdy_w),
		.dout(input_fifo_dout),
		.deq((params_fifo_deq || instr_fifo_deq) || input_fifo_deq),
		.empty_n(input_fifo_empty_n),
		.clr(1'b0)
	);
	assign input_rdy = input_rdy_w;
	aggregator #(
		.DATA_WIDTH(INPUT_FIFO_WIDTH),
		.FETCH_WIDTH(32 / INPUT_FIFO_WIDTH)
	) instr_aggregator_inst(
		.clk(clk),
		.rst_n(rst_n),
		.sender_data(input_fifo_dout),
		.sender_empty_n(input_fifo_empty_n),
		.sender_deq(instr_fifo_deq),
		.receiver_data(instr_aggregator_dout),
		.receiver_full_n(instr_full_n),
		.receiver_enq(instr_wen)
	);
	aggregator #(
		.DATA_WIDTH(INPUT_FIFO_WIDTH),
		.FETCH_WIDTH(DATAPATH / INPUT_FIFO_WIDTH)
	) input_aggregator_inst(
		.clk(clk),
		.rst_n(rst_n),
		.sender_data(input_fifo_dout),
		.sender_empty_n(input_fifo_empty_n),
		.sender_deq(input_fifo_deq),
		.receiver_data(input_aggregator_dout),
		.receiver_full_n(input_full_n),
		.receiver_enq(input_wen)
	);
	fifo #(
		.DATA_WIDTH(OUTPUT_FIFO_WIDTH),
		.FIFO_DEPTH(3),
		.COUNTER_WIDTH(1)
	) output_fifo_inst(
		.clk(clk),
		.rst_n(rst_n),
		.din(output_fifo_din),
		.enq(output_fifo_enq),
		.full_n(output_fifo_full_n),
		.dout(output_data),
		.deq(output_rdy && output_vld_w),
		.empty_n(output_vld_w),
		.clr(1'b0)
	);
	assign output_vld = output_vld_w;
	deaggregator #(
		.DATA_WIDTH(OUTPUT_FIFO_WIDTH),
		.FETCH_WIDTH(DATAPATH / OUTPUT_FIFO_WIDTH)
	) output_deaggregator_inst(
		.clk(clk),
		.rst_n(rst_n),
		.sender_data(output_wb_data),
		.sender_empty_n(output_empty_n),
		.sender_deq(output_wb_ren),
		.receiver_data(output_fifo_din),
		.receiver_full_n(output_fifo_full_n),
		.receiver_enq(output_fifo_enq)
	);
	controller #(
		.INPUT_FIFO_WIDTH(INPUT_FIFO_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH),
		.INSTR_MEM_ADDR_WIDTH(INSTR_MEM_ADDR_WIDTH),
		.DATA_MEM_ADDR_WIDTH(DATA_MEM_ADDR_WIDTH),
		.CONFIG_DATA_WIDTH(CONFIG_DATA_WIDTH)
	) controller_inst(
		.clk(clk),
		.rst_n(rst_n),
		.params_fifo_dout(input_fifo_dout),
		.params_fifo_deq(params_fifo_deq),
		.params_fifo_empty_n(input_fifo_empty_n),
		.instr_full_n(instr_full_n),
		.input_full_n(input_full_n),
		.output_empty_n(output_empty_n),
		.instr_wadr(instr_wadr),
		.input_wadr(input_wadr),
		.output_wb_radr(output_wb_radr),
		.instr_wen(instr_wen),
		.input_wen(input_wen),
		.output_wb_ren(output_wb_ren),
		.mem_addr(mvp_mem_addr),
		.mem_read(mvp_mem_ren),
		.mem_write(mvp_mem_we),
		.mat_inv_en(mat_inv_en),
		.mat_inv_vld(mat_inv_vld),
		.mat_inv_vld_out(mat_inv_vld_out),
		.mvp_core_en(mvp_core_en)
	);
endmodule
module circle_PE_LU (
	clk,
	rst_n,
	vld,
	en,
	ain,
	uout
);
	parameter DWIDTH = 32;
	input wire clk;
	input wire rst_n;
	input wire vld;
	input wire en;
	input wire [DWIDTH - 1:0] ain;
	output wire [DWIDTH - 1:0] uout;
	reg [DWIDTH - 1:0] ain_r;
	always @(posedge clk)
		if (~rst_n || ~vld)
			ain_r <= 'h0;
		else if (en)
			ain_r <= ain;
	assign uout = ain_r;
endmodule
module circle_PE_Tri (
	clk,
	rst_n,
	en,
	xin,
	cir_x,
	zout
);
	parameter DWIDTH = 32;
	input wire clk;
	input wire rst_n;
	input wire en;
	input wire [DWIDTH - 1:0] xin;
	input wire [DWIDTH - 1:0] cir_x;
	output wire [DWIDTH - 1:0] zout;
	reg [DWIDTH - 1:0] zout_r;
	wire [DWIDTH - 1:0] div_z0;
	always @(posedge clk)
		if (~rst_n)
			zout_r <= 'h0;
		else if (en)
			zout_r <= div_z0;
	assign zout = zout_r;
	DW_fp_div_DG div_U0(
		.a(xin),
		.b(cir_x),
		.rnd(3'h0),
		.DG_ctrl(en),
		.z(div_z0),
		.status()
	);
endmodule
module controller (
	clk,
	rst_n,
	params_fifo_dout,
	params_fifo_deq,
	params_fifo_empty_n,
	instr_wen,
	input_wen,
	output_wb_ren,
	instr_full_n,
	input_full_n,
	output_empty_n,
	instr_wadr,
	input_wadr,
	output_wb_radr,
	mem_addr,
	mem_read,
	mem_write,
	mat_inv_en,
	mat_inv_vld,
	mat_inv_vld_out,
	mvp_core_en
);
	parameter INPUT_FIFO_WIDTH = 16;
	parameter ADDR_WIDTH = 12;
	parameter INSTR_MEM_ADDR_WIDTH = 8;
	parameter DATA_MEM_ADDR_WIDTH = 12;
	parameter NUM_CONFIGS = 5;
	parameter CONFIG_DATA_WIDTH = 16;
	parameter CONFIG_ADDR_WIDTH = $clog2(NUM_CONFIGS);
	input wire clk;
	input wire rst_n;
	input wire [INPUT_FIFO_WIDTH - 1:0] params_fifo_dout;
	output wire params_fifo_deq;
	input wire params_fifo_empty_n;
	input wire instr_wen;
	input wire input_wen;
	input wire output_wb_ren;
	output wire instr_full_n;
	output wire input_full_n;
	output wire output_empty_n;
	output wire [INSTR_MEM_ADDR_WIDTH - 1:0] instr_wadr;
	output wire [DATA_MEM_ADDR_WIDTH - 1:0] input_wadr;
	output wire [DATA_MEM_ADDR_WIDTH - 1:0] output_wb_radr;
	input wire [ADDR_WIDTH - 1:0] mem_addr;
	input wire mem_read;
	input wire mem_write;
	output reg mat_inv_en;
	output wire mat_inv_vld;
	input wire mat_inv_vld_out;
	output reg mvp_core_en;
	localparam IO_ADDR = 12'ha00;
	localparam INVMAT_ADDR = 12'ha02;
	reg [CONFIG_DATA_WIDTH - 1:0] config_r [NUM_CONFIGS - 1:0];
	wire [ADDR_WIDTH - 1:0] instr_max_wadr_c;
	wire [ADDR_WIDTH - 1:0] input_max_wadr_c;
	wire [ADDR_WIDTH - 1:0] input_wadr_offset;
	wire [ADDR_WIDTH - 1:0] output_max_adr_c;
	wire [ADDR_WIDTH - 1:0] output_radr_offset;
	reg [1:0] state_r;
	reg [CONFIG_ADDR_WIDTH - 1:0] config_adr_r;
	reg [ADDR_WIDTH - 1:0] instr_wadr_r;
	reg [ADDR_WIDTH - 1:0] input_wadr_r;
	reg [ADDR_WIDTH - 1:0] output_wbadr_r;
	reg mat_inv_en_r;
	wire config_adr;
	assign config_adr = config_adr_r;
	assign instr_wadr = instr_wadr_r;
	assign input_wadr = input_wadr_r[3+:DATA_MEM_ADDR_WIDTH];
	assign output_wb_radr = output_wbadr_r[3+:DATA_MEM_ADDR_WIDTH];
	assign params_fifo_deq = (state_r == 0) && params_fifo_empty_n;
	assign instr_full_n = (state_r == 1) && (instr_wadr_r <= instr_max_wadr_c);
	assign input_full_n = (state_r == 3) && (input_wadr_r <= (input_wadr_offset + input_max_wadr_c));
	assign output_empty_n = (state_r == 3) && (output_wbadr_r <= (output_radr_offset + output_max_adr_c));
	assign mat_inv_vld = mat_inv_en && ~mat_inv_en_r;
	always @(posedge clk)
		if (~rst_n) begin
			state_r <= 0;
			config_adr_r <= 0;
			instr_wadr_r <= 0;
			input_wadr_r <= 0;
			output_wbadr_r <= 0;
			mat_inv_en <= 0;
			mat_inv_en_r <= 0;
			mvp_core_en <= 0;
		end
		else begin
			mat_inv_en_r <= mat_inv_en;
			if (state_r == 0) begin
				if (params_fifo_empty_n) begin
					config_r[config_adr_r] <= params_fifo_dout;
					config_adr_r <= config_adr_r + 1;
					if (config_adr_r == (NUM_CONFIGS - 1))
						state_r <= 1;
				end
			end
			else if (state_r == 1) begin
				instr_wadr_r <= (instr_wen && (instr_wadr_r <= instr_max_wadr_c) ? instr_wadr_r + 1 : instr_wadr_r);
				if (instr_wadr_r == (instr_max_wadr_c + 1)) begin
					state_r <= 2;
					mvp_core_en <= 1;
				end
			end
			else if (state_r == 2) begin
				if (mem_write && (mem_addr == IO_ADDR)) begin
					state_r <= 3;
					mvp_core_en <= 0;
					input_wadr_r <= input_wadr_offset;
					output_wbadr_r <= output_radr_offset;
				end
				else if (mem_write && (mem_addr == INVMAT_ADDR)) begin
					mvp_core_en <= 0;
					mat_inv_en <= 1;
				end
				else if (mat_inv_en && mat_inv_vld_out) begin
					mvp_core_en <= 1;
					mat_inv_en <= 0;
				end
			end
			else if (state_r == 3) begin
				input_wadr_r <= (input_wen && input_full_n ? input_wadr_r + 8 : input_wadr_r);
				output_wbadr_r <= (output_wb_ren && output_empty_n ? output_wbadr_r + 8 : output_wbadr_r);
				if ((input_wadr_r >= (input_wadr_offset + input_max_wadr_c)) && (output_wbadr_r >= (output_radr_offset + output_max_adr_c))) begin
					mvp_core_en <= 1;
					state_r <= 2;
				end
			end
		end
	assign instr_max_wadr_c = config_r[0];
	assign input_max_wadr_c = config_r[1];
	assign input_wadr_offset = config_r[2];
	assign output_max_adr_c = config_r[3];
	assign output_radr_offset = config_r[4];
endmodule
module decoder (
	instr,
	vfu_opcode,
	vd_addr,
	vs1_addr,
	vs2_addr,
	vs3_addr,
	op_sel,
	funct3,
	masking,
	reg_we,
	mem_we,
	mem_addr,
	vd_addr_ex1,
	vd_addr_ex2,
	vd_addr_ex3,
	reg_we_ex1,
	reg_we_ex2,
	reg_we_ex3,
	op_sel_ex1,
	op_sel_ex2,
	op_sel_ex3,
	stall
);
	input wire [31:0] instr;
	output reg [4:0] vfu_opcode;
	output wire [4:0] vd_addr;
	output wire [4:0] vs1_addr;
	output wire [4:0] vs2_addr;
	output wire [4:0] vs3_addr;
	output reg [3:0] op_sel;
	output wire [2:0] funct3;
	output wire masking;
	output wire reg_we;
	output wire mem_we;
	output wire [11:0] mem_addr;
	input wire [4:0] vd_addr_ex1;
	input wire [4:0] vd_addr_ex2;
	input wire [4:0] vd_addr_ex3;
	input wire reg_we_ex1;
	input wire reg_we_ex2;
	input wire reg_we_ex3;
	input wire [3:0] op_sel_ex1;
	input wire [3:0] op_sel_ex2;
	input wire [3:0] op_sel_ex3;
	output wire stall;
	wire [6:0] opcode;
	wire [4:0] dest;
	wire [4:0] src1;
	wire [4:0] src2;
	wire [5:0] funct6;
	assign opcode = instr[6:0];
	assign dest = instr[11:7];
	assign funct3 = instr[14:12];
	assign src1 = instr[19:15];
	assign src2 = instr[24:20];
	assign masking = instr[25];
	assign funct6 = instr[31:26];
	wire overwrite_multiplicand;
	assign overwrite_multiplicand = (((opcode == 6'b101100) || (opcode == 6'b101101)) || (opcode == 6'b101110)) || (opcode == 6'b101111);
	assign vs1_addr = src1;
	assign vs2_addr = (overwrite_multiplicand ? dest : src2);
	assign vs3_addr = (opcode == 7'b0001011 ? instr[31:27] : (overwrite_multiplicand ? src2 : dest));
	assign vd_addr = dest;
	always @(*) begin
		case ({opcode, funct6})
			13'b1010111000000: vfu_opcode = 5'b00000;
			13'b1010111000010: vfu_opcode = 5'b00001;
			13'b1010111000100: vfu_opcode = 5'b01000;
			13'b1010111000110: vfu_opcode = 5'b01001;
			13'b1010111001000: vfu_opcode = 5'b01010;
			13'b1010111001001: vfu_opcode = 5'b01011;
			13'b1010111001010: vfu_opcode = 5'b01100;
			13'b1010111011000: vfu_opcode = 5'b01101;
			13'b1010111011001: vfu_opcode = 5'b01111;
			13'b1010111011011: vfu_opcode = 5'b01110;
			13'b1010111100100: vfu_opcode = 5'b00010;
			13'b1010111101000: vfu_opcode = 5'b00100;
			13'b1010111101001: vfu_opcode = 5'b00110;
			13'b1010111101010: vfu_opcode = 5'b00101;
			13'b1010111101011: vfu_opcode = 5'b00111;
			13'b1010111101100: vfu_opcode = 5'b00100;
			13'b1010111101101: vfu_opcode = 5'b00110;
			13'b1010111101110: vfu_opcode = 5'b00101;
			13'b1010111101111: vfu_opcode = 5'b00111;
			13'b1010111010010: vfu_opcode = 5'b10000;
			default: vfu_opcode = 5'b00000;
		endcase
		case (opcode)
			7'b1010011: op_sel = 4'b0001;
			7'b1010111: op_sel = 4'b0010;
			7'b0001011: op_sel = 4'b0100;
			7'b0000111: op_sel = 4'b1000;
			default: op_sel = 4'b0000;
		endcase
		if (|vfu_opcode[4:3])
			op_sel = 4'b0000;
	end
	assign mem_addr = instr[31:20];
	assign mem_we = opcode == 7'b0100111;
	assign reg_we = ~mem_we;
	wire stage1_dependency;
	wire stage2_dependency;
	wire stage3_dependency;
	assign stage1_dependency = (((vs1_addr == vd_addr_ex1) || (vs2_addr == vd_addr_ex1)) || (vs3_addr == vd_addr_ex1)) && reg_we_ex1;
	assign stage2_dependency = (((vs1_addr == vd_addr_ex2) || (vs2_addr == vd_addr_ex2)) || (vs3_addr == vd_addr_ex2)) && reg_we_ex2;
	assign stage3_dependency = (((vs1_addr == vd_addr_ex3) || (vs2_addr == vd_addr_ex3)) || (vs3_addr == vd_addr_ex3)) && reg_we_ex3;
	assign stall = ((stage1_dependency && |op_sel_ex1) || (stage2_dependency && |op_sel_ex2[2:0])) || (stage3_dependency && op_sel_ex3[2]);
endmodule
module dot_product_unit (
	clk,
	en,
	vec_a,
	vec_b,
	vec_c,
	funct,
	rnd,
	vec_out
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	parameter VECTOR_LANES = 16;
	parameter NUM_STAGES = 3;
	parameter DATA_WIDTH = (SIG_WIDTH + EXP_WIDTH) + 1;
	input wire clk;
	input wire en;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_a;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_b;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_c;
	input wire [2:0] funct;
	input wire [2:0] rnd;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out;
	wire [((VECTOR_LANES * 8) * DATA_WIDTH) - 1:0] dp4_mat_in;
	wire [((VECTOR_LANES * 8) * DATA_WIDTH) - 1:0] dp4_dot_in;
	wire [((VECTOR_LANES * 8) * DATA_WIDTH) - 1:0] dp4_qmul_in;
	wire [((VECTOR_LANES * 8) * DATA_WIDTH) - 1:0] dp4_rot_in;
	reg [((VECTOR_LANES * 8) * DATA_WIDTH) - 1:0] inst_dp4;
	wire [(VECTOR_LANES * 8) - 1:0] status_inst;
	genvar i;
	generate
		for (i = 0; i < 3; i = i + 1) begin : mat_col
			genvar j;
			for (j = 0; j < 3; j = j + 1) begin : mat_row
				assign dp4_mat_in[(((3 * i) + j) * 8) * DATA_WIDTH+:DATA_WIDTH] = vec_a[j * DATA_WIDTH+:DATA_WIDTH];
				assign dp4_mat_in[((((3 * i) + j) * 8) + 1) * DATA_WIDTH+:DATA_WIDTH] = vec_b[(3 * i) * DATA_WIDTH+:DATA_WIDTH];
				assign dp4_mat_in[((((3 * i) + j) * 8) + 2) * DATA_WIDTH+:DATA_WIDTH] = vec_a[(3 + j) * DATA_WIDTH+:DATA_WIDTH];
				assign dp4_mat_in[((((3 * i) + j) * 8) + 3) * DATA_WIDTH+:DATA_WIDTH] = vec_b[((3 * i) + 1) * DATA_WIDTH+:DATA_WIDTH];
				assign dp4_mat_in[((((3 * i) + j) * 8) + 4) * DATA_WIDTH+:DATA_WIDTH] = vec_a[(6 + j) * DATA_WIDTH+:DATA_WIDTH];
				assign dp4_mat_in[((((3 * i) + j) * 8) + 5) * DATA_WIDTH+:DATA_WIDTH] = vec_b[((3 * i) + 2) * DATA_WIDTH+:DATA_WIDTH];
				assign dp4_mat_in[((((3 * i) + j) * 8) + 6) * DATA_WIDTH+:DATA_WIDTH] = vec_c[((3 * i) + j) * DATA_WIDTH+:DATA_WIDTH];
				assign dp4_mat_in[((((3 * i) + j) * 8) + 7) * DATA_WIDTH+:DATA_WIDTH] = 32'h3f800000;
			end
		end
		for (i = 0; i < (VECTOR_LANES / 4); i = i + 1) begin : dot_product
			assign dp4_dot_in[((4 * i) * 8) * DATA_WIDTH+:DATA_WIDTH] = vec_a[(4 * i) * DATA_WIDTH+:DATA_WIDTH];
			assign dp4_dot_in[(((4 * i) * 8) + 1) * DATA_WIDTH+:DATA_WIDTH] = vec_b[(4 * i) * DATA_WIDTH+:DATA_WIDTH];
			assign dp4_dot_in[(((4 * i) * 8) + 2) * DATA_WIDTH+:DATA_WIDTH] = vec_a[((4 * i) + 1) * DATA_WIDTH+:DATA_WIDTH];
			assign dp4_dot_in[(((4 * i) * 8) + 3) * DATA_WIDTH+:DATA_WIDTH] = vec_b[((4 * i) + 1) * DATA_WIDTH+:DATA_WIDTH];
			assign dp4_dot_in[(((4 * i) * 8) + 4) * DATA_WIDTH+:DATA_WIDTH] = vec_a[((4 * i) + 2) * DATA_WIDTH+:DATA_WIDTH];
			assign dp4_dot_in[(((4 * i) * 8) + 5) * DATA_WIDTH+:DATA_WIDTH] = vec_b[((4 * i) + 2) * DATA_WIDTH+:DATA_WIDTH];
			assign dp4_dot_in[(((4 * i) * 8) + 6) * DATA_WIDTH+:DATA_WIDTH] = vec_a[((4 * i) + 3) * DATA_WIDTH+:DATA_WIDTH];
			assign dp4_dot_in[(((4 * i) * 8) + 7) * DATA_WIDTH+:DATA_WIDTH] = vec_b[((4 * i) + 3) * DATA_WIDTH+:DATA_WIDTH];
		end
	endgenerate
	wire [DATA_WIDTH - 1:0] a_neg [VECTOR_LANES - 1:0];
	generate
		for (i = 0; i < VECTOR_LANES; i = i + 1) begin : genblk3
			assign a_neg[i] = {~vec_a[(i * DATA_WIDTH) + (DATA_WIDTH - 1)], vec_a[(i * DATA_WIDTH) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 2 : ((DATA_WIDTH - 2) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)) - 1)-:((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)]};
		end
	endgenerate
	assign dp4_qmul_in[0+:DATA_WIDTH * 8] = {vec_a[0+:DATA_WIDTH], vec_b[0+:DATA_WIDTH], a_neg[1], vec_b[DATA_WIDTH+:DATA_WIDTH], a_neg[2], vec_b[2 * DATA_WIDTH+:DATA_WIDTH], a_neg[3], vec_b[3 * DATA_WIDTH+:DATA_WIDTH]};
	assign dp4_qmul_in[DATA_WIDTH * 8+:DATA_WIDTH * 8] = {vec_a[0+:DATA_WIDTH], vec_b[DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_b[0+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_b[3 * DATA_WIDTH+:DATA_WIDTH], a_neg[3], vec_b[2 * DATA_WIDTH+:DATA_WIDTH]};
	assign dp4_qmul_in[DATA_WIDTH * 16+:DATA_WIDTH * 8] = {vec_a[0+:DATA_WIDTH], vec_b[2 * DATA_WIDTH+:DATA_WIDTH], a_neg[1], vec_b[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_b[0+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_b[3 * DATA_WIDTH+:DATA_WIDTH]};
	assign dp4_qmul_in[DATA_WIDTH * 24+:DATA_WIDTH * 8] = {vec_a[0+:DATA_WIDTH], vec_b[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_b[2 * DATA_WIDTH+:DATA_WIDTH], a_neg[2], vec_b[DATA_WIDTH+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_b[0+:DATA_WIDTH]};
	assign dp4_rot_in[0+:DATA_WIDTH * 8] = {vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], a_neg[2], a_neg[3], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[0+:DATA_WIDTH]};
	assign dp4_rot_in[DATA_WIDTH * 8+:DATA_WIDTH * 8] = {vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH]};
	assign dp4_rot_in[DATA_WIDTH * 16+:DATA_WIDTH * 8] = {vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], a_neg[2], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], a_neg[2], vec_a[0+:DATA_WIDTH]};
	assign dp4_rot_in[DATA_WIDTH * 24+:DATA_WIDTH * 8] = {vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], a_neg[3], vec_a[0+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], a_neg[3]};
	assign dp4_rot_in[DATA_WIDTH * 32+:DATA_WIDTH * 8] = {vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], a_neg[1], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], a_neg[3]};
	assign dp4_rot_in[DATA_WIDTH * 40+:DATA_WIDTH * 8] = {vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH]};
	assign dp4_rot_in[DATA_WIDTH * 48+:DATA_WIDTH * 8] = {vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH]};
	assign dp4_rot_in[DATA_WIDTH * 56+:DATA_WIDTH * 8] = {vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], a_neg[1], vec_a[0+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], a_neg[1], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH]};
	assign dp4_rot_in[DATA_WIDTH * 64+:DATA_WIDTH * 8] = {vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[0+:DATA_WIDTH], vec_a[DATA_WIDTH+:DATA_WIDTH], a_neg[1], a_neg[2], vec_a[2 * DATA_WIDTH+:DATA_WIDTH]};
	generate
		if (VECTOR_LANES > 4) begin : genblk4
			assign dp4_qmul_in[DATA_WIDTH * (8 * (((VECTOR_LANES - 1) >= 4 ? VECTOR_LANES - 1 : ((VECTOR_LANES - 1) + ((VECTOR_LANES - 1) >= 4 ? VECTOR_LANES - 4 : 6 - VECTOR_LANES)) - 1) - (((VECTOR_LANES - 1) >= 4 ? VECTOR_LANES - 4 : 6 - VECTOR_LANES) - 1)))+:DATA_WIDTH * (8 * ((VECTOR_LANES - 1) >= 4 ? VECTOR_LANES - 4 : 6 - VECTOR_LANES))] = 1'sb0;
			assign dp4_dot_in[DATA_WIDTH * 8+:DATA_WIDTH * 24] = 1'sb0;
			assign dp4_dot_in[DATA_WIDTH * 40+:DATA_WIDTH * 32] = 1'sb0;
		end
		if (VECTOR_LANES > 9) begin : genblk5
			assign dp4_mat_in[DATA_WIDTH * (8 * (((VECTOR_LANES - 1) >= 9 ? VECTOR_LANES - 1 : ((VECTOR_LANES - 1) + ((VECTOR_LANES - 1) >= 9 ? VECTOR_LANES - 9 : 11 - VECTOR_LANES)) - 1) - (((VECTOR_LANES - 1) >= 9 ? VECTOR_LANES - 9 : 11 - VECTOR_LANES) - 1)))+:DATA_WIDTH * (8 * ((VECTOR_LANES - 1) >= 9 ? VECTOR_LANES - 9 : 11 - VECTOR_LANES))] = 1'sb0;
			assign dp4_rot_in[DATA_WIDTH * (8 * (((VECTOR_LANES - 1) >= 9 ? VECTOR_LANES - 1 : ((VECTOR_LANES - 1) + ((VECTOR_LANES - 1) >= 9 ? VECTOR_LANES - 9 : 11 - VECTOR_LANES)) - 1) - (((VECTOR_LANES - 1) >= 9 ? VECTOR_LANES - 9 : 11 - VECTOR_LANES) - 1)))+:DATA_WIDTH * (8 * ((VECTOR_LANES - 1) >= 9 ? VECTOR_LANES - 9 : 11 - VECTOR_LANES))] = 1'sb0;
		end
	endgenerate
	always @(*)
		case (funct)
			3'b000: inst_dp4 = dp4_mat_in;
			3'b001: inst_dp4 = dp4_dot_in;
			3'b010: inst_dp4 = dp4_qmul_in;
			3'b011: inst_dp4 = dp4_rot_in;
			default: inst_dp4 = 1'sb0;
		endcase
	generate
		for (i = 0; i < VECTOR_LANES; i = i + 1) begin : genblk6
			DW_fp_dp4_inst_pipe #(
				.SIG_WIDTH(SIG_WIDTH),
				.EXP_WIDTH(EXP_WIDTH),
				.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
				.ARCH_TYPE(1),
				.NUM_STAGES(NUM_STAGES)
			) DW_lp_fp_dp4_inst(
				.inst_clk(clk),
				.inst_a(inst_dp4[(i * 8) * DATA_WIDTH+:DATA_WIDTH]),
				.inst_b(inst_dp4[((i * 8) + 1) * DATA_WIDTH+:DATA_WIDTH]),
				.inst_c(inst_dp4[((i * 8) + 2) * DATA_WIDTH+:DATA_WIDTH]),
				.inst_d(inst_dp4[((i * 8) + 3) * DATA_WIDTH+:DATA_WIDTH]),
				.inst_e(inst_dp4[((i * 8) + 4) * DATA_WIDTH+:DATA_WIDTH]),
				.inst_f(inst_dp4[((i * 8) + 5) * DATA_WIDTH+:DATA_WIDTH]),
				.inst_g(inst_dp4[((i * 8) + 6) * DATA_WIDTH+:DATA_WIDTH]),
				.inst_h(inst_dp4[((i * 8) + 7) * DATA_WIDTH+:DATA_WIDTH]),
				.inst_rnd(rnd),
				.z_inst(vec_out[i * DATA_WIDTH+:DATA_WIDTH]),
				.status_inst(status_inst[i * 8+:8])
			);
		end
	endgenerate
endmodule
module instruction_fetch (
	clk,
	rst_n,
	en,
	pc
);
	parameter ADDR_WIDTH = 8;
	input wire clk;
	input wire rst_n;
	input wire en;
	output wire [ADDR_WIDTH - 1:0] pc;
	reg [ADDR_WIDTH - 1:0] pc_pipe1;
	reg [ADDR_WIDTH - 1:0] pc_pipe2;
	always @(posedge clk)
		if (~rst_n) begin
			pc_pipe1 <= 0;
			pc_pipe2 <= 0;
		end
		else if (en) begin
			pc_pipe1 <= pc_pipe1 + 1;
			pc_pipe2 <= pc_pipe1;
		end
	assign pc = (en ? pc_pipe1 : pc_pipe2);
endmodule
module mat_inv (
	clk,
	rst_n,
	en,
	vld,
	mat_in,
	rdy,
	vld_out,
	mat_inv_out_l,
	mat_inv_out_u
);
	parameter DATA_WIDTH = 32;
	parameter MATSIZE = 3;
	parameter VECTOR_LANES = MATSIZE * MATSIZE;
	input wire clk;
	input wire rst_n;
	input wire en;
	input wire vld;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mat_in;
	output wire rdy;
	output wire vld_out;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mat_inv_out_l;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mat_inv_out_u;
	reg data_vld;
	reg vld_out_r1;
	reg [7:0] vld_cnt;
	reg [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] mat_in_r;
	wire [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] mat_row_major;
	genvar i;
	generate
		for (i = 0; i < 3; i = i + 1) begin : genblk1
			genvar j;
			for (j = 0; j < 3; j = j + 1) begin : genblk1
				assign mat_row_major[((i * MATSIZE) + j) * DATA_WIDTH+:DATA_WIDTH] = mat_in[((3 * j) + i) * DATA_WIDTH+:DATA_WIDTH];
			end
		end
	endgenerate
	function automatic [(MATSIZE * DATA_WIDTH) - 1:0] sv2v_cast_E468C;
		input reg [(MATSIZE * DATA_WIDTH) - 1:0] inp;
		sv2v_cast_E468C = inp;
	endfunction
	always @(posedge clk)
		if (~rst_n) begin
			data_vld <= 'h0;
			vld_out_r1 <= 'h0;
			mat_in_r <= {MATSIZE {sv2v_cast_E468C(1'sb0)}};
		end
		else if (en)
			if (vld) begin
				data_vld <= 'h1;
				vld_out_r1 <= 'h0;
				mat_in_r <= mat_row_major;
			end
			else begin
				if (vld_cnt != 'h14)
					data_vld <= data_vld;
				else begin
					data_vld <= 1'b0;
					vld_out_r1 <= 1'b1;
				end
				mat_in_r <= mat_in_r;
			end
	always @(posedge clk)
		if (~rst_n)
			vld_cnt <= 'h0;
		else if (en)
			if (data_vld && (vld_cnt != 'h14))
				vld_cnt <= vld_cnt + 1'b1;
			else
				vld_cnt <= 'h0;
	assign vld_out = vld_out_r1;
	reg [3:0] LU_cnt;
	wire [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] l_mat;
	wire [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] u_mat;
	reg [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] l_mat_r;
	reg [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] u_mat_r;
	always @(posedge clk) begin
		if (~rst_n || ~data_vld) begin
			LU_cnt <= 4'b0000;
			l_mat_r <= {MATSIZE {sv2v_cast_E468C(1'sb0)}};
			u_mat_r <= {MATSIZE {sv2v_cast_E468C(1'sb0)}};
		end
		else if (en)
			if (LU_cnt != 'ha)
				LU_cnt <= LU_cnt + 1'b1;
		if (LU_cnt == 'h9) begin
			l_mat_r <= l_mat;
			u_mat_r <= u_mat;
		end
	end
	LU_systolic #(
		.DWIDTH(DATA_WIDTH),
		.MATSIZE(MATSIZE)
	) LU_systolic_U0(
		.clk(clk),
		.rst_n(rst_n),
		.vld(data_vld),
		.en(en),
		.mat_in(mat_in_r),
		.l_out(l_mat),
		.u_out(u_mat)
	);
	reg [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] l_mat_in_r;
	reg [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] u_mat_in_r;
	reg Tri_vld;
	always @(posedge clk)
		if (~rst_n || ~data_vld) begin
			l_mat_in_r <= {MATSIZE {sv2v_cast_E468C(1'sb0)}};
			u_mat_in_r <= {MATSIZE {sv2v_cast_E468C(1'sb0)}};
			Tri_vld <= 1'b0;
		end
		else if (en)
			if (LU_cnt == 'ha) begin
				l_mat_in_r <= l_mat_r;
				u_mat_in_r <= u_mat_r;
				Tri_vld <= 1'b1;
			end
	wire [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] l_mat_in_r_t;
	wire [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] l_mat_inv;
	wire [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] l_mat_t_inv;
	wire [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] u_mat_inv;
	reg [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] l_mat_inv_r;
	reg [((MATSIZE * MATSIZE) * DATA_WIDTH) - 1:0] u_mat_inv_r;
	reg [7:0] triinv_cnt;
	reg rdy_r1;
	generate
		for (i = 0; i < MATSIZE; i = i + 1) begin : genblk2
			genvar j;
			for (j = 0; j < MATSIZE; j = j + 1) begin : genblk1
				assign l_mat_in_r_t[((i * MATSIZE) + j) * DATA_WIDTH+:DATA_WIDTH] = l_mat_in_r[((j * MATSIZE) + i) * DATA_WIDTH+:DATA_WIDTH];
				assign l_mat_inv[((i * MATSIZE) + j) * DATA_WIDTH+:DATA_WIDTH] = l_mat_t_inv[((j * MATSIZE) + i) * DATA_WIDTH+:DATA_WIDTH];
			end
		end
	endgenerate
	TriMat_inv #(
		.DWIDTH(DATA_WIDTH),
		.MATSIZE(MATSIZE)
	) TriMat_inv_U(
		.clk(clk),
		.rst_n(rst_n),
		.vld(Tri_vld),
		.en(en),
		.mat_in(u_mat_in_r),
		.mat_out(u_mat_inv)
	);
	TriMat_inv #(
		.DWIDTH(DATA_WIDTH),
		.MATSIZE(MATSIZE)
	) TriMat_inv_LT(
		.clk(clk),
		.rst_n(rst_n),
		.vld(Tri_vld),
		.en(en),
		.mat_in(l_mat_in_r_t),
		.mat_out(l_mat_t_inv)
	);
	always @(posedge clk)
		if (~rst_n || ~data_vld) begin
			triinv_cnt <= 4'b0000;
			if (~rst_n) begin
				u_mat_inv_r <= {MATSIZE {sv2v_cast_E468C(1'sb0)}};
				l_mat_inv_r <= {MATSIZE {sv2v_cast_E468C(1'sb0)}};
				rdy_r1 <= 1'b0;
			end
			if (~data_vld)
				rdy_r1 <= 1'b1;
		end
		else if (en) begin
			if (triinv_cnt != 'h19)
				triinv_cnt <= triinv_cnt + 1'b1;
			if (triinv_cnt == 'h14) begin
				u_mat_inv_r <= u_mat_inv;
				l_mat_inv_r <= l_mat_inv;
			end
			if (triinv_cnt == 'h14)
				rdy_r1 <= 1'b1;
			if (data_vld)
				rdy_r1 <= 1'b0;
		end
	assign rdy = rdy_r1;
	generate
		for (i = 0; i < 3; i = i + 1) begin : genblk3
			genvar j;
			for (j = 0; j < 3; j = j + 1) begin : genblk1
				assign mat_inv_out_u[((3 * j) + i) * DATA_WIDTH+:DATA_WIDTH] = u_mat_inv_r[((i * MATSIZE) + j) * DATA_WIDTH+:DATA_WIDTH];
				assign mat_inv_out_l[((3 * j) + i) * DATA_WIDTH+:DATA_WIDTH] = l_mat_inv_r[((i * MATSIZE) + j) * DATA_WIDTH+:DATA_WIDTH];
			end
		end
	endgenerate
endmodule
module memory_controller (
	clk,
	mem_addr,
	mem_we,
	mem_ren,
	mem_wdata,
	mem_rdata,
	width,
	instr_mem_addr,
	instr_mem_csb,
	instr_mem_web,
	instr_mem_wdata,
	instr_mem_rdata,
	data_mem_addr,
	data_mem_csb,
	data_mem_web,
	data_mem_wmask,
	data_mem_wdata,
	data_mem_rdata,
	mat_inv_in_l,
	mat_inv_in_u
);
	parameter ADDR_WIDTH = 12;
	parameter DATA_WIDTH = 32;
	parameter VECTOR_LANES = 16;
	parameter DATAPATH = 8;
	parameter INSTR_MEM_ADDR_WIDTH = 8;
	parameter DATA_MEM_ADDR_WIDTH = 12;
	input wire clk;
	input wire [ADDR_WIDTH - 1:0] mem_addr;
	input wire mem_we;
	input wire mem_ren;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_wdata;
	output reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_rdata;
	input wire [2:0] width;
	output wire [INSTR_MEM_ADDR_WIDTH - 1:0] instr_mem_addr;
	output reg instr_mem_csb;
	output reg instr_mem_web;
	output wire [31:0] instr_mem_wdata;
	input wire [31:0] instr_mem_rdata;
	output wire [DATA_MEM_ADDR_WIDTH - 1:0] data_mem_addr;
	output reg data_mem_csb;
	output reg data_mem_web;
	output reg [(DATAPATH / 32) - 1:0] data_mem_wmask;
	output wire [DATAPATH - 1:0] data_mem_wdata;
	input wire [DATAPATH - 1:0] data_mem_rdata;
	input wire [(9 * DATA_WIDTH) - 1:0] mat_inv_in_l;
	input wire [(9 * DATA_WIDTH) - 1:0] mat_inv_in_u;
	localparam ADDR_MASK = 12'h800;
	localparam DATA_ADDR = 12'h000;
	localparam TEXT_ADDR = 12'h800;
	localparam IO_ADDR = 12'ha00;
	localparam INVMAT_ADDR = 12'ha02;
	localparam INVMAT_L_ADDR = 12'ha03;
	localparam INVMAT_U_ADDR = 12'ha04;
	reg [ADDR_WIDTH - 1:0] mem_addr_r;
	always @(posedge clk) mem_addr_r <= mem_addr;
	assign instr_mem_addr = mem_addr[INSTR_MEM_ADDR_WIDTH - 1:0];
	assign instr_mem_wdata = mem_wdata;
	assign data_mem_addr = mem_addr[3+:DATA_MEM_ADDR_WIDTH];
	assign data_mem_wdata = mem_wdata;
	always @(*) begin
		instr_mem_csb = 1'b0;
		instr_mem_web = 1'b0;
		data_mem_web = 1'b0;
		data_mem_web = 1'b0;
		data_mem_wmask = 1'sb1;
		if ((mem_addr & ADDR_MASK) == DATA_ADDR) begin
			data_mem_csb = mem_ren || mem_we;
			data_mem_web = mem_we;
		end
		else if ((mem_addr & ADDR_MASK) == TEXT_ADDR) begin
			instr_mem_csb = mem_ren || mem_we;
			instr_mem_web = mem_we;
		end
		if (mem_addr_r == INVMAT_L_ADDR)
			mem_rdata = mat_inv_in_l;
		else if (mem_addr_r == INVMAT_U_ADDR)
			mem_rdata = mat_inv_in_u;
		else if ((mem_addr_r & ADDR_MASK) == DATA_ADDR)
			mem_rdata = data_mem_rdata;
		else if ((mem_addr_r & ADDR_MASK) == TEXT_ADDR)
			mem_rdata = instr_mem_rdata;
	end
endmodule
module mvp_core (
	clk,
	rst_n,
	en,
	pc,
	instr,
	mem_addr,
	mem_ren,
	mem_we,
	mem_rdata,
	mem_wdata,
	width,
	data_out_vld,
	data_out,
	reg_wb
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	parameter VECTOR_LANES = 16;
	parameter ADDR_WIDTH = 12;
	parameter DATA_WIDTH = (SIG_WIDTH + EXP_WIDTH) + 1;
	parameter INSTR_MEM_ADDR_WIDTH = 8;
	parameter DATA_MEM_ADDR_WIDTH = 12;
	parameter REG_BANK_DEPTH = 32;
	parameter REG_ADDR_WIDTH = $clog2(REG_BANK_DEPTH);
	input wire clk;
	input wire rst_n;
	input wire en;
	output wire [INSTR_MEM_ADDR_WIDTH - 1:0] pc;
	input wire [31:0] instr;
	output wire [ADDR_WIDTH - 1:0] mem_addr;
	output wire mem_ren;
	output wire mem_we;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_rdata;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_wdata;
	output wire [2:0] width;
	output wire data_out_vld;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] data_out;
	output wire [4:0] reg_wb;
	reg en_q;
	wire stall;
	wire [4:0] opcode_id;
	reg [4:0] opcode_ex1;
	wire [4:0] vd_addr_id;
	reg [4:0] vd_addr_ex1;
	reg [4:0] vd_addr_ex2;
	reg [4:0] vd_addr_ex3;
	reg [4:0] vd_addr_ex4;
	reg [4:0] vd_addr_wb;
	wire [4:0] vs1_addr_id;
	reg [4:0] vs1_addr_ex1;
	wire [4:0] vs2_addr_id;
	reg [4:0] vs2_addr_ex1;
	wire [4:0] vs3_addr_id;
	reg [4:0] vs3_addr_ex1;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vs1_data_id;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vs1_data_ex1;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vs2_data_id;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vs2_data_ex1;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vs3_data_id;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vs3_data_ex1;
	wire [DATA_WIDTH - 1:0] rs1_data_id;
	wire [DATA_WIDTH - 1:0] rs2_data_id;
	wire [DATA_WIDTH - 1:0] rs3_data_id;
	wire [2:0] funct3_id;
	reg [2:0] funct3_ex1;
	wire [3:0] op_sel_id;
	reg [3:0] op_sel_ex1;
	reg [3:0] op_sel_ex2;
	reg [3:0] op_sel_ex3;
	reg [3:0] op_sel_ex4;
	reg [3:0] op_sel_wb;
	wire reg_we_id;
	reg reg_we_ex1;
	reg reg_we_ex2;
	reg reg_we_ex3;
	reg reg_we_ex4;
	reg reg_we_wb;
	wire mem_we_id;
	reg mem_we_ex1;
	wire [ADDR_WIDTH - 1:0] mem_addr_id;
	reg [ADDR_WIDTH - 1:0] mem_addr_ex1;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_rdata_ex3;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_rdata_ex4;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_rdata_wb;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] reg_wdata_wb;
	assign data_out = reg_wdata_wb;
	assign data_out_vld = en && reg_we_wb;
	assign reg_wb = vd_addr_wb;
	always @(posedge clk) begin
		en_q <= en;
		if (data_out_vld) begin
			begin : sv2v_autoblock_1
				reg signed [31:0] i;
				for (i = VECTOR_LANES - 1; i >= 0; i = i - 1)
					$write("%h_", reg_wdata_wb[i * DATA_WIDTH+:DATA_WIDTH]);
			end
			$display;
		end
	end
	instruction_fetch #(.ADDR_WIDTH(INSTR_MEM_ADDR_WIDTH)) if_stage(
		.clk(clk),
		.rst_n(rst_n),
		.en(en & ~stall),
		.pc(pc)
	);
	decoder decoder_inst(
		.instr(instr),
		.vfu_opcode(opcode_id),
		.vd_addr(vd_addr_id),
		.vs1_addr(vs1_addr_id),
		.vs2_addr(vs2_addr_id),
		.vs3_addr(vs3_addr_id),
		.op_sel(op_sel_id),
		.funct3(funct3_id),
		.reg_we(reg_we_id),
		.mem_we(mem_we_id),
		.mem_addr(mem_addr_id),
		.vd_addr_ex1(vd_addr_ex1),
		.vd_addr_ex2(vd_addr_ex2),
		.vd_addr_ex3(vd_addr_ex3),
		.reg_we_ex1(reg_we_ex1),
		.reg_we_ex2(reg_we_ex2),
		.reg_we_ex3(reg_we_ex3),
		.op_sel_ex1(op_sel_ex1),
		.op_sel_ex2(op_sel_ex2),
		.op_sel_ex3(op_sel_ex3),
		.stall(stall)
	);
	vrf #(
		.ADDR_WIDTH(REG_ADDR_WIDTH),
		.DEPTH(REG_BANK_DEPTH),
		.DATA_WIDTH(VECTOR_LANES * DATA_WIDTH)
	) vrf_inst(
		.clk(clk),
		.rst_n(rst_n),
		.wen(reg_we_wb),
		.addr_w(vd_addr_wb),
		.data_w(reg_wdata_wb),
		.addr_r1(vs1_addr_id),
		.data_r1(vs1_data_id),
		.addr_r2(vs2_addr_id),
		.data_r2(vs2_data_id),
		.addr_r3(vs3_addr_id),
		.data_r3(vs3_data_id)
	);
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] operand_a;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] operand_b;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] operand_c;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out_ex2;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out_ex3;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out_ex4;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out_wb;
	wire [DATA_WIDTH - 1:0] mfu_out_ex4;
	reg [DATA_WIDTH - 1:0] mfu_out_wb;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vfu_out_ex4;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vfu_out_wb;
	wire [(9 * DATA_WIDTH) - 1:0] mat_out_wb;
	wire [7:0] status_inst;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] stage2_forward;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] stage3_forward;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] stage4_forward;
	assign stage2_forward = vec_out_ex2;
	assign stage3_forward = (op_sel_ex3[3] ? mem_rdata_ex3 : vec_out_ex3);
	always @(*)
		case (op_sel_ex4)
			4'b0001: stage4_forward = mfu_out_ex4;
			4'b0010: stage4_forward = vfu_out_ex4;
			4'b1000: stage4_forward = mem_rdata_ex4;
			default: stage4_forward = vec_out_ex4;
		endcase
	assign operand_a = (((vs1_addr_ex1 == vd_addr_ex2) && reg_we_ex2) && ~|op_sel_ex2 ? stage2_forward : (((vs1_addr_ex1 == vd_addr_ex3) && reg_we_ex3) && ~|op_sel_ex3[2:0] ? stage3_forward : (((vs1_addr_ex1 == vd_addr_ex4) && reg_we_ex4) && ~op_sel_ex4[2] ? stage4_forward : ((vs1_addr_ex1 == vd_addr_wb) && reg_we_wb ? reg_wdata_wb : vs1_data_ex1))));
	assign operand_b = (((vs2_addr_ex1 == vd_addr_ex2) && reg_we_ex2) && ~|op_sel_ex2 ? stage2_forward : (((vs2_addr_ex1 == vd_addr_ex3) && reg_we_ex3) && ~|op_sel_ex3[2:0] ? stage3_forward : (((vs2_addr_ex1 == vd_addr_ex4) && reg_we_ex4) && ~op_sel_ex4[2] ? stage4_forward : ((vs2_addr_ex1 == vd_addr_wb) && reg_we_wb ? reg_wdata_wb : vs2_data_ex1))));
	assign operand_c = (((vs3_addr_ex1 == vd_addr_ex2) && reg_we_ex2) && ~|op_sel_ex2 ? stage2_forward : (((vs3_addr_ex1 == vd_addr_ex3) && reg_we_ex3) && ~|op_sel_ex3[2:0] ? stage3_forward : (((vs3_addr_ex1 == vd_addr_ex4) && reg_we_ex4) && ~op_sel_ex4[2] ? stage4_forward : ((vs3_addr_ex1 == vd_addr_wb) && reg_we_wb ? reg_wdata_wb : vs3_data_ex1))));
	vector_unit #(
		.SIG_WIDTH(SIG_WIDTH),
		.EXP_WIDTH(EXP_WIDTH),
		.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
		.VECTOR_LANES(VECTOR_LANES)
	) vector_unit_inst(
		.clk(clk),
		.en(~|op_sel_ex1),
		.vec_a(operand_a),
		.vec_b(operand_b),
		.rnd(3'b000),
		.opcode(opcode_ex1),
		.funct(funct3_ex1),
		.vec_out(vec_out_ex2)
	);
	vfpu #(
		.SIG_WIDTH(SIG_WIDTH),
		.EXP_WIDTH(EXP_WIDTH),
		.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
		.VECTOR_LANES(VECTOR_LANES),
		.NUM_STAGES(3)
	) vfpu_inst(
		.clk(clk),
		.en(op_sel_ex1[1]),
		.vec_a(operand_a),
		.vec_b(operand_b),
		.vec_c(operand_c),
		.rnd(3'b000),
		.opcode(opcode_ex1),
		.funct(funct3_ex1),
		.vec_out(vfu_out_ex4)
	);
	dot_product_unit #(
		.SIG_WIDTH(SIG_WIDTH),
		.EXP_WIDTH(EXP_WIDTH),
		.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
		.VECTOR_LANES(9),
		.NUM_STAGES(4)
	) dp_unit_inst(
		.clk(clk),
		.en(op_sel_ex1[2]),
		.vec_a(operand_a[0+:DATA_WIDTH * 9]),
		.vec_b(operand_b[0+:DATA_WIDTH * 9]),
		.vec_c(operand_c[0+:DATA_WIDTH * 9]),
		.rnd(3'b000),
		.funct(funct3_ex1),
		.vec_out(mat_out_wb)
	);
	DW_lp_fp_multifunc_DG_inst_pipe #(
		.SIG_WIDTH(SIG_WIDTH),
		.EXP_WIDTH(EXP_WIDTH),
		.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
		.NUM_STAGES(3)
	) mfu_inst(
		.inst_clk(clk),
		.inst_a(operand_a[0+:DATA_WIDTH]),
		.inst_func(funct3_ex1),
		.inst_rnd(3'b000),
		.inst_DG_ctrl(op_sel_ex1[2]),
		.z_inst(mfu_out_ex4),
		.status_inst(status_inst)
	);
	assign mem_addr = mem_addr_ex1;
	assign mem_we = mem_we_ex1;
	assign mem_ren = op_sel_ex1[3];
	assign mem_wdata = operand_c;
	assign width = funct3_ex1;
	always @(*)
		case (op_sel_wb)
			4'b0001: reg_wdata_wb = mfu_out_wb;
			4'b0010: reg_wdata_wb = vfu_out_wb;
			4'b0100: reg_wdata_wb = mat_out_wb;
			4'b1000: reg_wdata_wb = mem_rdata_wb;
			default: reg_wdata_wb = vec_out_wb;
		endcase
	always @(posedge clk)
		if (~rst_n) begin
			vs1_addr_ex1 <= 1'sb0;
			vs2_addr_ex1 <= 1'sb0;
			vs3_addr_ex1 <= 1'sb0;
			opcode_ex1 <= 1'sb0;
			funct3_ex1 <= 1'sb0;
			vs1_data_ex1 <= 1'sb0;
			vs2_data_ex1 <= 1'sb0;
			vs3_data_ex1 <= 1'sb0;
			vd_addr_ex1 <= 1'sb0;
			vd_addr_ex2 <= 1'sb0;
			vd_addr_ex3 <= 1'sb0;
			vd_addr_ex4 <= 1'sb0;
			vd_addr_wb <= 1'sb0;
			op_sel_ex1 <= 1'sb0;
			op_sel_ex2 <= 1'sb0;
			op_sel_ex3 <= 1'sb0;
			op_sel_ex4 <= 1'sb0;
			op_sel_wb <= 1'sb0;
			vec_out_ex3 <= 1'sb0;
			vec_out_ex4 <= 1'sb0;
			vec_out_wb <= 1'sb0;
			vfu_out_wb <= 1'sb0;
			mfu_out_wb <= 1'sb0;
			reg_we_ex1 <= 1'sb0;
			reg_we_ex2 <= 1'sb0;
			reg_we_ex3 <= 1'sb0;
			reg_we_ex4 <= 1'sb0;
			reg_we_wb <= 1'sb0;
			mem_addr_ex1 <= 1'sb0;
			mem_we_ex1 <= 1'sb0;
			mem_rdata_ex3 <= 1'sb0;
			mem_rdata_ex4 <= 1'sb0;
			mem_rdata_wb <= 1'sb0;
		end
		else if (en && (en_q || (pc != 0))) begin
			vs1_addr_ex1 <= vs1_addr_id;
			vs2_addr_ex1 <= vs2_addr_id;
			vs3_addr_ex1 <= vs3_addr_id;
			opcode_ex1 <= opcode_id;
			funct3_ex1 <= funct3_id;
			vs1_data_ex1 <= vs1_data_id;
			vs2_data_ex1 <= vs2_data_id;
			vs3_data_ex1 <= vs3_data_id;
			vd_addr_ex1 <= vd_addr_id;
			vd_addr_ex2 <= vd_addr_ex1;
			vd_addr_ex3 <= vd_addr_ex2;
			vd_addr_ex4 <= vd_addr_ex3;
			vd_addr_wb <= vd_addr_ex4;
			op_sel_ex1 <= (~stall ? op_sel_id : {4 {1'sb0}});
			op_sel_ex2 <= op_sel_ex1;
			op_sel_ex3 <= op_sel_ex2;
			op_sel_ex4 <= op_sel_ex3;
			op_sel_wb <= op_sel_ex4;
			vec_out_ex3 <= vec_out_ex2;
			vec_out_ex4 <= vec_out_ex3;
			vec_out_wb <= vec_out_ex4;
			vfu_out_wb <= vfu_out_ex4;
			mfu_out_wb <= mfu_out_ex4;
			reg_we_ex1 <= reg_we_id && ~stall;
			reg_we_ex2 <= reg_we_ex1;
			reg_we_ex3 <= reg_we_ex2;
			reg_we_ex4 <= reg_we_ex3;
			reg_we_wb <= reg_we_ex4;
			mem_addr_ex1 <= mem_addr_id;
			mem_we_ex1 <= mem_we_id && ~stall;
			mem_rdata_ex3 <= mem_rdata;
			mem_rdata_ex4 <= mem_rdata_ex3;
			mem_rdata_wb <= mem_rdata_ex4;
		end
endmodule
module ram_sync_1rw1r (
	clk,
	csb0,
	web0,
	wmask0,
	addr0,
	din0,
	dout0,
	csb1,
	addr1,
	dout1
);
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 8;
	parameter DEPTH = 256;
	parameter DELAY = 0;
	input wire clk;
	input wire csb0;
	input wire web0;
	input wire [(DATA_WIDTH / 32) - 1:0] wmask0;
	input wire [ADDR_WIDTH - 1:0] addr0;
	input wire [DATA_WIDTH - 1:0] din0;
	output wire [DATA_WIDTH - 1:0] dout0;
	input wire csb1;
	input wire [ADDR_WIDTH - 1:0] addr1;
	output wire [DATA_WIDTH - 1:0] dout1;
	genvar i;
	genvar j;
	generate
		if (DEPTH > 256) begin : genblk1
			wire [DATA_WIDTH - 1:0] dout0_w [(DEPTH / 256) - 1:0];
			wire [DATA_WIDTH - 1:0] dout1_w [(DEPTH / 256) - 1:0];
			reg [ADDR_WIDTH - 1:0] addr0_r;
			reg [ADDR_WIDTH - 1:0] addr1_r;
			always @(posedge clk) begin
				addr0_r <= addr0;
				addr1_r <= addr1;
			end
			for (i = 0; i < (DEPTH / 256); i = i + 1) begin : depth_macro
				for (j = 0; j < (DATA_WIDTH / 32); j = j + 1) begin : width_macro
					sky130_sram_1kbyte_1rw1r_32x256_8 #(
						.DELAY(0),
						.VERBOSE(0),
						.T_HOLD(0)
					) sram_macro(
						.clk0(clk),
						.csb0(~(csb0 && (addr0[ADDR_WIDTH - 1:8] == i))),
						.web0(~web0 && wmask0[j]),
						.wmask0(4'hf),
						.addr0(addr0[7:0]),
						.din0(din0[j * 32+:32]),
						.dout0(dout0_w[i][j * 32+:32]),
						.clk1(clk),
						.csb1(~(csb1 && (addr1[ADDR_WIDTH - 1:8] == i))),
						.addr1(addr1[7:0]),
						.dout1(dout1_w[i][j * 32+:32])
					);
				end
			end
			assign dout0 = dout0_w[addr0_r[ADDR_WIDTH - 1:8]];
			assign dout1 = dout1_w[addr1_r[ADDR_WIDTH - 1:8]];
		end
		else if (DEPTH == 256) begin : genblk1
			for (i = 0; i < (DATA_WIDTH / 32); i = i + 1) begin : width_macro
				sky130_sram_1kbyte_1rw1r_32x256_8 #(
					.DELAY(0),
					.VERBOSE(0),
					.T_HOLD(0)
				) sram_macro(
					.clk0(clk),
					.csb0(~csb0),
					.web0(~web0 && wmask0[i]),
					.wmask0(4'hf),
					.addr0(addr0),
					.din0(din0[32 * i+:32]),
					.dout0(dout0[32 * i+:32]),
					.clk1(clk),
					.csb1(~csb1),
					.addr1(addr1),
					.dout1(dout1[32 * i+:32])
				);
			end
		end
	endgenerate
endmodule
module regfile (
	clk,
	rst_n,
	wen,
	addr_w,
	data_w,
	addr_r1,
	data_r1,
	addr_r2,
	data_r2,
	addr_r3,
	data_r3
);
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 5;
	parameter DEPTH = 32;
	input wire clk;
	input wire rst_n;
	input wire wen;
	input wire [ADDR_WIDTH - 1:0] addr_w;
	input wire [DATA_WIDTH - 1:0] data_w;
	input wire [ADDR_WIDTH - 1:0] addr_r1;
	output wire [DATA_WIDTH - 1:0] data_r1;
	input wire [ADDR_WIDTH - 1:0] addr_r2;
	output wire [DATA_WIDTH - 1:0] data_r2;
	input wire [ADDR_WIDTH - 1:0] addr_r3;
	output wire [DATA_WIDTH - 1:0] data_r3;
	reg [(DEPTH * DATA_WIDTH) - 1:0] regs;
	assign data_r1 = (addr_r1 == 0 ? 0 : (wen & (addr_w == addr_r1) ? data_w : regs[addr_r1 * DATA_WIDTH+:DATA_WIDTH]));
	assign data_r2 = (addr_r2 == 0 ? 0 : (wen & (addr_w == addr_r2) ? data_w : regs[addr_r2 * DATA_WIDTH+:DATA_WIDTH]));
	assign data_r3 = (addr_r3 == 0 ? 0 : (wen & (addr_w == addr_r3) ? data_w : regs[addr_r3 * DATA_WIDTH+:DATA_WIDTH]));
	always @(posedge clk)
		if (~rst_n)
			regs <= 1'sb0;
		else if (wen)
			regs[addr_w * DATA_WIDTH+:DATA_WIDTH] <= data_w;
endmodule
module square_PE_LU (
	clk,
	rst_n,
	vld,
	en,
	i,
	j,
	ain,
	uin,
	aout,
	uout,
	l
);
	parameter DWIDTH = 32;
	input wire clk;
	input wire rst_n;
	input wire vld;
	input wire en;
	input wire [2:0] i;
	input wire [2:0] j;
	input wire [DWIDTH - 1:0] ain;
	input wire [DWIDTH - 1:0] uin;
	output wire [DWIDTH - 1:0] aout;
	output wire [DWIDTH - 1:0] uout;
	output wire [DWIDTH - 1:0] l;
	reg [DWIDTH - 1:0] l_r;
	reg [DWIDTH - 1:0] u_r;
	reg [DWIDTH - 1:0] a_r;
	wire [DWIDTH - 1:0] mac_z0;
	wire [DWIDTH - 1:0] div_z0;
	reg [3:0] cnt;
	always @(posedge clk)
		if (~rst_n || ~vld)
			cnt <= 'h0;
		else if (en)
			cnt <= cnt + 1'b1;
	always @(posedge clk)
		if (~rst_n || ~vld) begin
			a_r <= 'h0;
			u_r <= 'h0;
			l_r <= 'h0;
		end
		else if (en) begin
			u_r <= uin;
			if (cnt == (i + (2 * (j - 1))))
				l_r <= div_z0;
			else
				a_r <= mac_z0;
		end
	assign aout = a_r;
	assign uout = u_r;
	assign l = l_r;
	DW_fp_mac_DG mac_U0(
		.a({~l_r[DWIDTH - 1], l_r[DWIDTH - 2:0]}),
		.b(uin),
		.c(ain),
		.rnd(3'h0),
		.DG_ctrl(en),
		.z(mac_z0),
		.status()
	);
	DW_fp_div_DG div_U0(
		.a(ain),
		.b(uin),
		.rnd(3'h0),
		.DG_ctrl(en),
		.z(div_z0),
		.status()
	);
endmodule
module square_PE_Tri (
	clk,
	rst_n,
	en,
	xin,
	sqr_x,
	zin,
	xout,
	zout
);
	parameter DWIDTH = 32;
	input wire clk;
	input wire rst_n;
	input wire en;
	input wire [DWIDTH - 1:0] xin;
	input wire [DWIDTH - 1:0] sqr_x;
	input wire [DWIDTH - 1:0] zin;
	output wire [DWIDTH - 1:0] xout;
	output wire [DWIDTH - 1:0] zout;
	reg [DWIDTH - 1:0] zout_r;
	reg [DWIDTH - 1:0] xout_r;
	wire [DWIDTH - 1:0] mac_z0;
	always @(posedge clk)
		if (~rst_n) begin
			zout_r <= 'h0;
			xout_r <= 'h0;
		end
		else if (en) begin
			zout_r <= zin;
			xout_r <= mac_z0;
		end
	assign xout = xout_r;
	assign zout = zout_r;
	DW_fp_mac_DG mac_U0(
		.a({~zin[DWIDTH - 1], zin[DWIDTH - 2:0]}),
		.b(sqr_x),
		.c(xin),
		.rnd(3'h0),
		.DG_ctrl(en),
		.z(mac_z0),
		.status()
	);
endmodule
module vector_slide (
	inst_a,
	inst_b,
	shift,
	z_inst
);
	parameter DATA_WIDTH = 32;
	parameter VECTOR_LANES = 16;
	parameter WIDTH = $clog2(VECTOR_LANES);
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] inst_a;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] inst_b;
	input wire [WIDTH - 1:0] shift;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] z_inst;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide8up;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide4up;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide2up;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide1up;
	wire [VECTOR_LANES - 1:0] mask1;
	wire [VECTOR_LANES - 1:0] mask2;
	wire [VECTOR_LANES - 1:0] mask3;
	wire [VECTOR_LANES - 1:0] mask4;
	assign slide8up = (shift[3] ? {inst_a[0+:DATA_WIDTH * 8], {8 {32'b00000000000000000000000000000000}}} : inst_a);
	assign slide4up = (shift[2] ? {slide8up[0+:DATA_WIDTH * 12], {4 {32'b00000000000000000000000000000000}}} : slide8up);
	assign slide2up = (shift[1] ? {slide4up[0+:DATA_WIDTH * 14], {2 {32'b00000000000000000000000000000000}}} : slide4up);
	assign slide1up = (shift[0] ? {slide2up[0+:DATA_WIDTH * 15], 32'b00000000000000000000000000000000} : slide1up);
	assign mask1 = (shift[3] ? 16'hff00 : 16'h0001);
	assign mask2 = (shift[2] ? {mask1[11:0], {4 {32'b00000000000000000000000000000000}}} : mask1);
	assign mask3 = (shift[1] ? {mask2[13:0], {2 {32'b00000000000000000000000000000000}}} : mask2);
	assign mask4 = (shift[0] ? {mask3[14:0], 32'b00000000000000000000000000000000} : mask3);
endmodule
module vector_unit (
	clk,
	en,
	vec_a,
	vec_b,
	opcode,
	funct,
	rnd,
	vec_out
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	parameter VECTOR_LANES = 16;
	parameter DATA_WIDTH = (SIG_WIDTH + EXP_WIDTH) + 1;
	input wire clk;
	input wire en;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_a;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_b;
	input wire [4:0] opcode;
	input wire [2:0] funct;
	input wire [2:0] rnd;
	output reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out;
	wire [(9 * DATA_WIDTH) - 1:0] vec_a_neg;
	wire [(9 * DATA_WIDTH) - 1:0] skew_symmetric;
	wire [(9 * DATA_WIDTH) - 1:0] transpose;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vpermute;
	genvar i;
	generate
		for (i = 0; i < 9; i = i + 1) begin : negate_inputs
			assign vec_a_neg[i * DATA_WIDTH+:DATA_WIDTH] = {~vec_a[(i * DATA_WIDTH) + (DATA_WIDTH - 1)], vec_a[(i * DATA_WIDTH) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 2 : ((DATA_WIDTH - 2) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)) - 1)-:((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)]};
		end
	endgenerate
	assign skew_symmetric[0+:DATA_WIDTH] = 32'b00000000000000000000000000000000;
	assign skew_symmetric[DATA_WIDTH+:DATA_WIDTH] = vec_a[2 * DATA_WIDTH+:DATA_WIDTH];
	assign skew_symmetric[2 * DATA_WIDTH+:DATA_WIDTH] = vec_a_neg[DATA_WIDTH+:DATA_WIDTH];
	assign skew_symmetric[3 * DATA_WIDTH+:DATA_WIDTH] = vec_a_neg[2 * DATA_WIDTH+:DATA_WIDTH];
	assign skew_symmetric[4 * DATA_WIDTH+:DATA_WIDTH] = 32'b00000000000000000000000000000000;
	assign skew_symmetric[5 * DATA_WIDTH+:DATA_WIDTH] = vec_a[0+:DATA_WIDTH];
	assign skew_symmetric[6 * DATA_WIDTH+:DATA_WIDTH] = vec_a[DATA_WIDTH+:DATA_WIDTH];
	assign skew_symmetric[7 * DATA_WIDTH+:DATA_WIDTH] = vec_a_neg[0+:DATA_WIDTH];
	assign skew_symmetric[8 * DATA_WIDTH+:DATA_WIDTH] = 32'b00000000000000000000000000000000;
	generate
		for (i = 0; i < 3; i = i + 1) begin : genblk2
			genvar j;
			for (j = 0; j < 3; j = j + 1) begin : genblk1
				assign transpose[((3 * i) + j) * DATA_WIDTH+:DATA_WIDTH] = vec_a[((3 * j) + i) * DATA_WIDTH+:DATA_WIDTH];
			end
		end
	endgenerate
	always @(*)
		case (funct)
			3'b000: vpermute = skew_symmetric;
			3'b001: vpermute = transpose;
			default: vpermute = 1'sb0;
		endcase
	generate
		for (i = 0; i < VECTOR_LANES; i = i + 1) begin : genblk3
			wire [DATA_WIDTH - 1:0] inst_a;
			wire [DATA_WIDTH - 1:0] inst_b;
			wire aeqb_inst;
			wire altb_inst;
			wire agtb_inst;
			wire unordered_inst;
			wire [DATA_WIDTH - 1:0] z0_inst;
			wire [DATA_WIDTH - 1:0] z1_inst;
			wire [7:0] status0_inst;
			wire [7:0] status1_inst;
			wire [DATA_WIDTH - 1:0] sgnj;
			wire [DATA_WIDTH - 1:0] sgnjn;
			wire [DATA_WIDTH - 1:0] sgnjx;
			assign inst_a = (funct == 3'b101 ? vec_a[0+:DATA_WIDTH] : vec_a[i * DATA_WIDTH+:DATA_WIDTH]);
			assign inst_b = vec_b[i * DATA_WIDTH+:DATA_WIDTH];
			DW_fp_cmp_DG #(
				.sig_width(SIG_WIDTH),
				.exp_width(EXP_WIDTH),
				.ieee_compliance(IEEE_COMPLIANCE)
			) DW_fp_cmp_DG_inst(
				.a(inst_a),
				.b(inst_b),
				.zctr(1'b0),
				.DG_ctrl(en),
				.aeqb(aeqb_inst),
				.altb(altb_inst),
				.agtb(agtb_inst),
				.unordered(unordered_inst),
				.z0(z0_inst),
				.z1(z1_inst),
				.status0(status0_inst),
				.status1(status1_inst)
			);
			assign sgnj = {inst_b[DATA_WIDTH - 1], inst_a[DATA_WIDTH - 2:0]};
			assign sgnjn = {~inst_b[DATA_WIDTH - 1], inst_a[DATA_WIDTH - 2:0]};
			assign sgnjx = {inst_a[DATA_WIDTH - 1] ^ inst_b[DATA_WIDTH - 1], inst_a[DATA_WIDTH - 2:0]};
			always @(posedge clk)
				case (opcode)
					5'b01000: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= z0_inst;
					5'b01001: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= z1_inst;
					5'b01101: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= aeqb_inst;
					5'b01110: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= altb_inst;
					5'b01111: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= aeqb_inst || altb_inst;
					5'b01010: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= sgnj;
					5'b01011: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= sgnjn;
					5'b01100: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= sgnjx;
					5'b10000: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= vpermute[i * DATA_WIDTH+:DATA_WIDTH];
					default: vec_out[i * DATA_WIDTH+:DATA_WIDTH] <= 1'sb0;
				endcase
		end
	endgenerate
endmodule
module vfpu (
	clk,
	en,
	vec_a,
	vec_b,
	vec_c,
	opcode,
	funct,
	rnd,
	vec_out
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	parameter VECTOR_LANES = 16;
	parameter NUM_STAGES = 3;
	parameter DATA_WIDTH = (SIG_WIDTH + EXP_WIDTH) + 1;
	input wire clk;
	input wire en;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_a;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_b;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_c;
	input wire [4:0] opcode;
	input wire [2:0] funct;
	input wire [2:0] rnd;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out;
	genvar i;
	generate
		for (i = 0; i < VECTOR_LANES; i = i + 1) begin : genblk1
			wire [DATA_WIDTH - 1:0] inst_a;
			reg [DATA_WIDTH - 1:0] inst_b;
			reg [DATA_WIDTH - 1:0] inst_c;
			wire [DATA_WIDTH - 1:0] z_inst;
			wire [7:0] status_inst;
			wire [DATA_WIDTH - 1:0] b_neg;
			wire [DATA_WIDTH - 1:0] c_neg;
			assign b_neg = {~vec_b[(i * DATA_WIDTH) + (DATA_WIDTH - 1)], vec_b[(i * DATA_WIDTH) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 2 : ((DATA_WIDTH - 2) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)) - 1)-:((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)]};
			assign c_neg = {~vec_c[(i * DATA_WIDTH) + (DATA_WIDTH - 1)], vec_c[(i * DATA_WIDTH) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 2 : ((DATA_WIDTH - 2) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)) - 1)-:((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)]};
			assign inst_a = (funct == 3'b101 ? vec_a[0+:DATA_WIDTH] : vec_a[i * DATA_WIDTH+:DATA_WIDTH]);
			always @(*) begin
				case (opcode)
					5'b00000, 5'b00001: inst_b = 32'h3f800000;
					5'b00110, 5'b00111: inst_b = b_neg;
					default: inst_b = vec_b[i * DATA_WIDTH+:DATA_WIDTH];
				endcase
				case (opcode)
					5'b00000: inst_c = vec_b[i * DATA_WIDTH+:DATA_WIDTH];
					5'b00001: inst_c = b_neg;
					5'b00010: inst_c = 32'b00000000000000000000000000000000;
					5'b00101, 5'b00110: inst_c = c_neg;
					default: inst_c = vec_c[i * DATA_WIDTH+:DATA_WIDTH];
				endcase
			end
			DW_fp_mac_DG_inst_pipe #(
				.SIG_WIDTH(SIG_WIDTH),
				.EXP_WIDTH(EXP_WIDTH),
				.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
				.NUM_STAGES(NUM_STAGES)
			) U1(
				.inst_clk(clk),
				.inst_a(inst_a),
				.inst_b(inst_b),
				.inst_c(inst_c),
				.inst_rnd(rnd),
				.inst_DG_ctrl(en),
				.z_inst(vec_out[i * DATA_WIDTH+:DATA_WIDTH]),
				.status_inst(status_inst)
			);
		end
	endgenerate
endmodule
module vrf (
	clk,
	rst_n,
	wen,
	addr_w,
	data_w,
	addr_r1,
	data_r1,
	addr_r2,
	data_r2,
	addr_r3,
	data_r3
);
	parameter DATA_WIDTH = 512;
	parameter ADDR_WIDTH = 5;
	parameter DEPTH = 32;
	input wire clk;
	input wire rst_n;
	input wire wen;
	input wire [ADDR_WIDTH - 1:0] addr_w;
	input wire [DATA_WIDTH - 1:0] data_w;
	input wire [ADDR_WIDTH - 1:0] addr_r1;
	output wire [DATA_WIDTH - 1:0] data_r1;
	input wire [ADDR_WIDTH - 1:0] addr_r2;
	output wire [DATA_WIDTH - 1:0] data_r2;
	input wire [ADDR_WIDTH - 1:0] addr_r3;
	output wire [DATA_WIDTH - 1:0] data_r3;
	reg [(DEPTH * DATA_WIDTH) - 1:0] vectors;
	assign data_r1 = (wen & (addr_w == addr_r1) ? data_w : vectors[addr_r1 * DATA_WIDTH+:DATA_WIDTH]);
	assign data_r2 = (wen & (addr_w == addr_r2) ? data_w : vectors[addr_r2 * DATA_WIDTH+:DATA_WIDTH]);
	assign data_r3 = (wen & (addr_w == addr_r3) ? data_w : vectors[addr_r3 * DATA_WIDTH+:DATA_WIDTH]);
	function automatic [DATA_WIDTH - 1:0] sv2v_cast_A78C9;
		input reg [DATA_WIDTH - 1:0] inp;
		sv2v_cast_A78C9 = inp;
	endfunction
	always @(posedge clk)
		if (~rst_n) begin
			vectors[0+:DATA_WIDTH] <= 1'sb0;
			vectors[DATA_WIDTH+:DATA_WIDTH] <= 1'sb0;
			vectors[2 * DATA_WIDTH+:DATA_WIDTH] <= 96'h3b6d800038a36038b8cbffed;
			vectors[3 * DATA_WIDTH+:DATA_WIDTH] <= 128'h350eca6ab80e4003b7ac04fe3f800000;
			vectors[4 * DATA_WIDTH+:DATA_WIDTH] <= 288'h3f8000000000000000000000000000003f8000000000000000000000000000003f800000;
			vectors[5 * DATA_WIDTH+:DATA_WIDTH] <= 1'sb0;
			vectors[6 * DATA_WIDTH+:DATA_WIDTH] <= 1'sb0;
			vectors[7 * DATA_WIDTH+:DATA_WIDTH] <= 1'sb0;
			vectors[8 * DATA_WIDTH+:DATA_WIDTH] <= 288'h3f8000000000000000000000000000003f8000000000000000000000000000003f800000;
			vectors[9 * DATA_WIDTH+:DATA_WIDTH] <= 1'sb0;
			vectors[10 * DATA_WIDTH+:DATA_WIDTH] <= 1'sb0;
			vectors[11 * DATA_WIDTH+:DATA_WIDTH] <= 1'sb0;
			vectors[12 * DATA_WIDTH+:DATA_WIDTH] <= 288'h3f8000000000000000000000000000003f8000000000000000000000000000003f800000;
			vectors[DATA_WIDTH * 13+:DATA_WIDTH * 3] <= {3 {sv2v_cast_A78C9(0)}};
			vectors[16 * DATA_WIDTH+:DATA_WIDTH] <= 32'h348637bd;
			vectors[17 * DATA_WIDTH+:DATA_WIDTH] <= 32'h3dcccccd;
			vectors[18 * DATA_WIDTH+:DATA_WIDTH] <= 32'h420c0000;
			vectors[19 * DATA_WIDTH+:DATA_WIDTH] <= 96'h411cf5c30000000000000000;
			vectors[20 * DATA_WIDTH+:DATA_WIDTH] <= 288'h3f8000000000000000000000000000003f8000000000000000000000000000003f800000;
			vectors[21 * DATA_WIDTH+:DATA_WIDTH] <= 32'h3ba3d70a;
			vectors[22 * DATA_WIDTH+:DATA_WIDTH] <= 32'h37d1b717;
			vectors[23 * DATA_WIDTH+:DATA_WIDTH] <= 32'h3751b717;
			vectors[DATA_WIDTH * 24+:DATA_WIDTH * 8] <= {8 {sv2v_cast_A78C9(0)}};
		end
		else if (wen)
			vectors[addr_w * DATA_WIDTH+:DATA_WIDTH] <= data_w;
endmodule
module SizedFIFO (
	CLK,
	RST,
	D_IN,
	ENQ,
	FULL_N,
	D_OUT,
	DEQ,
	EMPTY_N,
	CLR
);
	parameter p1width = 1;
	parameter p2depth = 3;
	parameter p3cntr_width = 1;
	parameter guarded = 1;
	localparam p2depth2 = (p2depth >= 2 ? p2depth - 2 : 0);
	input CLK;
	input RST;
	input CLR;
	input [p1width - 1:0] D_IN;
	input ENQ;
	input DEQ;
	output wire FULL_N;
	output wire EMPTY_N;
	output reg [p1width - 1:0] D_OUT;
	reg not_ring_full;
	reg ring_empty;
	reg [p3cntr_width - 1:0] head;
	wire [p3cntr_width - 1:0] next_head;
	reg [p3cntr_width - 1:0] tail;
	wire [p3cntr_width - 1:0] next_tail;
	reg [p1width - 1:0] arr [0:p2depth2];
	reg hasodata;
	wire [p3cntr_width - 1:0] depthLess2 = p2depth2[p3cntr_width - 1:0];
	wire [p3cntr_width - 1:0] incr_tail;
	wire [p3cntr_width - 1:0] incr_head;
	assign incr_tail = tail + 1'b1;
	assign incr_head = head + 1'b1;
	assign next_head = (head == depthLess2 ? {p3cntr_width {1'b0}} : incr_head);
	assign next_tail = (tail == depthLess2 ? {p3cntr_width {1'b0}} : incr_tail);
	assign EMPTY_N = hasodata;
	assign FULL_N = not_ring_full;
	initial begin : initial_block
		integer i;
		D_OUT = {(p1width + 1) / 2 {2'b10}};
		ring_empty = 1'b1;
		not_ring_full = 1'b1;
		hasodata = 1'b0;
		head = {p3cntr_width {1'b0}};
		tail = {p3cntr_width {1'b0}};
		for (i = 0; i <= p2depth2; i = i + 1)
			arr[i] = D_OUT;
	end
	always @(posedge CLK)
		if (RST == 1'b0) begin
			head <= {p3cntr_width {1'b0}};
			tail <= {p3cntr_width {1'b0}};
			ring_empty <= 1'b1;
			not_ring_full <= 1'b1;
			hasodata <= 1'b0;
		end
		else
			casez ({CLR, DEQ, ENQ, hasodata, ring_empty})
				5'b1zzzz: begin
					head <= {p3cntr_width {1'b0}};
					tail <= {p3cntr_width {1'b0}};
					ring_empty <= 1'b1;
					not_ring_full <= 1'b1;
					hasodata <= 1'b0;
				end
				5'b011z0: begin
					tail <= next_tail;
					head <= next_head;
				end
				5'b010z1: hasodata <= 1'b0;
				5'b010z0: begin
					head <= next_head;
					not_ring_full <= 1'b1;
					ring_empty <= next_head == tail;
				end
				5'b0010z: hasodata <= 1'b1;
				5'b0011z:
					if (not_ring_full) begin
						tail <= next_tail;
						ring_empty <= 1'b0;
						not_ring_full <= next_tail != head;
					end
			endcase
	always @(posedge CLK)
		casez ({CLR, DEQ, ENQ, hasodata, ring_empty})
			5'b011z0: D_OUT <= arr[head];
			5'b011z1: D_OUT <= D_IN;
			5'b010z0: D_OUT <= arr[head];
			5'b0010z: D_OUT <= D_IN;
		endcase
	always @(posedge CLK) begin : array
		if ((!CLR && ENQ) && ((DEQ && !ring_empty) || ((!DEQ && hasodata) && not_ring_full)))
			arr[tail] <= D_IN;
	end
	always @(posedge CLK) begin : error_checks
		reg deqerror;
		reg enqerror;
		deqerror = 0;
		enqerror = 0;
		if (RST == 1'd1) begin
			if (!EMPTY_N && DEQ) begin
				deqerror = 1;
				$display("Warning: SizedFIFO: %m -- Dequeuing from empty fifo");
			end
			if ((!FULL_N && ENQ) && (!DEQ || guarded)) begin
				enqerror = 1;
				$display("Warning: SizedFIFO: %m -- Enqueuing to a full fifo");
			end
		end
	end
	// initial begin : parameter_assertions
	// 	integer ok;
	// 	ok = 1;
	// 	if (p2depth <= 1) begin
	// 		ok = 0;
	// 		$display("Warning SizedFIFO: %m -- depth parameter increased from %0d to 2", p2depth);
	// 	end
	// 	if (p3cntr_width <= 0) begin
	// 		ok = 0;
	// 		$display("ERROR SizedFIFO: %m -- width parameter must be greater than 0");
	// 	end
	// 	if (ok == 0)
	// 		$finish;
	// end
endmodule
module aggregator (
	clk,
	rst_n,
	sender_data,
	sender_empty_n,
	sender_deq,
	receiver_data,
	receiver_full_n,
	receiver_enq
);
	parameter DATA_WIDTH = 16;
	parameter FETCH_WIDTH = 4;
	input clk;
	input rst_n;
	input [DATA_WIDTH - 1:0] sender_data;
	input sender_empty_n;
	output wire sender_deq;
	output wire [(FETCH_WIDTH * DATA_WIDTH) - 1:0] receiver_data;
	input receiver_full_n;
	output reg receiver_enq;
	localparam COUNTER_WIDTH = $clog2(FETCH_WIDTH);
	reg [COUNTER_WIDTH - 1:0] count_r;
	reg [DATA_WIDTH - 1:0] receiver_data_unpacked [FETCH_WIDTH - 1:0];
	wire sender_deq_w;
	assign sender_deq_w = (rst_n && sender_empty_n) && receiver_full_n;
	assign sender_deq = sender_deq_w;
	genvar i;
	generate
		for (i = 0; i < FETCH_WIDTH; i = i + 1) begin : unpack
			assign receiver_data[((i + 1) * DATA_WIDTH) - 1:i * DATA_WIDTH] = receiver_data_unpacked[i];
		end
	endgenerate
	always @(posedge clk)
		if (rst_n) begin
			if (sender_deq_w) begin
				receiver_data_unpacked[count_r] <= sender_data;
				count_r <= (count_r == (FETCH_WIDTH - 1) ? 0 : count_r + 1);
				receiver_enq <= count_r == (FETCH_WIDTH - 1);
			end
			else
				receiver_enq <= 0;
		end
		else begin
			receiver_enq <= 0;
			count_r <= 0;
		end
endmodule
module deaggregator (
	clk,
	rst_n,
	sender_data,
	sender_empty_n,
	sender_deq,
	receiver_data,
	receiver_full_n,
	receiver_enq
);
	parameter DATA_WIDTH = 16;
	parameter FETCH_WIDTH = 4;
	input clk;
	input rst_n;
	input [(FETCH_WIDTH * DATA_WIDTH) - 1:0] sender_data;
	input sender_empty_n;
	output wire sender_deq;
	output wire [DATA_WIDTH - 1:0] receiver_data;
	input receiver_full_n;
	output wire receiver_enq;
	localparam COUNTER_WIDTH = $clog2(FETCH_WIDTH);
	reg [COUNTER_WIDTH - 1:0] select_r;
	wire [DATA_WIDTH - 1:0] fifo_dout [FETCH_WIDTH - 1:0];
	wire fifo_empty_n [FETCH_WIDTH - 1:0];
	wire fifo_deq [FETCH_WIDTH - 1:0];
	reg sender_deq_r;
	wire fifo_full_n [FETCH_WIDTH - 1:0];
	reg [1:0] fifo_elements_r;
	genvar i;
	generate
		for (i = 0; i < FETCH_WIDTH; i = i + 1) begin : instantiate_fifos
			fifo #(
				.DATA_WIDTH(DATA_WIDTH),
				.FIFO_DEPTH(3),
				.COUNTER_WIDTH(1)
			) fifo_inst(
				.clk(clk),
				.rst_n(rst_n),
				.din(sender_data[((i + 1) * DATA_WIDTH) - 1:i * DATA_WIDTH]),
				.enq(sender_deq_r),
				.full_n(fifo_full_n[i]),
				.dout(fifo_dout[i]),
				.deq(fifo_deq[i]),
				.empty_n(fifo_empty_n[i]),
				.clr(1'b0)
			);
			assign fifo_deq[i] = (select_r == i ? (rst_n && receiver_full_n) && fifo_empty_n[i] : 0);
		end
	endgenerate
	assign receiver_data = fifo_dout[select_r];
	assign receiver_enq = (rst_n && receiver_full_n) && fifo_empty_n[select_r];
	always @(posedge clk)
		if (rst_n) begin
			if (receiver_enq)
				select_r <= select_r + 1;
		end
		else
			select_r <= 0;
	always @(posedge clk)
		if (rst_n) begin
			if (sender_deq && !fifo_deq[FETCH_WIDTH - 1])
				fifo_elements_r <= fifo_elements_r + 1;
			else if (!sender_deq && fifo_deq[FETCH_WIDTH - 1])
				fifo_elements_r <= fifo_elements_r - 1;
		end
		else
			fifo_elements_r <= 0;
	assign sender_deq = sender_empty_n && (fifo_elements_r < 3);
	always @(posedge clk)
		if (rst_n)
			sender_deq_r <= sender_deq;
		else
			sender_deq_r <= 0;
endmodule
module fifo (
	clk,
	rst_n,
	din,
	enq,
	full_n,
	dout,
	deq,
	empty_n,
	clr
);
	parameter DATA_WIDTH = 16;
	parameter FIFO_DEPTH = 3;
	parameter COUNTER_WIDTH = 1;
	input clk;
	input rst_n;
	input [DATA_WIDTH - 1:0] din;
	input enq;
	output wire full_n;
	output wire [DATA_WIDTH - 1:0] dout;
	input deq;
	output wire empty_n;
	input clr;
	SizedFIFO #(
		.p1width(DATA_WIDTH),
		.p2depth(FIFO_DEPTH),
		.p3cntr_width(COUNTER_WIDTH)
	) fifo_inst(
		.CLK(clk),
		.RST(rst_n),
		.D_IN(din),
		.ENQ(enq),
		.FULL_N(full_n),
		.D_OUT(dout),
		.DEQ(deq),
		.EMPTY_N(empty_n),
		.CLR(clr)
	);
endmodule
`default_nettype none
module user_proj_example #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wire wb_clk_i,
    input wire wb_rst_i,
    input wire wbs_stb_i,
    input wire wbs_cyc_i,
    input wire wbs_we_i,
    input wire [3:0] wbs_sel_i,
    input wire [31:0] wbs_dat_i,
    input wire [31:0] wbs_adr_i,
    output wire wbs_ack_o,
    output wire [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  wire [127:0] la_data_in,
    output wire [127:0] la_data_out,
    input  wire [127:0] la_oenb,

    // IOs
    input  wire [`MPRJ_IO_PADS-1:0] io_in,
    output wire [`MPRJ_IO_PADS-1:0] io_out,
    output wire [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout wire [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input wire user_clock2,

    // User maskable interrupt signals
    output wire [2:0] user_irq
);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/
  wire clk;
  wire rst_n;
  wire input_vld_w;
  wire output_rdy_w;
  wire [15 : 0] input_data_w;

  wire output_vld_w;
  wire input_rdy_w;
  wire [7 : 0] output_data_w;


  accelerator accelerator_inst
  (
    `ifdef USE_POWER_PINS
       .VDD(VDD),	// User area 1 1.8V power
       .VSS(VSS),	// User area 1 digital ground
     `endif
    .clk(clk),
    .rst_n(rst_n),

    .input_data(input_data_w),
    .input_vld(input_vld_w),
    .output_rdy(output_rdy_w),

    .output_data(output_data_w),
    .output_vld(output_vld_w),
    .input_rdy(input_rdy_w)
  );
    
    // assign io inputs to top level
    assign clk = io_in[19];
    assign rst_n = io_in[0];
	assign input_data_w[0:15] = io_in[1:16];
    // for (genvar i = 0; i < 16; i = i + 1) begin
    //     assign input_data_w[i] = io_in[i + 1];
    // end
    assign input_vld_w = io_in[17];
    assign output_rdy_w = io_in[18];
    
    // assign io outputs to top level
	assign io_out[20:27]=output_data_w[0:7];
    // for (genvar i = 20; i < 28; i = i + 1) begin
    //     assign io_out[i] = output_data_w[i];
    // end
    assign io_out[28] = output_vld_w;
    assign io_out[29] = input_rdy_w;

    // set unused output ports to zeros
    assign wbs_ack_o = 0;
    assign wbs_dat_o = 32'd0;
    assign la_data_out = 128'd0;
    assign io_out[`MPRJ_IO_PADS - 1 : 30] = 8'd0;
    assign io_out[19 : 0] = 20'd0;
    assign io_oeb = {20'b1, 18'b0};
    assign user_irq = 3'd0;

endmodule

`default_nettype wire