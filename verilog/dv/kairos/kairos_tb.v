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


`define INPUT_FIFO_WIDTH 16
`define OUTPUT_FIFO_WIDTH 16

`define INPUT_DATA_SIZE 24
`define OUTPUT_DATA_SIZE 24

`define NUM_CONFIGS 5
`define NUM_INSTRUCTIONS 126
`define TOTAL_INPUT_SIZE 120

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

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	localparam STANDBY = 2'd0;
	localparam STEP1   = 2'd1;
	localparam STEP2   = 2'd2;
	localparam STEP3   = 2'd3;

    reg                     [1:0] state;
    reg                    [11:0] input_adr_r;
    reg                           counter;
    reg                           fsm_start;
    integer                       file;

    reg  [`NUM_CONFIGS-1:0][15:0] config_r;
    reg                    [31:0] instr_memory[`NUM_INSTRUCTIONS-1:0];
    reg                    [31:0] input_memory[`TOTAL_INPUT_SIZE-1:0];

    reg                           clk;
    reg                           rst_n;

    wire                          input_rdy_w;
    reg                           input_vld_r;
    reg   [`INPUT_FIFO_WIDTH-1:0] input_data_r;

    reg                           output_rdy_r;
    wire                          output_vld_w;
    wire [`OUTPUT_FIFO_WIDTH-1:0] output_data_w;

    // input ports
    assign mprj_io[37]   = clk;
    assign mprj_io[36]   = rst_n;
    assign mprj_io[15:0] = input_data_r;
    assign mprj_io[16]   = input_vld_r;
    assign mprj_io[17]   = output_rdy_r;

    // output ports
    assign output_data_w = mprj_io[33:18];
    assign output_vld_w  = mprj_io[34];
    assign input_rdy_w   = mprj_io[35] & fsm_start;

	always #10 clk = ~clk;

	initial begin
        $readmemb("instr_data.txt", instr_memory);
        $readmemh("input_data.txt", input_memory);
        file = $fopen("output.txt", "w");

		clk          <= 0;
        rst_n        <= 0;

        state        <= STANDBY;
        counter      <= 0;
        fsm_start    <= 0;

        input_adr_r  <= 0;
        input_vld_r  <= 0;
        input_data_r <= 0;
        output_rdy_r <= 1;

        config_r[0]  <= `NUM_INSTRUCTIONS - 1;
        config_r[1]  <= `INPUT_DATA_SIZE - 1;
        config_r[2]  <= 16'h7d0;
        config_r[3]  <= `OUTPUT_DATA_SIZE - 1;
        config_r[4]  <= 16'h7e8;

		#350
        rst_n        <= 1;
        #150
        fsm_start    <= 1;
    end

    always @(posedge clk) begin
        case (state)
            STANDBY: begin
                if (input_rdy_w) begin
                    input_data_r <= config_r[input_adr_r]; 
                    input_adr_r  <= input_adr_r + 1;
                    input_vld_r  <= 1;

                    if (input_adr_r == `NUM_CONFIGS - 1) begin
                        state       <= STEP1;
                        input_adr_r <= 0;
                    end
                end
            end

            STEP1: begin
                if (input_rdy_w) begin
                    input_data_r <= instr_memory[input_adr_r][counter*16+:16]; 
                    input_adr_r  <= (counter == 1) ? input_adr_r + 1 : input_adr_r;
                    input_vld_r  <= (input_adr_r < `NUM_INSTRUCTIONS);
                    counter      <= counter + 1;

                    if (input_adr_r == `NUM_INSTRUCTIONS) begin
                        state       <= STEP2;
                        input_adr_r <= 0;
                        counter     <= 0;
                    end
                end
            end

            STEP2: begin
                if (input_rdy_w) begin
                    input_data_r <= input_memory[input_adr_r][counter*16+:16]; 
                    input_adr_r  <= (counter == 1) ? input_adr_r + 1 : input_adr_r;
                    input_vld_r  <= 1;
                    counter      <= counter + 1;

                    if (input_adr_r == `TOTAL_INPUT_SIZE) begin
                        state       <= STEP3;
                        input_vld_r <= 0;
                    end
                end
            end
        endcase

        if (output_vld_w) begin
            $fwrite(file, "%h\n", output_data_w);
        end
    end

	initial begin
		$dumpfile("kairos.vcd");
		$dumpvars(0, kairos_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (25) begin
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test Mega-Project IO Ports (GL) Completed");
		`else
			$display ("Monitor: Timeout, Test Mega-Project IO Ports (RTL) Completed");
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
		.FILENAME("kairos.hex")
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
