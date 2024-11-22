`timescale 1ns/1ns
//////////////////////////////////////////////////////////////////////////////////
// Company:         njupt
// Engineer:       chuanqif
// 
// Create Date:   2024/11/21
// Project Name:    traffic light
// Design Name:     
// Target Devices:  
// Tool Versions:   vivado
// Description:     

// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input                               i_clk                      ,//100mhz
    input                               i_rst                      ,

    output                              led_1r                     ,
    output                              led_1y                     ,
    output                              led_1g                     ,
    output                              led_2r                     ,
    output                              led_2y                     ,
    output                              led_2g                     ,

    output             [   3: 0]        o_blink                    ,
    output             [   6: 0]        o_seg                       
);

/***************parameter*************/
parameter CNT_1S = 100_000_000;

parameter  st_idle = 5'b00001;
parameter  st_1r2g = 5'b00010;
parameter  st_1y2g = 5'b00100;
parameter  st_1g2r = 5'b01000;
parameter  st_1g2y = 5'b10000;


/***************reg*******************/
    reg                [  26: 0]        cnt_1s                     ;
    reg                [   3: 0]        cnt_15s                     ;

    reg                [   4: 0]        cur_state                  ;
    reg                [   4: 0]        next_state                 ;

    reg                [   3: 0]        i_wei1                     ;
    reg                [   3: 0]        i_wei2                     ;
    reg                [   3: 0]        i_wei3                     ;
    reg                [   3: 0]        i_wei4                     ;
/***************wire******************/

/***************assign****************/
assign led_1r = (cur_state == st_1r2g) ? 1'b1 : 1'b0;
assign led_1y = (cur_state == st_1y2g) ? 1'b1 : 1'b0;
assign led_1g = (cur_state == st_1g2r || cur_state == st_1g2y) ? 1'b1 : 1'b0;
assign led_2r = (cur_state == st_1g2r) ? 1'b1 : 1'b0;
assign led_2y = (cur_state == st_1g2y) ? 1'b1 : 1'b0;
assign led_2g = (cur_state == st_1r2g || cur_state == st_1y2g) ? 1'b1 : 1'b0;

/***************mechine***************/                                    

    always @(posedge i_clk or posedge i_rst)
        begin
            if(i_rst)
                cur_state <= st_idle;
            else
                cur_state <= next_state;
        end

    always @(*) begin
        case(cur_state)
            st_idle:
                begin
                    next_state = st_1r2g;
                end
            st_1r2g:
                begin
                    if(cnt_15s == 4'd6 && cnt_1s == CNT_1S - 1'd1)
                        next_state = st_1y2g;
                    else
                        next_state = st_1r2g;
                end
            st_1y2g:
                begin
                    if(cnt_15s == 4'd1 && cnt_1s == CNT_1S - 1'd1)
                        next_state = st_1g2r;
                    else
                        next_state = st_1y2g;
                end
            st_1g2r:
                begin
                    if(cnt_15s == 4'd6 && cnt_1s == CNT_1S - 1'd1)
                        next_state = st_1g2y;
                    else
                        next_state = st_1g2r;
                end
            st_1g2y:
                begin
                    if(cnt_15s == 4'd1 && cnt_1s == CNT_1S - 1'd1)
                        next_state = st_1r2g;
                    else
                        next_state = st_1g2y;
                end
            default: next_state= st_idle;
        endcase
    end
    
/***************always****************/

    always @(posedge i_clk or posedge i_rst)
        begin
            if(i_rst)
                cnt_1s <= 'd0;
            else if(cnt_1s == CNT_1S - 1'd1)
                cnt_1s <= 'd0;
            else
                cnt_1s <= cnt_1s + 1'd1;
        end

    always @(posedge i_clk or posedge i_rst)
        begin
            if(i_rst)
                cnt_15s <= 'd15;
            else if(cnt_15s == 4'd1 && cnt_1s == CNT_1S - 1'd1)
                cnt_15s <= 'd15;
            else if(cnt_1s == CNT_1S - 1'd1)
                cnt_15s <= cnt_15s - 1'd1;
            else
                cnt_15s <= cnt_15s;
        end


    always @(posedge i_clk or posedge i_rst)
        begin
            if(i_rst) begin
                i_wei1 <= 'd0;
                i_wei2 <= 'd0;
                i_wei3 <= 'd0;
                i_wei4 <= 'd0;
            end else if(cur_state == st_1r2g || cur_state == st_1y2g) begin
                case(cnt_15s)
                    'd15: begin i_wei4 <= 'd1; i_wei3 <= 'd5;i_wei2 <= 'd1; i_wei1 <= 'd0; end
                    'd14,'d13,'d12,'d11,'d10: begin   i_wei4 <= 'd1; i_wei3 <= (cnt_15s - 'd10);i_wei2 <= 'd0; i_wei1 <= (cnt_15s - 'd5); end
                    'd9,'d8,'d7,'d6: begin    i_wei4 <= 'd0; i_wei3 <= cnt_15s; i_wei2 <= 'd0; i_wei1 <= (cnt_15s-5);end
                    'd5,'d4,'d3,'d2,'d1: begin i_wei4 <= 'd0; i_wei3 <= cnt_15s; i_wei2 <= 'd0; i_wei1 <= cnt_15s;end
                    default: begin i_wei1 <= 'd0;i_wei2 <= 'd0;i_wei3 <= 'd0;i_wei4 <= 'd0;end
                endcase
            end else if(cur_state == st_1g2r || cur_state == st_1g2y) begin
                case(cnt_15s)
                    'd15: begin i_wei2 <= 'd1; i_wei1 <= 'd5;i_wei4 <= 'd1; i_wei3 <= 'd0; end
                    'd14,'d13,'d12,'d11,'d10: begin   i_wei2 <= 'd1; i_wei1 <= (cnt_15s - 'd10);i_wei4 <= 'd0; i_wei3 <= (cnt_15s - 'd5); end
                    'd9,'d8,'d7,'d6: begin    i_wei2 <= 'd0; i_wei1 <= cnt_15s; i_wei4 <= 'd0; i_wei3 <= (cnt_15s-5);end
                    'd5,'d4,'d3,'d2,'d1:begin i_wei2 <= 'd0; i_wei1 <= cnt_15s; i_wei4 <= 'd0; i_wei3 <= cnt_15s;end
                    default: begin i_wei1 <= 'd0;i_wei2 <= 'd0;i_wei3 <= 'd0;i_wei4 <= 'd0;end
                endcase
            end else begin
                i_wei1 <= i_wei1;
                i_wei2 <= i_wei2;
                i_wei3 <= i_wei3;
                i_wei4 <= i_wei4;
            end  
        end

/***************module****************/

segment segment_inst(
    .i_clk                              (i_clk                     ),
    .i_rst_n                            (!i_rst                   ), 
    .i_wei1                             (i_wei1                    ),
    .i_wei2                             (i_wei2                    ),
    .i_wei3                             (i_wei3                    ),
    .i_wei4                             (i_wei4                    ),
    .o_blink                            (o_blink                   ),
    .o_seg                              (o_seg                     ) 
);


endmodule