/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include <defs.h>
#include <stub.c>

#define reg_mprj_wbs_debug     (*(volatile uint32_t*)0x30000000)
#define reg_mprj_wbs_fsm_start (*(volatile uint32_t*)0x30000004)
#define reg_mprj_wbs_fsm_done  (*(volatile uint32_t*)0x30000008)
#define reg_mprj_wbs_mem_addr  ((volatile uint32_t*)0x30010000)

/*
	IO Test:
		- Configures MPRJ lower 8-IO pins as outputs
		- Observes counter value through the MPRJ lower 8 IO pins (in the testbench)
*/

void main()
{
	/* 
	IO Control Registers
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 3-bits | 1-bit | 1-bit | 1-bit  | 1-bit  | 1-bit | 1-bit   | 1-bit   | 1-bit | 1-bit | 1-bit   |

	Output: 0000_0110_0000_1110  (0x1808) = GPIO_MODE_USER_STD_OUTPUT
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 110    | 0     | 0     | 0      | 0      | 0     | 0       | 1       | 0     | 0     | 0       |
	
	 
	Input: 0000_0001_0000_1111 (0x0402) = GPIO_MODE_USER_STD_INPUT_NOPULL
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 001    | 0     | 0     | 0      | 0      | 0     | 0       | 0       | 0     | 1     | 0       |

	*/

	/* Set up the housekeeping SPI to be connected internally so	*/
	/* that external pin changes don't affect it.			*/

    reg_spi_enable = 1;
    reg_wb_enable = 1;
    // reg_spimaster_cs = 0x10001;
    // reg_spimaster_control = 0x0801;

    // reg_spimaster_control = 0xa002;	// Enable, prescaler = 2,
                                        // connect to housekeeping SPI

    // Connect the housekeeping SPI to the SPI master
    // so that the CSB line is not left floating.  This allows
    // all of the GPIO pins to be used for user functions.

    // Configure lower 8-IOs as user output
    // Observe counter value in the testbench
	reg_mprj_io_37 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_36 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_35 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_34 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_33 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_32 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_31 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_30 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_29 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_28 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_27 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_26 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_25 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_24 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_23 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_22 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_21 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_20 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_19 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_18 = GPIO_MODE_USER_STD_OUTPUT;
    reg_mprj_io_17 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_16 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_15 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_14 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_13 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_12 = GPIO_MODE_USER_STD_INPUT_NOPULL; 
    reg_mprj_io_11 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_10 = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_9  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_8  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_7  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_6  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_5  = GPIO_MODE_USER_STD_INPUT_NOPULL;  
    reg_mprj_io_4  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_3  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_2  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_1  = GPIO_MODE_USER_STD_INPUT_NOPULL;
    reg_mprj_io_0  = GPIO_MODE_USER_STD_INPUT_NOPULL;

	/* Apply configuration */
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1);

    // configure all LA as output
    reg_la0_oenb = reg_la0_iena = 0xFFFFFFFF;    // [31:0]
    reg_la1_oenb = reg_la1_iena = 0xFFFFFFFF;    // [63:32]
    reg_la2_oenb = reg_la2_iena = 0xFFFFFFFF;    // [95:64]
    reg_la3_oenb = reg_la3_iena = 0xFFFFFFFF;    // [127:96]

    reg_la0_data = 0x00000000;
    reg_la1_data = 0x00000000;
    reg_la2_data = 0x00000000;
    reg_la3_data = 0x00000000;

    reg_mprj_wbs_debug = 1;

    reg_mprj_wbs_mem_addr[2048] = 0b10000110111000000000000100000111;
    reg_mprj_wbs_mem_addr[2049] = 0b10000110111100000000100000000111;
    reg_mprj_wbs_mem_addr[2050] = 0b10000111000000000000100010000111;
    reg_mprj_wbs_mem_addr[2051] = 0b00111001000000001000000101010111;
    reg_mprj_wbs_mem_addr[2052] = 0b00111001000100010000000101010111;
    reg_mprj_wbs_mem_addr[2053] = 0b10000111000100000000000110000111;
    reg_mprj_wbs_mem_addr[2054] = 0b10000111001000000000100000000111;
    reg_mprj_wbs_mem_addr[2055] = 0b10000111001100000000100010000111;
    reg_mprj_wbs_mem_addr[2056] = 0b10000111010000000000100100000111;
    reg_mprj_wbs_mem_addr[2057] = 0b00111001000000001000000111010111;
    reg_mprj_wbs_mem_addr[2058] = 0b00111001000100010000000111010111;
    reg_mprj_wbs_mem_addr[2059] = 0b00111001001000011000000111010111;
    reg_mprj_wbs_mem_addr[2060] = 0b11001000000000000000001001010111;
    reg_mprj_wbs_mem_addr[2061] = 0b11001000000000000000010001010111;
    reg_mprj_wbs_mem_addr[2062] = 0b11001000000000000000011001010111;
    reg_mprj_wbs_mem_addr[2063] = 0b10000111010100000000100000000111;
    reg_mprj_wbs_mem_addr[2064] = 0b10000111011000000000100010000111;
    reg_mprj_wbs_mem_addr[2065] = 0b10000111011100000000100100000111;
    reg_mprj_wbs_mem_addr[2066] = 0b10000111100000000000101000000111;
    reg_mprj_wbs_mem_addr[2067] = 0b00111001010000010000100111010111;
    reg_mprj_wbs_mem_addr[2068] = 0b11001000000000000000101001010111;
    reg_mprj_wbs_mem_addr[2069] = 0b10000111100100000000101010000111;
    reg_mprj_wbs_mem_addr[2070] = 0b10000111101000000000101100000111;
    reg_mprj_wbs_mem_addr[2071] = 0b10000111101100000000101110000111;

    reg_mprj_wbs_mem_addr[2072] = 0b10100000000000000000011010100111;
    reg_mprj_wbs_mem_addr[2073] = 0b01111101000000000100011010000111;
    reg_mprj_wbs_mem_addr[2074] = 0b01111101100000000100011100000111;
    reg_mprj_wbs_mem_addr[2075] = 0b01111110000000000100011110000111;
    reg_mprj_wbs_mem_addr[2076] = 0b00000000000000011011110000001011;
    reg_mprj_wbs_mem_addr[2077] = 0b10011000110111000000110010001011;
    reg_mprj_wbs_mem_addr[2078] = 0b10100000001010101101000011010111;
    reg_mprj_wbs_mem_addr[2079] = 0b10100001100110101101000101010111;
    reg_mprj_wbs_mem_addr[2080] = 0b10100001100110111101000011010111;
    reg_mprj_wbs_mem_addr[2081] = 0b00000000111000011010000110001011;
    reg_mprj_wbs_mem_addr[2082] = 0b11000000000001101000110011010111;
    reg_mprj_wbs_mem_addr[2083] = 0b00000001100111000000110010001011;
    reg_mprj_wbs_mem_addr[2084] = 0b10010001100110101101110011010111;
    reg_mprj_wbs_mem_addr[2085] = 0b00100101100111001000110001010111;

    reg_mprj_wbs_mem_addr[2086] = 0b11000100000011000001110011010111;
    reg_mprj_wbs_mem_addr[2087] = 0b10100000011110101101001001010111;
    reg_mprj_wbs_mem_addr[2088] = 0b10100000010110101101001001010111;
    reg_mprj_wbs_mem_addr[2089] = 0b10100000100010110101001001010111;
    reg_mprj_wbs_mem_addr[2090] = 0b10100000100010101101001011010111;
    reg_mprj_wbs_mem_addr[2091] = 0b00101001100100110000001010001011;
    reg_mprj_wbs_mem_addr[2092] = 0b10010000100110101101110101010111;
    reg_mprj_wbs_mem_addr[2093] = 0b00101001100111010000001010001011;
    reg_mprj_wbs_mem_addr[2094] = 0b10100000100110101101001101010111;
    reg_mprj_wbs_mem_addr[2095] = 0b00111000101011000000001110001011;
    reg_mprj_wbs_mem_addr[2096] = 0b10100000100010101101001111010111;
    reg_mprj_wbs_mem_addr[2097] = 0b10010001100010101101110101010111;
    reg_mprj_wbs_mem_addr[2098] = 0b00111000101111010000001110001011;
    reg_mprj_wbs_mem_addr[2099] = 0b01000000101111000000010000001011;
    reg_mprj_wbs_mem_addr[2100] = 0b01000001100101001000010000001011;
    reg_mprj_wbs_mem_addr[2101] = 0b00000000110011000000110100001011;
    reg_mprj_wbs_mem_addr[2102] = 0b01000001100111010000010000001011;
    reg_mprj_wbs_mem_addr[2103] = 0b10100001010010000101010001010111;
    reg_mprj_wbs_mem_addr[2104] = 0b01001000110011000000010010001011;
    reg_mprj_wbs_mem_addr[2105] = 0b10100000101110101101010101010111;
    reg_mprj_wbs_mem_addr[2106] = 0b01011001100101100000010110001011;
    reg_mprj_wbs_mem_addr[2107] = 0b10100001010010000101011001010111;

    reg_mprj_wbs_mem_addr[2108] = 0b01001100111110000000110001010111;
    reg_mprj_wbs_mem_addr[2109] = 0b10000111110100000000110010000111;
    reg_mprj_wbs_mem_addr[2110] = 0b00000111100011001000000111100011;
    reg_mprj_wbs_mem_addr[2111] = 0b00100000010000100000110001010111;
    reg_mprj_wbs_mem_addr[2112] = 0b10100001010010001101110001010111;
    reg_mprj_wbs_mem_addr[2113] = 0b10100000001000000000110000100111;
    reg_mprj_wbs_mem_addr[2114] = 0b10100000001100000000110000000111;
    reg_mprj_wbs_mem_addr[2115] = 0b10100000010000000000110010000111;
    reg_mprj_wbs_mem_addr[2116] = 0b00000001100011001000110000001011;
    reg_mprj_wbs_mem_addr[2117] = 0b00000001100000100000111000001011;
    reg_mprj_wbs_mem_addr[2118] = 0b00000001100000111000111010001011;
    reg_mprj_wbs_mem_addr[2119] = 0b00000001100001010000111100001011;
    reg_mprj_wbs_mem_addr[2120] = 0b00001000000101111000111111010111;
    reg_mprj_wbs_mem_addr[2121] = 0b00001001111111100000000010001011;
    reg_mprj_wbs_mem_addr[2122] = 0b00010001111111101000000100001011;
    reg_mprj_wbs_mem_addr[2123] = 0b00000001111111110000110000001011;
    reg_mprj_wbs_mem_addr[2124] = 0b00000001100011000001110010001011;
    reg_mprj_wbs_mem_addr[2125] = 0b01011000000011001010110101010011;
    reg_mprj_wbs_mem_addr[2126] = 0b10010001100011010101110001010111;
    reg_mprj_wbs_mem_addr[2127] = 0b01011000000011001001110011010011;
    reg_mprj_wbs_mem_addr[2128] = 0b10000111110000000000110100000111;
    reg_mprj_wbs_mem_addr[2129] = 0b10010001101011001000110011010111;
    reg_mprj_wbs_mem_addr[2130] = 0b01011000000011001100110101010011;
    reg_mprj_wbs_mem_addr[2131] = 0b01011000000011001011110111010011;
    reg_mprj_wbs_mem_addr[2132] = 0b10010001100011011101110001010111;
    reg_mprj_wbs_mem_addr[2133] = 0b00111001100000001000110101010111;
    reg_mprj_wbs_mem_addr[2134] = 0b00000001101000011010000110001011;

    reg_mprj_wbs_mem_addr[2145] = 0b00100101110011100000111001010111;
    reg_mprj_wbs_mem_addr[2146] = 0b00100101110111101000111011010111;
    reg_mprj_wbs_mem_addr[2147] = 0b00100101111011110000111101010111;
    reg_mprj_wbs_mem_addr[2148] = 0b01010000010011110000010100001011;
    reg_mprj_wbs_mem_addr[2149] = 0b00111000010011101000001110001011;
    reg_mprj_wbs_mem_addr[2140] = 0b00100000010011100000001000001011;
    reg_mprj_wbs_mem_addr[2141] = 0b01011000010111110000010110001011;
    reg_mprj_wbs_mem_addr[2142] = 0b01000000010111101000010000001011;
    reg_mprj_wbs_mem_addr[2143] = 0b00101000010111100000001010001011;
    reg_mprj_wbs_mem_addr[2144] = 0b01100000011011110000011000001011;
    reg_mprj_wbs_mem_addr[2145] = 0b01001000011011101000010010001011;
    reg_mprj_wbs_mem_addr[2146] = 0b00110000011011100000001100001011;
    reg_mprj_wbs_mem_addr[2147] = 0b01111110100000000000000010100111;
    reg_mprj_wbs_mem_addr[2148] = 0b01111111000000000000000100100111;
    reg_mprj_wbs_mem_addr[2149] = 0b01111111100000000000000110100111;
    reg_mprj_wbs_mem_addr[2150] = 0b00000001100000000000000001100111;
    reg_mprj_wbs_mem_addr[2151] = 0b00100000000000000000000001010111;
    reg_mprj_wbs_mem_addr[2152] = 0b00100000000000000000000001010111;
    reg_mprj_wbs_mem_addr[2153] = 0b00100000000000000000000001010111;
    reg_mprj_wbs_mem_addr[2154] = 0b00100000000000000000000001010111;
    reg_mprj_wbs_mem_addr[2155] = 0b00100000000000000000000001010111;
    reg_mprj_wbs_mem_addr[2156] = 0b00100000000000000000000001010111;
    reg_mprj_wbs_mem_addr[2157] = 0b00100000000000000000000001010111;

    reg_mprj_wbs_mem_addr[2158] = 0b10111000110010111111111111101101;
    reg_mprj_wbs_mem_addr[2159] = 0b00111000101000110110000000111000;
    reg_mprj_wbs_mem_addr[2160] = 0b00111011011011011000000000000000;
    reg_mprj_wbs_mem_addr[2161] = 0b00111111100000000000000000000000;
    reg_mprj_wbs_mem_addr[2162] = 0b10110111101011000000010011111110;
    reg_mprj_wbs_mem_addr[2163] = 0b10111000000011100100000000000011;
    reg_mprj_wbs_mem_addr[2164] = 0b00110101000011101100101001101010;
    reg_mprj_wbs_mem_addr[2165] = 0b00110100100001100011011110111101;
    reg_mprj_wbs_mem_addr[2166] = 0b00111101110011001100110011001101;
    reg_mprj_wbs_mem_addr[2167] = 0b01000010000011000000000000000000;
    reg_mprj_wbs_mem_addr[2168] = 0b01000001000111001111010111000011;
    reg_mprj_wbs_mem_addr[2169] = 0b00111011101000111101011100001010;
    reg_mprj_wbs_mem_addr[2170] = 0b00110111110100011011011100010111;
    reg_mprj_wbs_mem_addr[2171] = 0b00110111010100011011011100010111;
    reg_mprj_wbs_mem_addr[2172] = 0b00111111000000000000000000000000;
    reg_mprj_wbs_mem_addr[2173] = 0b00000000000000000000001000000000;

    reg_mprj_wbs_fsm_start = 1;

    while (reg_mprj_wbs_fsm_done == 0);

    reg_mprj_wbs_mem_addr[2000] = 0x3bbc24c0;
    reg_mprj_wbs_mem_addr[2001] = 0xbb151d87;
    reg_mprj_wbs_mem_addr[2002] = 0xc11d21cc;
    reg_mprj_wbs_mem_addr[2003] = 0xA;
    reg_mprj_wbs_mem_addr[2004] = 0xB;
    reg_mprj_wbs_mem_addr[2005] = 0xC;
    reg_mprj_wbs_mem_addr[2006] = 0xD;
    reg_mprj_wbs_mem_addr[2007] = 0xE;

    reg_mprj_wbs_mem_addr[2008] = 0x3f7ffffd;
    reg_mprj_wbs_mem_addr[2009] = 0xba1011be;
    reg_mprj_wbs_mem_addr[2010] = 0x382233c6;
    reg_mprj_wbs_mem_addr[2011] = 0x3809634f;
    reg_mprj_wbs_mem_addr[2012] = 0x0;
    reg_mprj_wbs_mem_addr[2013] = 0x0;
    reg_mprj_wbs_mem_addr[2014] = 0x0;
    reg_mprj_wbs_mem_addr[2015] = 0x0;

    reg_mprj_wbs_mem_addr[2016] = 0xbcb943b7;
    reg_mprj_wbs_mem_addr[2017] = 0xbe07b428;
    reg_mprj_wbs_mem_addr[2018] = 0xbd4a4f00;
    reg_mprj_wbs_mem_addr[2019] = 0x0;
    reg_mprj_wbs_mem_addr[2020] = 0x0;
    reg_mprj_wbs_mem_addr[2021] = 0x0;
    reg_mprj_wbs_mem_addr[2022] = 0x0;
    reg_mprj_wbs_mem_addr[2023] = 0x0;

    uint32_t data = reg_mprj_wbs_mem_addr[2000];
    data = reg_mprj_wbs_mem_addr[2001];
    data = reg_mprj_wbs_mem_addr[2002];
    data = reg_mprj_wbs_mem_addr[2003];
    data = reg_mprj_wbs_mem_addr[2004];
    data = reg_mprj_wbs_mem_addr[2005];
    data = reg_mprj_wbs_mem_addr[2006];
    data = reg_mprj_wbs_mem_addr[2007];

    reg_mprj_wbs_fsm_start = 1;

    while (reg_mprj_wbs_fsm_done == 0);

}

