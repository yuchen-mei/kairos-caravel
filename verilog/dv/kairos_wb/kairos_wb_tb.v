// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`define INPUT_WIDTH 16
`define OUTPUT_WIDTH 16

`define TOTAL_INPUT_SIZE 120
`define INPUT_DATA_SIZE 24
`define OUTPUT_DATA_SIZE 24

`define INSTR_WIDTH 32
`define NUM_INSTRUCTIONS 126

`define DATA_WIDTH 32
`define ADDR_WIDTH 16

`define CONFIG_WIDTH 16
`define NUM_CONFIGS 5

`default_nettype none

`timescale 1 ns / 1 ps

module kairos_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;

	wire gpio;
	wire [37:0] mprj_io;
	reg io_clk;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #50 clock  <= (clock === 1'b0);
	always #10 io_clk <= (io_clk === 1'b0);

	initial begin
		clock = 0;
		io_clk = 0;
	end

    reg    [`ADDR_WIDTH - 1 : 0] input_adr_r;

    wire                         input_rdy_w;
    reg                          input_vld_r;
    reg   [`INPUT_WIDTH - 1 : 0] input_data_r;

    reg                          output_rdy_r;
    wire                         output_vld_w;
    wire [`OUTPUT_WIDTH - 1 : 0] output_data_w;

    integer file;

    // input ports
    assign mprj_io[37]   = io_clk;
    assign mprj_io[36]   = RSTB;
    assign mprj_io[15:0] = input_data_r;
    assign mprj_io[16]   = input_rdy_w & input_vld_r;
    assign mprj_io[17]   = output_rdy_r;

    // output ports
    assign output_data_w = mprj_io[33:18];
    assign output_vld_w  = mprj_io[34];
    assign input_rdy_w   = mprj_io[35];

	// initial begin
    //     file = $fopen("output.txt", "w");
    // end

    // always @(posedge clock) begin
    //     if (output_vld_w) begin
    //         $fwrite(file, "%h\n", output_data_w);
    //     end
    // end

	initial begin
		$dumpfile("kairos_wb.vcd");
		$dumpvars(0, kairos_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (200) begin
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test Mega-Project IO Ports (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test Mega-Project IO Ports (RTL) Failed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#300000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("kairos_wb.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
