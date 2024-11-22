/*  Function Description:
	Signal Description:
	|SIGNAL NAME|IO |FUNCTION   |WIDTH|
	|-----------|---|-----------|-----|



 -----------------------------------------------------------------------------
 Copyright (c) 2024-2024 All rights reserved
 -----------------------------------------------------------------------------
 Author : OuYang XiangQian (ZHE) norra1@zoho.com.cn
 File   : traffic_light_ver3.v
 Create : 2024-11-22
 Revise : 2024-11-22
 Editor : sublime text4, tab size (4)
 -----------------------------------------------------------------------------*/
module traff_light(
    input               sys_clk,  
    input               sys_clk_1ms,
    input               sys_rst_n,
    output reg  [2:0]   r_light1,
    output reg  [3:0]   r_light_t
    );

/* PARAMETER DEFINITION */

// TIME LENGTH DEFINITION
parameter G1_T = 'd10;
parameter Y1_T = 'd5;
parameter R1_T = 'd15;
// STATE DIFINITION
parameter IDLE = 'd0;
parameter G1   = 'd1;
parameter Y1   = 'd2;
parameter R1   = 'd3;


/* VARIABLE DEFINITION */
// INTERNAL REG
reg [3:0]   cur_state;
reg [3:0]   nxt_state;

reg [2:0]   r_light_tmp;

reg [3:0]   r_light_t_tmp;

reg [3:0]   timecont;

// State Register
always @(posedge sys_clk or posedge rst) begin
    if (sys_rst_n==1'b0) begin
        cur_state <= IDLE;
    end else begin
        cur_state <= nxt_state;
    end
end

// Next State Logic
always @(cur_state or sys_rst_n or timecont)
	if (sys_rst_n==1'b0) begin
        nxt_state <= IDLE;
    end else begin
        case(cur_state)
        	IDLE 	:
        	G1 		:
        	Y1 		:
        	R1 		:
            default: nxt_state <= IDLE;
        endcase
    end
end

// Output Logic
always @(posedge sys_clk or negedge sys_rst_n) begin
    if (sys_rst_n==1'b0) begin
        r_light_1_tmp <= 3'b0;
        r_light_t_tmp <= 4'd0;
        start <= 1'b0;
    end else begin
        case(cur_state)
            G1: begin
                r_light_tmp <= 3'b100;
                r_light_t_tmp <= G1_T;
            end
            Y1: begin
                r_light_tmp <= 3'b010;
                r_light_t_tmp <= Y1_T;
            end
            default: begin
                r_light_tmp <= 3'b0;
                r_light_t_tmp <= 4'd0;
            end
        endcase
    end
end
endmodule