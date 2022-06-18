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
		z_inst_pipe1 <= (status_inst_internal[2] ? 0 : z_inst_internal);
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
	output_vld,
	wbs_debug,
	wbs_fsm_start,
	wbs_fsm_done,
	wbs_mem_we,
	wbs_mem_ren,
	wbs_mem_addr,
	wbs_mem_wdata,
	wbs_mem_rdata
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
	input wire wbs_debug;
	input wire wbs_fsm_start;
	output wire wbs_fsm_done;
	input wire wbs_mem_we;
	input wire wbs_mem_ren;
	input wire [11:0] wbs_mem_addr;
	input wire [31:0] wbs_mem_wdata;
	output wire [31:0] wbs_mem_rdata;
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
	wire mvp_mem_we;
	wire mvp_mem_ren;
	wire [11:0] mvp_mem_addr;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mvp_mem_wdata;
	wire [2:0] width;
	reg instr_mem_csb;
	reg instr_mem_web;
	reg [INSTR_MEM_ADDR_WIDTH - 1:0] instr_mem_addr;
	reg [DATA_WIDTH - 1:0] instr_mem_wdata;
	wire [DATA_WIDTH - 1:0] instr_mem_rdata;
	wire [INSTR_MEM_ADDR_WIDTH - 1:0] pc;
	wire [31:0] instr;
	reg data_mem_csb;
	reg data_mem_web;
	reg [(DATAPATH / 32) - 1:0] data_mem_wmask;
	reg [DATA_MEM_ADDR_WIDTH - 1:0] data_mem_addr;
	reg [DATAPATH - 1:0] data_mem_wdata;
	wire [DATAPATH - 1:0] data_mem_rdata;
	wire [DATAPATH - 1:0] output_wb_data;
	reg mem_ctrl_we;
	reg mem_ctrl_ren;
	reg [11:0] mem_ctrl_addr;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_ctrl_wdata;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_ctrl_rdata;
	reg [2:0] mem_ctrl_width;
	wire instr_mem_ctrl_csb;
	wire instr_mem_ctrl_web;
	wire [INSTR_MEM_ADDR_WIDTH - 1:0] instr_mem_ctrl_addr;
	wire [DATA_WIDTH - 1:0] instr_mem_ctrl_wdata;
	wire data_mem_ctrl_csb;
	wire data_mem_ctrl_web;
	wire [(DATAPATH / 32) - 1:0] data_mem_ctrl_wmask;
	wire [DATA_MEM_ADDR_WIDTH - 1:0] data_mem_ctrl_addr;
	wire [DATAPATH - 1:0] data_mem_ctrl_wdata;
	wire mat_inv_vld_out;
	wire [(9 * DATA_WIDTH) - 1:0] mat_inv_out_l;
	wire [(9 * DATA_WIDTH) - 1:0] mat_inv_out_u;
	wire [31:0] instr_aggregator_dout;
	wire [DATAPATH - 1:0] input_aggregator_dout;
	mvp_core #(
		.SIG_WIDTH(SIG_WIDTH),
		.EXP_WIDTH(EXP_WIDTH),
		.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
		.VECTOR_LANES(VECTOR_LANES),
		.INSTR_MEM_ADDR_WIDTH(INSTR_MEM_ADDR_WIDTH)
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
		.mem_rdata(mem_ctrl_rdata),
		.width(width)
	);
	mat_inv #(.DATA_WIDTH(DATA_WIDTH)) mat_inv_inst(
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
		.csb0(instr_mem_csb),
		.web0(instr_mem_web),
		.addr0(instr_mem_addr),
		.wmask0(1'b1),
		.din0(instr_mem_wdata),
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
		.csb0(data_mem_csb),
		.web0(data_mem_web),
		.addr0(data_mem_addr),
		.wmask0(data_mem_wmask),
		.din0(data_mem_wdata),
		.dout0(data_mem_rdata),
		.csb1(output_wb_ren),
		.addr1(output_wb_radr),
		.dout1(output_wb_data)
	);
	always @(*) begin
		if (instr_wen) begin
			instr_mem_csb = instr_wen;
			instr_mem_web = 1'b1;
			instr_mem_addr = instr_wadr;
			instr_mem_wdata = instr_aggregator_dout;
		end
		else begin
			instr_mem_csb = instr_mem_ctrl_csb;
			instr_mem_web = instr_mem_ctrl_web;
			instr_mem_addr = instr_mem_ctrl_addr;
			instr_mem_wdata = instr_mem_ctrl_wdata;
		end
		if (input_wen) begin
			data_mem_csb = input_wen;
			data_mem_web = 1'b1;
			data_mem_addr = input_wadr;
			data_mem_wmask = 8'hff;
			data_mem_wdata = input_aggregator_dout;
		end
		else begin
			data_mem_csb = data_mem_ctrl_csb;
			data_mem_web = data_mem_ctrl_web;
			data_mem_addr = data_mem_ctrl_addr;
			data_mem_wmask = data_mem_ctrl_wmask;
			data_mem_wdata = data_mem_ctrl_wdata;
		end
		if (wbs_debug && ~mvp_core_en) begin
			mem_ctrl_we = wbs_mem_we;
			mem_ctrl_ren = wbs_mem_ren;
			mem_ctrl_addr = wbs_mem_addr;
			mem_ctrl_wdata = wbs_mem_wdata;
			mem_ctrl_width = 3'b010;
		end
		else begin
			mem_ctrl_we = mvp_mem_we;
			mem_ctrl_ren = mvp_mem_ren;
			mem_ctrl_addr = mvp_mem_addr;
			mem_ctrl_wdata = mvp_mem_wdata;
			mem_ctrl_width = width;
		end
	end
	memory_controller #(
		.ADDR_WIDTH(ADDR_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.VECTOR_LANES(VECTOR_LANES),
		.DATAPATH(DATAPATH),
		.INSTR_MEM_ADDR_WIDTH(INSTR_MEM_ADDR_WIDTH),
		.DATA_MEM_ADDR_WIDTH(DATA_MEM_ADDR_WIDTH)
	) mem_ctrl_inst(
		.clk(clk),
		.mem_we(mem_ctrl_we),
		.mem_ren(mem_ctrl_ren),
		.mem_addr(mem_ctrl_addr),
		.mem_wdata(mem_ctrl_wdata),
		.mem_rdata(mem_ctrl_rdata),
		.width(mem_ctrl_width),
		.instr_mem_csb(instr_mem_ctrl_csb),
		.instr_mem_web(instr_mem_ctrl_web),
		.instr_mem_addr(instr_mem_ctrl_addr),
		.instr_mem_wdata(instr_mem_ctrl_wdata),
		.instr_mem_rdata(instr_mem_rdata),
		.data_mem_csb(data_mem_ctrl_csb),
		.data_mem_web(data_mem_ctrl_web),
		.data_mem_addr(data_mem_ctrl_addr),
		.data_mem_wmask(data_mem_ctrl_wmask),
		.data_mem_wdata(data_mem_ctrl_wdata),
		.data_mem_rdata(data_mem_rdata),
		.mat_inv_out_l(mat_inv_out_l),
		.mat_inv_out_u(mat_inv_out_u)
	);
	assign wbs_mem_rdata = mem_ctrl_rdata;
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
		.wbs_debug(wbs_debug),
		.wbs_fsm_start(wbs_fsm_start),
		.wbs_fsm_done(wbs_fsm_done),
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
module alu (
	inst_a,
	inst_b,
	opcode,
	z_inst
);
	input wire [31:0] inst_a;
	input wire [31:0] inst_b;
	input wire [3:0] opcode;
	output reg [31:0] z_inst;
	wire signed [31:0] inst_a_signed = inst_a;
	wire signed [31:0] inst_b_signed = inst_b;
	always @(*)
		case (opcode)
			4'b0000: z_inst = inst_a + inst_b;
			4'b0001: z_inst = inst_a - inst_b;
			4'b0010: z_inst = inst_a_signed < inst_b_signed;
			4'b0011: z_inst = inst_a < inst_b;
			4'b0100: z_inst = inst_a & inst_b;
			4'b0101: z_inst = inst_a | inst_b;
			4'b0110: z_inst = inst_a ^ inst_b;
			4'b0111: z_inst = inst_b << inst_a[4:0];
			4'b1000: z_inst = inst_b >> inst_a[4:0];
			4'b1001: z_inst = inst_b_signed >>> inst_a[4:0];
			4'b1010: z_inst = inst_a * inst_b;
			default: z_inst = 32'b00000000000000000000000000000000;
		endcase
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
module clock_mux (
	clk,
	clk_select,
	clk_out
);
	parameter num_clocks = 4;
	input [num_clocks - 1:0] clk;
	input [num_clocks - 1:0] clk_select;
	output wire clk_out;
	genvar i;
	reg [num_clocks - 1:0] ena_r0;
	reg [num_clocks - 1:0] ena_r1;
	reg [num_clocks - 1:0] ena_r2;
	wire [num_clocks - 1:0] qualified_sel;
	wire [num_clocks - 1:0] gated_clks;
	initial begin
		ena_r0 = 0;
		ena_r1 = 0;
		ena_r2 = 0;
	end
	generate
		for (i = 0; i < num_clocks; i = i + 1) begin : lp0
			wire [num_clocks - 1:0] tmp_mask;
			assign tmp_mask = {num_clocks {1'b1}} ^ (1 << i);
			assign qualified_sel[i] = clk_select[i] & ~|(ena_r2 & tmp_mask);
			always @(posedge clk[i]) begin
				ena_r0[i] <= qualified_sel[i];
				ena_r1[i] <= ena_r0[i];
			end
			always @(negedge clk[i]) ena_r2[i] <= ena_r1[i];
			assign gated_clks[i] = clk[i] & ena_r2[i];
		end
	endgenerate
	assign clk_out = |gated_clks;
endmodule
module controller (
	clk,
	rst_n,
	wbs_debug,
	wbs_fsm_start,
	wbs_fsm_done,
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
	input wire wbs_debug;
	input wire wbs_fsm_start;
	output wire wbs_fsm_done;
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
	assign instr_wadr = instr_wadr_r;
	assign input_wadr = input_wadr_r[3+:DATA_MEM_ADDR_WIDTH];
	assign output_wb_radr = output_wbadr_r[3+:DATA_MEM_ADDR_WIDTH];
	assign params_fifo_deq = (state_r == 0) && params_fifo_empty_n;
	assign instr_full_n = (state_r == 1) && (instr_wadr_r <= instr_max_wadr_c);
	assign input_full_n = (state_r == 3) && (input_wadr_r <= (input_wadr_offset + input_max_wadr_c));
	assign output_empty_n = (state_r == 3) && (output_wbadr_r <= (output_radr_offset + output_max_adr_c));
	assign mat_inv_vld = mat_inv_en && ~mat_inv_en_r;
	assign wbs_fsm_done = state_r == 3;
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
				if (wbs_debug && wbs_fsm_start) begin
					state_r <= 2;
					mvp_core_en <= 1;
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
				else if (mat_inv_en_r && mat_inv_vld_out) begin
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
				if (wbs_debug && wbs_fsm_start) begin
					state_r <= 2;
					mvp_core_en <= 1;
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
	vd_addr,
	vs1_addr,
	vs2_addr,
	vs3_addr,
	func_sel,
	funct3,
	wb_sel,
	masking,
	reg_we,
	jump,
	branch,
	mem_we,
	mem_addr,
	vd_addr_ex1,
	vd_addr_ex2,
	vd_addr_ex3,
	reg_we_ex1,
	reg_we_ex2,
	reg_we_ex3,
	wb_sel_ex1,
	wb_sel_ex2,
	wb_sel_ex3,
	stall
);
	input wire [31:0] instr;
	output wire [4:0] vd_addr;
	output wire [4:0] vs1_addr;
	output wire [4:0] vs2_addr;
	output wire [4:0] vs3_addr;
	output reg [4:0] func_sel;
	output wire [2:0] funct3;
	output reg [4:0] wb_sel;
	output wire masking;
	output wire reg_we;
	output wire jump;
	output wire branch;
	output wire mem_we;
	output wire [11:0] mem_addr;
	input wire [4:0] vd_addr_ex1;
	input wire [4:0] vd_addr_ex2;
	input wire [4:0] vd_addr_ex3;
	input wire reg_we_ex1;
	input wire reg_we_ex2;
	input wire reg_we_ex3;
	input wire [4:0] wb_sel_ex1;
	input wire [4:0] wb_sel_ex2;
	input wire [4:0] wb_sel_ex3;
	output wire stall;
	wire [6:0] opcode;
	wire [4:0] dest;
	wire [4:0] src1;
	wire [4:0] src2;
	wire [5:0] funct6;
	wire [11:0] branch_offset;
	assign opcode = instr[6:0];
	assign dest = instr[11:7];
	assign funct3 = instr[14:12];
	assign src1 = instr[19:15];
	assign src2 = instr[24:20];
	assign masking = instr[25];
	assign funct6 = instr[31:26];
	assign branch_offset = {instr[31:25], instr[11:7]};
	wire overwrite_multiplicand;
	assign overwrite_multiplicand = (((opcode == 6'b101100) || (opcode == 6'b101110)) || (opcode == 6'b101101)) || (opcode == 6'b101111);
	assign vs1_addr = src1;
	assign vs2_addr = (overwrite_multiplicand ? dest : src2);
	assign vs3_addr = (opcode == 7'b0001011 ? instr[31:27] : (overwrite_multiplicand ? src2 : dest));
	assign vd_addr = dest;
	always @(*) begin
		case ({opcode, funct6})
			13'b1010111000000: func_sel = 5'b00000;
			13'b1010111000010: func_sel = 5'b00001;
			13'b1010111000100: func_sel = 5'b01000;
			13'b1010111000110: func_sel = 5'b01001;
			13'b1010111001000: func_sel = 5'b01010;
			13'b1010111001001: func_sel = 5'b01011;
			13'b1010111001010: func_sel = 5'b01100;
			13'b1010111001010: func_sel = 5'b01100;
			13'b1010111001110: func_sel = 5'b10011;
			13'b1010111001111: func_sel = 5'b10100;
			13'b1010111011000: func_sel = 5'b01111;
			13'b1010111011001: func_sel = 5'b10001;
			13'b1010111011011: func_sel = 5'b10000;
			13'b1010111100100: func_sel = 5'b00010;
			13'b1010111101000: func_sel = 5'b00100;
			13'b1010111101001: func_sel = 5'b00110;
			13'b1010111101010: func_sel = 5'b00101;
			13'b1010111101011: func_sel = 5'b00111;
			13'b1010111101100: func_sel = 5'b00100;
			13'b1010111101101: func_sel = 5'b00110;
			13'b1010111101110: func_sel = 5'b00101;
			13'b1010111101111: func_sel = 5'b00111;
			13'b1010111110000: func_sel = 5'b10101;
			13'b1010111110001: func_sel = 5'b10110;
			13'b1010111110010: func_sel = 5'b10111;
			default: func_sel = 1'sb0;
		endcase
		if (opcode == 7'b1100011)
			case (funct3)
				3'b000: func_sel = 5'b01111;
				3'b100: func_sel = 5'b10000;
				default: func_sel = 1'sb0;
			endcase
		if ((opcode == 7'b1010111) && (funct6 == 6'b010010))
			case (src1)
				5'b00001: func_sel = 5'b01101;
				5'b00011: func_sel = 5'b01110;
				default: func_sel = 1'sb0;
			endcase
		if ((opcode == 7'b1010111) && (funct6 == 6'b010011))
			case (src1)
				5'b10000: func_sel = 5'b10010;
				default: func_sel = 1'sb0;
			endcase
		case (opcode)
			7'b0000111: wb_sel = 5'b00010;
			7'b1010111: wb_sel = (~|func_sel[4:3] ? 5'b00100 : 5'b00001);
			7'b1010011: wb_sel = 5'b01000;
			7'b0001011: wb_sel = 5'b10000;
			7'b1100011: wb_sel = 5'b00001;
			default: wb_sel = 5'b00000;
		endcase
	end
	assign mem_addr = (branch ? branch_offset : instr[31:20]);
	assign mem_we = opcode == 7'b0100111;
	assign jump = opcode == 7'b1100111;
	assign branch = opcode == 7'b1100011;
	assign reg_we = (~mem_we && ~jump) && ~branch;
	wire stage1_dependency;
	wire stage2_dependency;
	wire stage3_dependency;
	assign stage1_dependency = (((vs1_addr == vd_addr_ex1) || (vs2_addr == vd_addr_ex1)) || (vs3_addr == vd_addr_ex1)) && reg_we_ex1;
	assign stage2_dependency = (((vs1_addr == vd_addr_ex2) || (vs2_addr == vd_addr_ex2)) || (vs3_addr == vd_addr_ex2)) && reg_we_ex2;
	assign stage3_dependency = (((vs1_addr == vd_addr_ex3) || (vs2_addr == vd_addr_ex3)) || (vs3_addr == vd_addr_ex3)) && reg_we_ex3;
	assign stall = ((stage1_dependency && |wb_sel_ex1[4:1]) || (stage2_dependency && |wb_sel_ex2[4:2])) || (stage3_dependency && wb_sel_ex3[4]);
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
	wire [EXP_WIDTH + SIG_WIDTH:0] one;
	wire [EXP_WIDTH - 1:0] one_exp;
	wire [SIG_WIDTH - 1:0] one_sig;
	assign one_exp = (1 << (EXP_WIDTH - 1)) - 1;
	assign one_sig = 0;
	assign one = {1'b0, one_exp, one_sig};
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
				assign dp4_mat_in[((((3 * i) + j) * 8) + 7) * DATA_WIDTH+:DATA_WIDTH] = one;
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
	assign dp4_qmul_in[DATA_WIDTH * 16+:DATA_WIDTH * 8] = {vec_a[0+:DATA_WIDTH], vec_b[2 * DATA_WIDTH+:DATA_WIDTH], a_neg[1], vec_b[3 * DATA_WIDTH+:DATA_WIDTH], vec_a[2 * DATA_WIDTH+:DATA_WIDTH], vec_b[0+:DATA_WIDTH], vec_a[3 * DATA_WIDTH+:DATA_WIDTH], vec_b[DATA_WIDTH+:DATA_WIDTH]};
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
module fpu (
	inst_a,
	inst_b,
	inst_rnd,
	inst_DG_ctrl,
	opcode,
	z_inst
);
	parameter SIG_WIDTH = 23;
	parameter EXP_WIDTH = 8;
	parameter IEEE_COMPLIANCE = 0;
	input wire [31:0] inst_a;
	input wire [31:0] inst_b;
	input wire [2:0] inst_rnd;
	input wire inst_DG_ctrl;
	input wire [4:0] opcode;
	output reg [31:0] z_inst;
	localparam DATA_WIDTH = (SIG_WIDTH + EXP_WIDTH) + 1;
	wire aeqb_inst;
	wire altb_inst;
	wire agtb_inst;
	wire unordered_inst;
	wire [DATA_WIDTH - 1:0] z0_inst;
	wire [DATA_WIDTH - 1:0] z1_inst;
	wire [7:0] status0_inst;
	wire [7:0] status1_inst;
	wire [DATA_WIDTH - 1:0] flt2i_inst;
	wire [7:0] flt2i_status;
	wire [DATA_WIDTH - 1:0] i2flt_inst;
	wire [7:0] i2flt_status;
	wire [DATA_WIDTH - 1:0] sgnj;
	wire [DATA_WIDTH - 1:0] sgnjn;
	wire [DATA_WIDTH - 1:0] sgnjx;
	wire [DATA_WIDTH - 1:0] fclass_mask;
	DW_fp_cmp_DG #(
		.sig_width(SIG_WIDTH),
		.exp_width(EXP_WIDTH),
		.ieee_compliance(IEEE_COMPLIANCE)
	) DW_fp_cmp_DG_inst(
		.a(inst_a),
		.b(inst_b),
		.zctr(1'b0),
		.DG_ctrl(inst_DG_ctrl),
		.aeqb(aeqb_inst),
		.altb(altb_inst),
		.agtb(agtb_inst),
		.unordered(unordered_inst),
		.z0(z0_inst),
		.z1(z1_inst),
		.status0(status0_inst),
		.status1(status1_inst)
	);
	DW_fp_flt2i #(
		.sig_width(SIG_WIDTH),
		.exp_width(EXP_WIDTH),
		.isize(DATA_WIDTH),
		.ieee_compliance(IEEE_COMPLIANCE)
	) DW_fp_flt2i_inst(
		.a(inst_b),
		.rnd(inst_rnd),
		.z(flt2i_inst),
		.status(flt2i_status)
	);
	DW_fp_i2flt #(
		.sig_width(SIG_WIDTH),
		.exp_width(EXP_WIDTH),
		.isize(DATA_WIDTH),
		.isign(1)
	) DW_fp_i2flt_inst(
		.a(inst_b),
		.rnd(inst_rnd),
		.z(i2flt_inst),
		.status(i2flt_status)
	);
	assign sgnj = {inst_b[DATA_WIDTH - 1], inst_a[DATA_WIDTH - 2:0]};
	assign sgnjn = {~inst_b[DATA_WIDTH - 1], inst_a[DATA_WIDTH - 2:0]};
	assign sgnjx = {inst_a[DATA_WIDTH - 1] ^ inst_b[DATA_WIDTH - 1], inst_a[DATA_WIDTH - 2:0]};
	wire zero_sig;
	assign zero_sig = inst_b[SIG_WIDTH - 1:0] == 0;
	wire zero_exp;
	assign zero_exp = inst_b[SIG_WIDTH+:EXP_WIDTH] == 0;
	wire nan_exp;
	assign nan_exp = &inst_b[SIG_WIDTH+:EXP_WIDTH];
	assign fclass_mask[0] = (inst_b[31] && nan_exp) && zero_sig;
	assign fclass_mask[1] = (inst_b[31] && ~nan_exp) && ~zero_exp;
	assign fclass_mask[2] = (inst_b[31] && zero_exp) && ~zero_sig;
	assign fclass_mask[3] = (inst_b[31] && zero_exp) && zero_sig;
	assign fclass_mask[4] = (~inst_b[31] && zero_exp) && zero_sig;
	assign fclass_mask[5] = (~inst_b[31] && zero_exp) && ~zero_sig;
	assign fclass_mask[6] = (~inst_b[31] && ~nan_exp) && ~zero_exp;
	assign fclass_mask[7] = (~inst_b[31] && nan_exp) && zero_sig;
	assign fclass_mask[8] = (nan_exp && ~inst_b[SIG_WIDTH - 1]) && ~zero_sig;
	assign fclass_mask[9] = nan_exp && inst_b[SIG_WIDTH - 1];
	assign fclass_mask[DATA_WIDTH - 1:10] = 1'sb0;
	always @(*)
		case (opcode)
			5'b01000: z_inst = z0_inst;
			5'b01001: z_inst = z1_inst;
			5'b01010: z_inst = sgnj;
			5'b01011: z_inst = sgnjn;
			5'b01100: z_inst = sgnjx;
			5'b01101: z_inst = flt2i_inst;
			5'b01110: z_inst = i2flt_inst;
			5'b01111: z_inst = aeqb_inst;
			5'b10000: z_inst = altb_inst;
			5'b10001: z_inst = aeqb_inst || altb_inst;
			5'b10010: z_inst = fclass_mask;
			default: z_inst = 1'sb0;
		endcase
endmodule
module instruction_fetch (
	clk,
	rst_n,
	en,
	jump,
	jump_addr,
	branch,
	branch_offset,
	pc
);
	parameter ADDR_WIDTH = 8;
	input wire clk;
	input wire rst_n;
	input wire en;
	input wire jump;
	input wire [ADDR_WIDTH - 1:0] jump_addr;
	input branch;
	input wire [ADDR_WIDTH - 1:0] branch_offset;
	output wire [ADDR_WIDTH - 1:0] pc;
	reg [ADDR_WIDTH - 1:0] pc_pipe1;
	reg [ADDR_WIDTH - 1:0] pc_pipe2;
	wire [ADDR_WIDTH - 1:0] pc_next;
	assign pc = (en ? pc_pipe1 : pc_pipe2);
	assign pc_next = (jump ? jump_addr : (branch ? branch_offset : pc + 1));
	always @(posedge clk)
		if (~rst_n) begin
			pc_pipe1 <= 0;
			pc_pipe2 <= 0;
		end
		else if (en) begin
			pc_pipe1 <= pc_next;
			pc_pipe2 <= pc_pipe1;
		end
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
	mem_we,
	mem_ren,
	mem_addr,
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
	mat_inv_out_l,
	mat_inv_out_u
);
	parameter ADDR_WIDTH = 12;
	parameter DATA_WIDTH = 32;
	parameter VECTOR_LANES = 16;
	parameter DATAPATH = 8;
	parameter INSTR_MEM_ADDR_WIDTH = 8;
	parameter DATA_MEM_ADDR_WIDTH = 12;
	input wire clk;
	input wire mem_we;
	input wire mem_ren;
	input wire [ADDR_WIDTH - 1:0] mem_addr;
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
	output reg [DATAPATH - 1:0] data_mem_wdata;
	input wire [DATAPATH - 1:0] data_mem_rdata;
	input wire [(9 * DATA_WIDTH) - 1:0] mat_inv_out_l;
	input wire [(9 * DATA_WIDTH) - 1:0] mat_inv_out_u;
	localparam MASK_BITS = DATAPATH / 32;
	localparam DATA_MASK = 12'h800;
	localparam DATA_ADDR = 12'h000;
	localparam TEXT_MASK = 12'he00;
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
	always @(*) begin
		instr_mem_csb = 1'b0;
		instr_mem_web = 1'b0;
		data_mem_csb = 1'b0;
		data_mem_web = 1'b0;
		case (width)
			3'b010: data_mem_wmask = 1'b1;
			3'b011: data_mem_wmask = {2 {1'b1}};
			3'b100: data_mem_wmask = {4 {1'b1}};
			default: data_mem_wmask = {8 {1'b1}};
		endcase
		data_mem_wmask = data_mem_wmask << mem_addr[2:0];
		case (mem_addr[2:0])
			3'b000: data_mem_wdata = mem_wdata;
			3'b001: data_mem_wdata = mem_wdata << 32;
			3'b010: data_mem_wdata = mem_wdata << 64;
			3'b011: data_mem_wdata = mem_wdata << 96;
			3'b100: data_mem_wdata = mem_wdata << 128;
			3'b101: data_mem_wdata = mem_wdata << 160;
			3'b110: data_mem_wdata = mem_wdata << 192;
			3'b111: data_mem_wdata = mem_wdata << 224;
			default: data_mem_wdata = 1'sb0;
		endcase
		if ((mem_addr & DATA_MASK) == DATA_ADDR) begin
			data_mem_csb = mem_ren || mem_we;
			data_mem_web = mem_we;
		end
		else if ((mem_addr & TEXT_MASK) == TEXT_ADDR) begin
			instr_mem_csb = mem_ren || mem_we;
			instr_mem_web = mem_we;
		end
		if ((mem_addr_r & DATA_MASK) == DATA_ADDR)
			mem_rdata = data_mem_rdata;
		else if ((mem_addr_r & TEXT_MASK) == TEXT_ADDR)
			mem_rdata = instr_mem_rdata;
		else if (mem_addr_r == INVMAT_L_ADDR)
			mem_rdata = mat_inv_out_l;
		else if (mem_addr_r == INVMAT_U_ADDR)
			mem_rdata = mat_inv_out_u;
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
	parameter DATA_WIDTH = (SIG_WIDTH + EXP_WIDTH) + 1;
	parameter INSTR_MEM_ADDR_WIDTH = 8;
	parameter REG_BANK_DEPTH = 32;
	parameter REG_ADDR_WIDTH = $clog2(REG_BANK_DEPTH);
	input wire clk;
	input wire rst_n;
	input wire en;
	output wire [INSTR_MEM_ADDR_WIDTH - 1:0] pc;
	input wire [31:0] instr;
	output wire [11:0] mem_addr;
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
	wire [4:0] opcode_id;
	reg [4:0] opcode_ex1;
	wire [2:0] funct3_id;
	reg [2:0] funct3_ex1;
	wire [4:0] wb_sel_id;
	reg [4:0] wb_sel_ex1;
	reg [4:0] wb_sel_ex2;
	reg [4:0] wb_sel_ex3;
	reg [4:0] wb_sel_ex4;
	reg [4:0] wb_sel_wb;
	wire reg_we_id;
	reg reg_we_ex1;
	reg reg_we_ex2;
	reg reg_we_ex3;
	reg reg_we_ex4;
	reg reg_we_wb;
	wire mem_we_id;
	reg mem_we_ex1;
	wire [11:0] mem_addr_id;
	reg [11:0] mem_addr_ex1;
	reg [11:0] mem_addr_ex2;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_rdata_ex3;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_rdata_ex4;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] mem_rdata_wb;
	reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] reg_wdata_wb;
	wire jump_id;
	wire [INSTR_MEM_ADDR_WIDTH - 1:0] jump_addr_id;
	wire [INSTR_MEM_ADDR_WIDTH - 1:0] jump_addr_ex2;
	wire pc_sel;
	wire branch_id;
	reg branch_ex1;
	reg branch_ex2;
	assign data_out = reg_wdata_wb;
	assign data_out_vld = en && reg_we_wb;
	assign reg_wb = vd_addr_wb;
	wire pipe_en;
	assign pipe_en = en && (en_q || (pc != 0));
	always @(posedge clk) begin
		en_q <= en;
		if (data_out_vld) begin
			begin : sv2v_autoblock_1
				reg signed [31:0] i;
				for (i = 8; i >= 0; i = i - 1)
					$write("%h_", reg_wdata_wb[i * DATA_WIDTH+:DATA_WIDTH]);
			end
			$display;
		end
	end
	instruction_fetch #(.ADDR_WIDTH(INSTR_MEM_ADDR_WIDTH)) if_stage(
		.clk(clk),
		.rst_n(rst_n),
		.en(en & ~stall),
		.branch(pc_sel),
		.branch_offset(jump_addr_ex2),
		.jump(jump_id),
		.jump_addr(jump_addr_id),
		.pc(pc)
	);
	assign jump_addr_id = mem_addr_id[INSTR_MEM_ADDR_WIDTH - 1:0];
	assign jump_addr_ex2 = mem_addr_ex2[INSTR_MEM_ADDR_WIDTH - 1:0];
	decoder decoder_inst(
		.instr(instr),
		.vd_addr(vd_addr_id),
		.vs1_addr(vs1_addr_id),
		.vs2_addr(vs2_addr_id),
		.vs3_addr(vs3_addr_id),
		.mem_addr(mem_addr_id),
		.func_sel(opcode_id),
		.funct3(funct3_id),
		.wb_sel(wb_sel_id),
		.mem_we(mem_we_id),
		.reg_we(reg_we_id),
		.jump(jump_id),
		.branch(branch_id),
		.vd_addr_ex1(vd_addr_ex1),
		.vd_addr_ex2(vd_addr_ex2),
		.vd_addr_ex3(vd_addr_ex3),
		.reg_we_ex1(reg_we_ex1),
		.reg_we_ex2(reg_we_ex2),
		.reg_we_ex3(reg_we_ex3),
		.wb_sel_ex1(wb_sel_ex1),
		.wb_sel_ex2(wb_sel_ex2),
		.wb_sel_ex3(wb_sel_ex3),
		.stall(stall)
	);
	vrf #(
		.ADDR_WIDTH(REG_ADDR_WIDTH),
		.DEPTH(REG_BANK_DEPTH),
		.DATA_WIDTH(VECTOR_LANES * DATA_WIDTH)
	) vrf_inst(
		.clk(clk),
		.rst_n(rst_n),
		.wen(en && reg_we_wb),
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
	assign stage3_forward = (wb_sel_ex3[0] ? vec_out_ex3 : mem_rdata_ex3);
	always @(*)
		case (wb_sel_ex4)
			5'b00001: stage4_forward = vec_out_ex4;
			5'b00010: stage4_forward = mem_rdata_ex4;
			5'b00100: stage4_forward = vfu_out_ex4;
			5'b01000: stage4_forward = mfu_out_ex4;
			default: stage4_forward = 1'sb0;
		endcase
	assign pc_sel = branch_ex2 && vec_out_ex2[0+:DATA_WIDTH];
	assign operand_a = (((vs1_addr_ex1 == vd_addr_ex2) && reg_we_ex2) && wb_sel_ex2[0] ? stage2_forward : (((vs1_addr_ex1 == vd_addr_ex3) && reg_we_ex3) && |wb_sel_ex3[1:0] ? stage3_forward : (((vs1_addr_ex1 == vd_addr_ex4) && reg_we_ex4) && ~wb_sel_ex4[4] ? stage4_forward : ((vs1_addr_ex1 == vd_addr_wb) && reg_we_wb ? reg_wdata_wb : vs1_data_ex1))));
	assign operand_b = (((vs2_addr_ex1 == vd_addr_ex2) && reg_we_ex2) && wb_sel_ex2[0] ? stage2_forward : (((vs2_addr_ex1 == vd_addr_ex3) && reg_we_ex3) && |wb_sel_ex3[1:0] ? stage3_forward : (((vs2_addr_ex1 == vd_addr_ex4) && reg_we_ex4) && ~wb_sel_ex4[4] ? stage4_forward : ((vs2_addr_ex1 == vd_addr_wb) && reg_we_wb ? reg_wdata_wb : vs2_data_ex1))));
	assign operand_c = (((vs3_addr_ex1 == vd_addr_ex2) && reg_we_ex2) && wb_sel_ex2[0] ? stage2_forward : (((vs3_addr_ex1 == vd_addr_ex3) && reg_we_ex3) && |wb_sel_ex3[1:0] ? stage3_forward : (((vs3_addr_ex1 == vd_addr_ex4) && reg_we_ex4) && ~wb_sel_ex4[4] ? stage4_forward : ((vs3_addr_ex1 == vd_addr_wb) && reg_we_wb ? reg_wdata_wb : vs3_data_ex1))));
	vector_unit #(
		.SIG_WIDTH(SIG_WIDTH),
		.EXP_WIDTH(EXP_WIDTH),
		.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
		.VECTOR_LANES(VECTOR_LANES)
	) vector_unit_inst(
		.clk(clk),
		.en(wb_sel_ex1[0]),
		.vec_a(operand_a),
		.vec_b(operand_b),
		.vec_c(operand_c),
		.rnd(3'b000),
		.opcode(opcode_ex1),
		.funct(funct3_ex1),
		.imm(vs1_addr_ex1),
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
		.en(wb_sel_ex1[2]),
		.vec_a(operand_a),
		.vec_b(operand_b),
		.vec_c(operand_c),
		.rnd(3'b000),
		.opcode(opcode_ex1),
		.funct(funct3_ex1),
		.vec_out(vfu_out_ex4)
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
		.inst_DG_ctrl(wb_sel_ex1[3]),
		.z_inst(mfu_out_ex4),
		.status_inst(status_inst)
	);
	dot_product_unit #(
		.SIG_WIDTH(SIG_WIDTH),
		.EXP_WIDTH(EXP_WIDTH),
		.IEEE_COMPLIANCE(IEEE_COMPLIANCE),
		.VECTOR_LANES(9),
		.NUM_STAGES(4)
	) dp_unit_inst(
		.clk(clk),
		.en(wb_sel_ex1[4]),
		.vec_a(operand_a[0+:DATA_WIDTH * 9]),
		.vec_b(operand_b[0+:DATA_WIDTH * 9]),
		.vec_c(operand_c[0+:DATA_WIDTH * 9]),
		.rnd(3'b000),
		.funct(funct3_ex1),
		.vec_out(mat_out_wb)
	);
	assign mem_addr = mem_addr_ex1;
	assign mem_we = mem_we_ex1 && en;
	assign mem_ren = wb_sel_ex1[1] && en;
	assign mem_wdata = operand_c;
	assign width = funct3_ex1;
	always @(*)
		case (wb_sel_wb)
			5'b00001: reg_wdata_wb = vec_out_wb;
			5'b00010: reg_wdata_wb = mem_rdata_wb;
			5'b00100: reg_wdata_wb = vfu_out_wb;
			5'b01000: reg_wdata_wb = mfu_out_wb;
			5'b10000: reg_wdata_wb = mat_out_wb;
			default: reg_wdata_wb = 1'sb0;
		endcase
	always @(posedge clk)
		if (~rst_n) begin
			vs1_addr_ex1 <= 0;
			vs2_addr_ex1 <= 0;
			vs3_addr_ex1 <= 0;
			mem_addr_ex1 <= 0;
			mem_addr_ex2 <= 0;
			vs1_data_ex1 <= 0;
			vs2_data_ex1 <= 0;
			vs3_data_ex1 <= 0;
			vd_addr_ex1 <= 0;
			vd_addr_ex2 <= 0;
			vd_addr_ex3 <= 0;
			vd_addr_ex4 <= 0;
			vd_addr_wb <= 0;
			opcode_ex1 <= 0;
			funct3_ex1 <= 0;
			mem_we_ex1 <= 0;
			reg_we_ex1 <= 0;
			reg_we_ex2 <= 0;
			reg_we_ex3 <= 0;
			reg_we_ex4 <= 0;
			reg_we_wb <= 0;
			wb_sel_ex1 <= 0;
			wb_sel_ex2 <= 0;
			wb_sel_ex3 <= 0;
			wb_sel_ex4 <= 0;
			wb_sel_wb <= 0;
			branch_ex1 <= 0;
			branch_ex2 <= 0;
			vec_out_ex3 <= 0;
			vec_out_ex4 <= 0;
			vec_out_wb <= 0;
			vfu_out_wb <= 0;
			mfu_out_wb <= 0;
			mem_rdata_ex3 <= 0;
			mem_rdata_ex4 <= 0;
			mem_rdata_wb <= 0;
		end
		else if (pipe_en) begin
			vs1_addr_ex1 <= vs1_addr_id;
			vs2_addr_ex1 <= vs2_addr_id;
			vs3_addr_ex1 <= vs3_addr_id;
			mem_addr_ex1 <= mem_addr_id;
			mem_addr_ex2 <= mem_addr_ex1;
			vs1_data_ex1 <= vs1_data_id;
			vs2_data_ex1 <= vs2_data_id;
			vs3_data_ex1 <= vs3_data_id;
			vd_addr_ex1 <= vd_addr_id;
			vd_addr_ex2 <= vd_addr_ex1;
			vd_addr_ex3 <= vd_addr_ex2;
			vd_addr_ex4 <= vd_addr_ex3;
			vd_addr_wb <= vd_addr_ex4;
			opcode_ex1 <= opcode_id;
			funct3_ex1 <= funct3_id;
			mem_we_ex1 <= mem_we_id && ~stall;
			reg_we_ex1 <= reg_we_id && ~stall;
			reg_we_ex2 <= reg_we_ex1;
			reg_we_ex3 <= reg_we_ex2;
			reg_we_ex4 <= reg_we_ex3;
			reg_we_wb <= reg_we_ex4;
			wb_sel_ex1 <= (stall ? 5'b00000 : wb_sel_id);
			wb_sel_ex2 <= wb_sel_ex1;
			wb_sel_ex3 <= wb_sel_ex2;
			wb_sel_ex4 <= wb_sel_ex3;
			wb_sel_wb <= wb_sel_ex4;
			branch_ex1 <= branch_id && ~stall;
			branch_ex2 <= branch_ex1;
			vec_out_ex3 <= vec_out_ex2;
			vec_out_ex4 <= vec_out_ex3;
			vec_out_wb <= vec_out_ex4;
			vfu_out_wb <= vfu_out_ex4;
			mfu_out_wb <= mfu_out_ex4;
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
						.web0(~(web0 && wmask0[j])),
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
					.web0(~(web0 && wmask0[i])),
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
module skew_symmetric (
	vec_a,
	vec_out
);
	parameter DATA_WIDTH = 32;
	input wire [(9 * DATA_WIDTH) - 1:0] vec_a;
	output wire [(9 * DATA_WIDTH) - 1:0] vec_out;
	wire [(9 * DATA_WIDTH) - 1:0] vec_a_neg;
	genvar i;
	generate
		for (i = 0; i < 9; i = i + 1) begin : negate_inputs
			assign vec_a_neg[i * DATA_WIDTH+:DATA_WIDTH] = {~vec_a[(i * DATA_WIDTH) + (DATA_WIDTH - 1)], vec_a[(i * DATA_WIDTH) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 2 : ((DATA_WIDTH - 2) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)) - 1)-:((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)]};
		end
	endgenerate
	assign vec_out[0+:DATA_WIDTH] = 1'sb0;
	assign vec_out[DATA_WIDTH+:DATA_WIDTH] = vec_a[2 * DATA_WIDTH+:DATA_WIDTH];
	assign vec_out[2 * DATA_WIDTH+:DATA_WIDTH] = vec_a_neg[DATA_WIDTH+:DATA_WIDTH];
	assign vec_out[3 * DATA_WIDTH+:DATA_WIDTH] = vec_a_neg[2 * DATA_WIDTH+:DATA_WIDTH];
	assign vec_out[4 * DATA_WIDTH+:DATA_WIDTH] = 1'sb0;
	assign vec_out[5 * DATA_WIDTH+:DATA_WIDTH] = vec_a[0+:DATA_WIDTH];
	assign vec_out[6 * DATA_WIDTH+:DATA_WIDTH] = vec_a[DATA_WIDTH+:DATA_WIDTH];
	assign vec_out[7 * DATA_WIDTH+:DATA_WIDTH] = vec_a_neg[0+:DATA_WIDTH];
	assign vec_out[8 * DATA_WIDTH+:DATA_WIDTH] = 1'sb0;
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
module vector_unit (
	clk,
	en,
	vec_a,
	vec_b,
	vec_c,
	opcode,
	funct,
	imm,
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
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_c;
	input wire [4:0] opcode;
	input wire [2:0] funct;
	input wire [4:0] imm;
	input wire [2:0] rnd;
	output reg [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out;
	wire [(9 * DATA_WIDTH) - 1:0] skew_mat;
	wire [(9 * DATA_WIDTH) - 1:0] transpose;
	wire [(9 * DATA_WIDTH) - 1:0] identity;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vslide_up;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vslide_down;
	skew_symmetric #(.DATA_WIDTH(DATA_WIDTH)) skew_symmetric_inst(
		.vec_a(vec_a[0+:DATA_WIDTH * 9]),
		.vec_out(skew_mat)
	);
	vslide_up #(.DATA_WIDTH(DATA_WIDTH)) vslide_up_inst(
		.vsrc(vec_b),
		.vdest(vec_c),
		.shamt(imm),
		.vec_out(vslide_up)
	);
	vslide_down #(.DATA_WIDTH(DATA_WIDTH)) vslide_down_inst(
		.vsrc(vec_b),
		.vdest(vec_c),
		.shamt(imm),
		.vec_out(vslide_down)
	);
	genvar i;
	generate
		for (i = 0; i < 3; i = i + 1) begin : genblk1
			genvar j;
			for (j = 0; j < 3; j = j + 1) begin : genblk1
				assign transpose[((3 * i) + j) * DATA_WIDTH+:DATA_WIDTH] = vec_a[((3 * j) + i) * DATA_WIDTH+:DATA_WIDTH];
			end
		end
	endgenerate
	wire [EXP_WIDTH + SIG_WIDTH:0] one;
	wire [EXP_WIDTH - 1:0] one_exp;
	wire [SIG_WIDTH - 1:0] one_sig;
	assign one_exp = (1 << (EXP_WIDTH - 1)) - 1;
	assign one_sig = 0;
	assign one = {1'b0, one_exp, one_sig};
	assign identity = {one, 32'h00000000, 32'h00000000, 32'h00000000, one, 32'h00000000, 32'h00000000, 32'h00000000, one};
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vfpu;
	generate
		for (i = 0; i < VECTOR_LANES; i = i + 1) begin : genblk2
			wire [DATA_WIDTH - 1:0] inst_a;
			wire [DATA_WIDTH - 1:0] inst_b;
			assign inst_a = (funct == 3'b101 ? vec_a[0+:DATA_WIDTH] : vec_a[i * DATA_WIDTH+:DATA_WIDTH]);
			assign inst_b = vec_b[i * DATA_WIDTH+:DATA_WIDTH];
			fpu #(
				.SIG_WIDTH(SIG_WIDTH),
				.EXP_WIDTH(EXP_WIDTH),
				.IEEE_COMPLIANCE(1)
			) fpu_inst(
				.inst_a(inst_a),
				.inst_b(inst_b),
				.inst_rnd(rnd),
				.inst_DG_ctrl(en),
				.opcode(opcode),
				.z_inst(vfpu[i * DATA_WIDTH+:DATA_WIDTH])
			);
		end
	endgenerate
	always @(posedge clk)
		case (opcode)
			5'b10011: vec_out <= vslide_up;
			5'b10100: vec_out <= vslide_down;
			5'b10101: vec_out <= skew_mat;
			5'b10110: vec_out <= transpose;
			5'b10111: vec_out <= identity;
			default: vec_out <= vfpu;
		endcase
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
			wire [EXP_WIDTH + SIG_WIDTH:0] one;
			wire [EXP_WIDTH - 1:0] one_exp;
			wire [SIG_WIDTH - 1:0] one_sig;
			assign one_exp = (1 << (EXP_WIDTH - 1)) - 1;
			assign one_sig = 0;
			assign one = {1'b0, one_exp, one_sig};
			assign b_neg = {~vec_b[(i * DATA_WIDTH) + (DATA_WIDTH - 1)], vec_b[(i * DATA_WIDTH) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 2 : ((DATA_WIDTH - 2) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)) - 1)-:((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)]};
			assign c_neg = {~vec_c[(i * DATA_WIDTH) + (DATA_WIDTH - 1)], vec_c[(i * DATA_WIDTH) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 2 : ((DATA_WIDTH - 2) + ((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)) - 1)-:((DATA_WIDTH - 2) >= 0 ? DATA_WIDTH - 1 : 3 - DATA_WIDTH)]};
			assign inst_a = (funct == 3'b101 ? vec_a[0+:DATA_WIDTH] : vec_a[i * DATA_WIDTH+:DATA_WIDTH]);
			always @(*)
				case (opcode)
					5'b00000: begin
						inst_b = one;
						inst_c = vec_b[i * DATA_WIDTH+:DATA_WIDTH];
					end
					5'b00001: begin
						inst_b = one;
						inst_c = b_neg;
					end
					5'b00010: begin
						inst_b = vec_b[i * DATA_WIDTH+:DATA_WIDTH];
						inst_c = 32'b00000000000000000000000000000000;
					end
					5'b00101: begin
						inst_b = vec_b[i * DATA_WIDTH+:DATA_WIDTH];
						inst_c = c_neg;
					end
					5'b00110: begin
						inst_b = b_neg;
						inst_c = c_neg;
					end
					5'b00111: begin
						inst_b = b_neg;
						inst_c = vec_c[i * DATA_WIDTH+:DATA_WIDTH];
					end
					default: begin
						inst_b = vec_b[i * DATA_WIDTH+:DATA_WIDTH];
						inst_c = vec_c[i * DATA_WIDTH+:DATA_WIDTH];
					end
				endcase
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
		if (~rst_n)
			vectors <= {DEPTH {sv2v_cast_A78C9(0)}};
		else if (wen)
			vectors[addr_w * DATA_WIDTH+:DATA_WIDTH] <= data_w;
endmodule
module vslide_down (
	vsrc,
	vdest,
	shamt,
	vec_out
);
	parameter DATA_WIDTH = 32;
	parameter VECTOR_LANES = 16;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vsrc;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vdest;
	input wire [4:0] shamt;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide8down;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide4down;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide2down;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide1down;
	wire [VECTOR_LANES - 1:0] mask0;
	wire [VECTOR_LANES - 1:0] mask1;
	wire [VECTOR_LANES - 1:0] mask2;
	wire [VECTOR_LANES - 1:0] mask3;
	wire [VECTOR_LANES - 1:0] mask4;
	assign slide8down = (shamt[3] ? {{8 {32'b00000000000000000000000000000000}}, vsrc[DATA_WIDTH * 8+:DATA_WIDTH * 8]} : vsrc);
	assign slide4down = (shamt[2] ? {{4 {32'b00000000000000000000000000000000}}, slide8down[DATA_WIDTH * 4+:DATA_WIDTH * 12]} : slide8down);
	assign slide2down = (shamt[1] ? {{2 {32'b00000000000000000000000000000000}}, slide4down[DATA_WIDTH * 2+:DATA_WIDTH * 14]} : slide4down);
	assign slide1down = (shamt[0] ? {32'b00000000000000000000000000000000, slide2down[DATA_WIDTH+:DATA_WIDTH * 15]} : slide2down);
	assign mask0 = 16'hffff;
	assign mask1 = (shamt[3] ? {8'b00000000, mask0[15:8]} : mask0);
	assign mask2 = (shamt[2] ? {4'b0000, mask1[15:4]} : mask1);
	assign mask3 = (shamt[1] ? {2'b00, mask2[15:2]} : mask2);
	assign mask4 = (shamt[0] ? {1'b0, mask3[15:1]} : mask3);
	genvar i;
	generate
		for (i = 0; i < VECTOR_LANES; i = i + 1) begin : genblk1
			assign vec_out[i * DATA_WIDTH+:DATA_WIDTH] = (mask4[i] ? slide1down[i * DATA_WIDTH+:DATA_WIDTH] : vdest[i * DATA_WIDTH+:DATA_WIDTH]);
		end
	endgenerate
endmodule
module vslide_up (
	vsrc,
	vdest,
	shamt,
	vec_out
);
	parameter DATA_WIDTH = 32;
	parameter VECTOR_LANES = 16;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vsrc;
	input wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vdest;
	input wire [4:0] shamt;
	output wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] vec_out;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide8up;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide4up;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide2up;
	wire [(VECTOR_LANES * DATA_WIDTH) - 1:0] slide1up;
	wire [VECTOR_LANES - 1:0] mask0;
	wire [VECTOR_LANES - 1:0] mask1;
	wire [VECTOR_LANES - 1:0] mask2;
	wire [VECTOR_LANES - 1:0] mask3;
	wire [VECTOR_LANES - 1:0] mask4;
	assign slide8up = (shamt[3] ? {vsrc[0+:DATA_WIDTH * 8], {8 {32'b00000000000000000000000000000000}}} : vsrc);
	assign slide4up = (shamt[2] ? {slide8up[0+:DATA_WIDTH * 12], {4 {32'b00000000000000000000000000000000}}} : slide8up);
	assign slide2up = (shamt[1] ? {slide4up[0+:DATA_WIDTH * 14], {2 {32'b00000000000000000000000000000000}}} : slide4up);
	assign slide1up = (shamt[0] ? {slide2up[0+:DATA_WIDTH * 15], 32'b00000000000000000000000000000000} : slide2up);
	assign mask0 = 16'hffff;
	assign mask1 = (shamt[3] ? {mask0[7:0], 8'b00000000} : mask0);
	assign mask2 = (shamt[2] ? {mask1[11:0], 4'b0000} : mask1);
	assign mask3 = (shamt[1] ? {mask2[13:0], 2'b00} : mask2);
	assign mask4 = (shamt[0] ? {mask3[14:0], 1'b0} : mask3);
	genvar i;
	generate
		for (i = 0; i < VECTOR_LANES; i = i + 1) begin : genblk1
			assign vec_out[i * DATA_WIDTH+:DATA_WIDTH] = (mask4[i] ? slide1up[i * DATA_WIDTH+:DATA_WIDTH] : vdest[i * DATA_WIDTH+:DATA_WIDTH]);
		end
	endgenerate
endmodule
module wishbone_ctl (
	wb_clk_i,
	wb_rst_i,
	wbs_stb_i,
	wbs_cyc_i,
	wbs_we_i,
	wbs_sel_i,
	wbs_dat_i,
	wbs_adr_i,
	wbs_ack_o,
	wbs_dat_o,
	wbs_debug,
	wbs_fsm_start,
	wbs_fsm_done,
	wbs_mem_we,
	wbs_mem_ren,
	wbs_mem_addr,
	wbs_mem_wdata,
	wbs_mem_rdata
);
	parameter WISHBONE_BASE_ADDR = 32'h30000000;
	input wire wb_clk_i;
	input wire wb_rst_i;
	input wire wbs_stb_i;
	input wire wbs_cyc_i;
	input wire wbs_we_i;
	input wire [3:0] wbs_sel_i;
	input wire [31:0] wbs_dat_i;
	input wire [31:0] wbs_adr_i;
	output wire wbs_ack_o;
	output reg [31:0] wbs_dat_o;
	output reg wbs_debug;
	output reg wbs_fsm_start;
	input wire wbs_fsm_done;
	output reg wbs_mem_we;
	output wire wbs_mem_ren;
	output reg [11:0] wbs_mem_addr;
	output reg [31:0] wbs_mem_wdata;
	input wire [31:0] wbs_mem_rdata;
	localparam WBS_DEBUG_ADDR = 32'h30000000;
	localparam WBS_FSM_START_ADDR = 32'h30000004;
	localparam WBS_FSM_DONE_ADDR = 32'h30000008;
	localparam WBS_MEM_MASK = 32'hffff0000;
	localparam WBS_MEM_ADDR = 32'h30010000;
	wire wbs_req = wbs_stb_i & wbs_cyc_i;
	wire ack_o;
	localparam SR_DEPTH = 4;
	integer i;
	reg [3:0] ack_o_shift_reg;
	always @(posedge wb_clk_i)
		if (wb_rst_i)
			ack_o_shift_reg <= {SR_DEPTH {1'b0}};
		else begin
			ack_o_shift_reg[0] <= wbs_req;
			for (i = 0; i < 3; i = i + 1)
				ack_o_shift_reg[i + 1] <= ack_o_shift_reg[i];
		end
	assign ack_o = ack_o_shift_reg[0];
	wire wbs_req_write = (!ack_o & wbs_req) & wbs_we_i;
	wire wbs_req_read = (!ack_o & wbs_req) & ~wbs_we_i;
	always @(posedge wb_clk_i)
		if (wb_rst_i)
			wbs_debug <= 0;
		else if (wbs_req_write && (wbs_adr_i == WBS_DEBUG_ADDR))
			wbs_debug <= wbs_dat_i[0];
	always @(posedge wb_clk_i)
		if (wb_rst_i)
			wbs_fsm_start <= 0;
		else if (wbs_req_write && (wbs_adr_i == WBS_FSM_START_ADDR))
			wbs_fsm_start <= wbs_dat_i[0];
		else
			wbs_fsm_start <= 0;
	always @(posedge wb_clk_i)
		if (wb_rst_i) begin
			wbs_mem_we <= 1'b0;
			wbs_mem_addr <= 12'b000000000000;
			wbs_mem_wdata <= 0;
		end
		else if (wbs_req_write && ((wbs_adr_i & WBS_MEM_MASK) == WBS_MEM_ADDR)) begin
			wbs_mem_we <= 1'b1;
			wbs_mem_addr <= wbs_adr_i[13:2];
			wbs_mem_wdata <= wbs_dat_i;
		end
		else
			wbs_mem_we <= 1'b0;
	reg [31:0] wbs_adr_i_q;
	always @(posedge wb_clk_i)
		if (wb_rst_i)
			wbs_adr_i_q <= 0;
		else
			wbs_adr_i_q <= wbs_adr_i;
	always @(*) begin : blockName
		if ((wbs_adr_i_q & WBS_MEM_MASK) == WBS_MEM_ADDR)
			wbs_dat_o = wbs_mem_rdata;
		else if (wbs_adr_i_q == WBS_FSM_DONE_ADDR)
			wbs_dat_o = wbs_fsm_done;
	end
	assign wbs_ack_o = ack_o;
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
endmodule
module SyncBit (
	sCLK,
	sRST,
	dCLK,
	sEN,
	sD_IN,
	dD_OUT
);
	parameter init = 1'b0;
	input sCLK;
	input sRST;
	input sEN;
	input sD_IN;
	input dCLK;
	output wire dD_OUT;
	reg sSyncReg;
	reg dSyncReg1;
	reg dSyncReg2;
	assign dD_OUT = dSyncReg2;
	always @(posedge sCLK or negedge sRST)
		if (sRST == 1'b0)
			sSyncReg <= init;
		else if (sEN)
			sSyncReg <= (sD_IN == 1'b1 ? 1'b1 : 1'b0);
	always @(posedge dCLK or negedge sRST)
		if (sRST == 1'b0) begin
			dSyncReg1 <= init;
			dSyncReg2 <= init;
		end
		else begin
			dSyncReg1 <= sSyncReg;
			dSyncReg2 <= dSyncReg1;
		end
	initial begin
		sSyncReg = init;
		dSyncReg1 = init;
		dSyncReg2 = init;
	end
endmodule
module SyncPulse (
	sCLK,
	sRST,
	dCLK,
	sEN,
	dPulse
);
	input sCLK;
	input sRST;
	input sEN;
	input dCLK;
	output wire dPulse;
	reg sSyncReg;
	reg dSyncReg1;
	reg dSyncReg2;
	reg dSyncPulse;
	assign dPulse = dSyncReg2 != dSyncPulse;
	always @(posedge sCLK or negedge sRST)
		if (sRST == 1'b0)
			sSyncReg <= 1'b0;
		else if (sEN)
			sSyncReg <= !sSyncReg;
	always @(posedge dCLK or negedge sRST)
		if (sRST == 1'b0) begin
			dSyncReg1 <= 1'b0;
			dSyncReg2 <= 1'b0;
			dSyncPulse <= 1'b0;
		end
		else begin
			dSyncReg1 <= sSyncReg;
			dSyncReg2 <= dSyncReg1;
			dSyncPulse <= dSyncReg2;
		end
	initial begin
		sSyncReg = 1'b0;
		dSyncReg1 = 1'b0;
		dSyncReg2 = 1'b0;
		dSyncPulse = 1'b0;
	end
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
`define MPRJ_IO_PADS 38

module user_proj_example #(
    parameter BITS = 32,
    parameter WISHBONE_BASE_ADDR = 32'h30000000
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

    wire        io_clk;
    wire        io_rst_n;
    wire        input_rdy_w;
    wire        input_vld_w;
    wire [15:0] input_data_w;
    wire        output_rdy_w;
    wire        output_vld_w;
    wire [ 7:0] output_data_w;

    assign user_irq = 3'b0;

    assign io_clk             = io_in[19];
    assign io_rst_n           = io_in[0];
    assign input_data_w[15:0] = io_in[16:1];
    assign input_vld_w        = io_in[17];
    assign output_rdy_w       = io_in[18];

    assign io_out[27:20] = output_data_w[7:0];
    assign io_out[28]    = output_vld_w;
    assign io_out[29]    = input_rdy_w;

    assign io_out[`MPRJ_IO_PADS-1:30] = 8'b0;
    assign io_out[19:0] = 20'b0;
    assign io_oeb = {20'b0, {18{1'b1}}};
    
    assign la_data_out = 128'd0;
    

// ==============================================================================
// Wishbone control
// ==============================================================================

    wire        wbs_debug;
    wire        wbs_fsm_start;
    wire        wbs_fsm_done;

    wire        wbs_debug_synced;
    wire        wbs_fsm_start_synced;
    wire        wbs_fsm_done_synced;

    wire        wbs_mem_we;
    wire        wbs_mem_ren;
    wire [11:0] wbs_mem_addr;
    wire [31:0] wbs_mem_wdata;
    wire [31:0] wbs_mem_rdata;

    // clock/reset mux
    wire user_proj_clk;
    wire user_proj_rst_n;

    clock_mux #(2) clk_mux (
        .clk        ({io_clk, wb_clk_i}),
        .clk_select (wbs_debug ? 2'b01 : 2'b10),
        .clk_out    (user_proj_clk)
    );

    assign user_proj_rst_n = (wbs_debug) ? ~wb_rst_i : io_rst_n;

    wishbone_ctl #(
        .WISHBONE_BASE_ADDR(WISHBONE_BASE_ADDR)
    ) wbs_ctl_u0 (
        // wishbone input
        .wb_clk_i      (wb_clk_i     ),
        .wb_rst_i      (wb_rst_i     ),
        .wbs_stb_i     (wbs_stb_i    ),
        .wbs_cyc_i     (wbs_cyc_i    ),
        .wbs_we_i      (wbs_we_i     ),
        .wbs_sel_i     (wbs_sel_i    ),
        .wbs_dat_i     (wbs_dat_i    ),
        .wbs_adr_i     (wbs_adr_i    ),
        // wishbone output
        .wbs_ack_o     (wbs_ack_o    ),
        .wbs_dat_o     (wbs_dat_o    ),
        // output
        .wbs_debug     (wbs_debug    ),
        .wbs_fsm_start (wbs_fsm_start),
        .wbs_fsm_done  (wbs_fsm_done_synced),

        .wbs_mem_we    (wbs_mem_we   ),
        .wbs_mem_ren   (wbs_mem_ren  ),
        .wbs_mem_addr  (wbs_mem_addr ),
        .wbs_mem_wdata (wbs_mem_wdata),
        .wbs_mem_rdata (wbs_mem_rdata)
    );

// ==============================================================================
// IO Logic
// ==============================================================================

    accelerator acc_inst (
        .clk           (user_proj_clk   ),
        .rst_n         (user_proj_rst_n ),

        .input_rdy     (input_rdy_w     ),
        .input_vld     (input_vld_w     ),
        .input_data    (input_data_w    ),

        .output_rdy    (output_rdy_w    ),
        .output_vld    (output_vld_w    ),
        .output_data   (output_data_w   ),

        .wbs_debug     (wbs_debug_synced    ),
        .wbs_fsm_start (wbs_fsm_start_synced),
        .wbs_fsm_done  (wbs_fsm_done    ),

        .wbs_mem_we    (wbs_mem_we      ),
        .wbs_mem_ren   (wbs_mem_ren     ),
        .wbs_mem_addr  (wbs_mem_addr    ),
        .wbs_mem_wdata (wbs_mem_wdata   ),
        .wbs_mem_rdata (wbs_mem_rdata   )
    );

    SyncBit wbs_debug_sync (
        .sCLK  (wb_clk_i            ),
        .sRST  (~wb_rst_i           ),
        .dCLK  (io_clk              ),
        .sEN   (1'b1                ),
        .sD_IN (wbs_debug           ),
        .dD_OUT(wbs_debug_synced    )
    );

    SyncPulse wbs_fsm_start_sync (
        .sCLK  (wb_clk_i            ),
        .sRST  (~wb_rst_i           ),
        .dCLK  (io_clk              ),
        .sEN   (wbs_fsm_start       ),
        .dPulse(wbs_fsm_start_synced)
    );

    SyncBit wbs_fsm_done_sync (
        .sCLK  (io_clk              ),
        .sRST  (io_rst_n            ),
        .dCLK  (wb_clk_i            ),
        .sEN   (1'b1                ),
        .sD_IN (wbs_fsm_done        ),
        .dD_OUT(wbs_fsm_done_synced )
    );

endmodule

`default_nettype wire
