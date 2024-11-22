`timescale 1ns / 1ps

module segment(
    input                               i_clk                      ,// 输入时钟信号
    input                               i_rst_n                    ,// 异濥忍位信号（低有效＿
    input              [   3: 0]        i_wei1                     ,// 笿一位数孿
    input              [   3: 0]        i_wei2                     ,// 笿二位数字
    input              [   3: 0]        i_wei3                     ,// 笿三位数字
    input              [   3: 0]        i_wei4                     ,// 笿四位数字
    output             [   3: 0]        o_blink                    ,// 数码管的段选信号（控制每一位的显示＿
    output             [   6: 0]        o_seg                       // 数码管的显示信号（控制每一位的显示内忹）
    );
    
    // 定义数码管各丿数字对应的显示编砿
    parameter                           zero                      = 7'b100_0000; // 显示0
    parameter                           one                       = 7'b111_1001; // 显示1
    parameter                           two                       = 7'b010_0100; // 显示2
    parameter                           three                     = 7'b011_0000; // 显示3
    parameter                           fore                      = 7'b001_1001; // 显示4
    parameter                           five                      = 7'b001_0010; // 显示5
    parameter                           six                       = 7'b000_0010; // 显示6
    parameter                           seven                     = 7'b111_1000; // 显示7
    parameter                           eight                     = 7'b000_0000; // 显示8
    parameter                           nine                      = 7'b001_0000; // 显示9

    parameter                           TIMS                      = 1000  ;  // 时间计数器的计数值（用于控制刷新频率＿

    reg                [   1: 0]        seg_sel                    ;// 当前选中的数码翡位＿0刿3＿
    reg                [   9: 0]        time_cnt                   ;// 时间计数噿

    reg                [   3: 0]        re_blink                   ;// 当前位的段选信叿
    reg                [   6: 0]        re_seg                     ;// 当前位的显示内忿

    // 输出信号赋倿
    assign                              o_seg                     = re_seg;// 数码管显示内宿
    assign                              o_blink                   = re_blink;// 数码管位选信叿

    // 时间计数噿
    always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n)
        begin
            time_cnt <= 10'd0;                                      // 异濥忍位，迡数器清雿
        end
        else if(time_cnt == TIMS - 1)
        begin
            time_cnt <= 10'd0;                                      // 达到计数值时清零
        end
        else
        begin
            time_cnt <= time_cnt + 1;                               // 否则计数器加1
        end
    end

    // 数码管位选择
    always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n)
        begin
            seg_sel <= 2'd0;                                        // 异濥忍位，位选择信号清零
        end
        else if(time_cnt == TIMS - 1)
        begin
            if(seg_sel == 2'd3)
            begin
                seg_sel <= 2'd0;                                    // 选择信号徿玿
            end
            else
            begin
                seg_sel <= seg_sel + 1;                             // 否则臿墿
            end
        end
        else
        begin
            seg_sel <= seg_sel;                                     // 如果朿到迡数值，则保持不叿
        end
    end

    // 数码管显示内宿
    always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n)
        begin
            re_seg <= 7'b0000000;                                   // 异濥忍位，显示内容清雿
        end
        else
        begin
            case (seg_sel)
            2'd0:  case(i_wei1)                                     // 选择笿一丿数字
                 4'd0:  re_seg <= zero;
                 4'd1:  re_seg <= one;
                 4'd2:  re_seg <= two;
                 4'd3:  re_seg <= three;
                 4'd4:  re_seg <= fore;
                 4'd5:  re_seg <= five;
                 4'd6:  re_seg <= six;
                 4'd7:  re_seg <= seven;
                 4'd8:  re_seg <= eight;
                 4'd9:  re_seg <= nine;
                 default : re_seg <= 7'b0000000;
                 endcase
            2'd1:  case(i_wei2)                                     // 选择笿二个数字
                 4'd0:  re_seg <= zero;
                 4'd1:  re_seg <= one;
                 4'd2:  re_seg <= two;
                 4'd3:  re_seg <= three;
                 4'd4:  re_seg <= fore;
                 4'd5:  re_seg <= five;
                 4'd6:  re_seg <= six;
                 4'd7:  re_seg <= seven;
                 4'd8:  re_seg <= eight;
                 4'd9:  re_seg <= nine;
                 default : re_seg <= 7'b0000000;
                 endcase
            2'd2:  case(i_wei3)                                     // 选择笿三个数字
                 4'd0:  re_seg <= zero;
                 4'd1:  re_seg <= one;
                 4'd2:  re_seg <= two;
                 4'd3:  re_seg <= three;
                 4'd4:  re_seg <= fore;
                 4'd5:  re_seg <= five;
                 4'd6:  re_seg <= six;
                 4'd7:  re_seg <= seven;
                 4'd8:  re_seg <= eight;
                 4'd9:  re_seg <= nine;
                 default : re_seg <= 7'b0000000;
                 endcase
            2'd3:  case(i_wei4)                                     // 选择笿四个数字
                 4'd0:  re_seg <= zero;
                 4'd1:  re_seg <= one;
                 4'd2:  re_seg <= two;
                 4'd3:  re_seg <= three;
                 4'd4:  re_seg <= fore;
                 4'd5:  re_seg <= five;
                 4'd6:  re_seg <= six;
                 4'd7:  re_seg <= seven;
                 4'd8:  re_seg <= eight;
                 4'd9:  re_seg <= nine;
                 default : re_seg <= 7'b0000000;
                 endcase
            default: re_seg <= 7'b0000000;                          // 默迤倿
            endcase
        end
    end

    // 数码管位选信叿
    always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n)
        begin
            re_blink <= 4'b1111;                                    // 异濥忍位，濵选信号全亿
        end
        else
        begin
            case (seg_sel)
                2'd0: re_blink <= 4'b1110;                          // 叿显示笿一使
                2'd1: re_blink <= 4'b1101;                          // 叿显示笿二位
                2'd2: re_blink <= 4'b1011;                          // 叿显示笿三位
                2'd3: re_blink <= 4'b0111;                          // 叿显示笿四位
                default: re_blink <= 4'b1111;                       // 默迤倿
            endcase
        end
    end

endmodule