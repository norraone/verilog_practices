`timescale 1ns / 1ps

module segment(
    input                               i_clk                      ,// ����ʱ���ź�
    input                               i_rst_n                    ,// �����λ�źţ�����Ч��
    input              [   3: 0]        i_wei1                     ,// �Jһλ���\
    input              [   3: 0]        i_wei2                     ,// �J��λ����
    input              [   3: 0]        i_wei3                     ,// �J��λ����
    input              [   3: 0]        i_wei4                     ,// �J��λ����
    output             [   3: 0]        o_blink                    ,// ����ܵĶ�ѡ�źţ�����ÿһλ����ʾ��
    output             [   6: 0]        o_seg                       // ����ܵ���ʾ�źţ�����ÿһλ����ʾ�ڏ���
    );
    
    // ��������ܸ�د���ֶ�Ӧ����ʾ��m
    parameter                           zero                      = 7'b100_0000; // ��ʾ0
    parameter                           one                       = 7'b111_1001; // ��ʾ1
    parameter                           two                       = 7'b010_0100; // ��ʾ2
    parameter                           three                     = 7'b011_0000; // ��ʾ3
    parameter                           fore                      = 7'b001_1001; // ��ʾ4
    parameter                           five                      = 7'b001_0010; // ��ʾ5
    parameter                           six                       = 7'b000_0010; // ��ʾ6
    parameter                           seven                     = 7'b111_1000; // ��ʾ7
    parameter                           eight                     = 7'b000_0000; // ��ʾ8
    parameter                           nine                      = 7'b001_0000; // ��ʾ9

    parameter                           TIMS                      = 1000  ;  // ʱ��������ļ���ֵ�����ڿ���ˢ��Ƶ�ʣ�

    reg                [   1: 0]        seg_sel                    ;// ��ǰѡ�е�������λ��0��3��
    reg                [   9: 0]        time_cnt                   ;// ʱ�������

    reg                [   3: 0]        re_blink                   ;// ��ǰλ�Ķ�ѡ�Ņ�
    reg                [   6: 0]        re_seg                     ;// ��ǰλ����ʾ�ڷ�

    // ����źŸ���
    assign                              o_seg                     = re_seg;// �������ʾ����
    assign                              o_blink                   = re_blink;// �����λѡ�Ņ�

    // ʱ�������
    always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n)
        begin
            time_cnt <= 10'd0;                                      // �����λ��ދ�������
        end
        else if(time_cnt == TIMS - 1)
        begin
            time_cnt <= 10'd0;                                      // �ﵽ����ֵʱ����
        end
        else
        begin
            time_cnt <= time_cnt + 1;                               // �����������1
        end
    end

    // �����λѡ��
    always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n)
        begin
            seg_sel <= 2'd0;                                        // �����λ��λѡ���ź�����
        end
        else if(time_cnt == TIMS - 1)
        begin
            if(seg_sel == 2'd3)
            begin
                seg_sel <= 2'd0;                                    // ѡ���źŏܫx
            end
            else
            begin
                seg_sel <= seg_sel + 1;                             // �����a��
            end
        end
        else
        begin
            seg_sel <= seg_sel;                                     // ����c��ދ��ֵ���򱣳ֲ���
        end
    end

    // �������ʾ����
    always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n)
        begin
            re_seg <= 7'b0000000;                                   // �����λ����ʾ�������
        end
        else
        begin
            case (seg_sel)
            2'd0:  case(i_wei1)                                     // ѡ��Jһد����
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
            2'd1:  case(i_wei2)                                     // ѡ��J��������
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
            2'd2:  case(i_wei3)                                     // ѡ��J��������
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
            2'd3:  case(i_wei4)                                     // ѡ��J�ĸ�����
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
            default: re_seg <= 7'b0000000;                          // Ĭ�Ƃ�
            endcase
        end
    end

    // �����λѡ�Ņ�
    always @(posedge i_clk or negedge i_rst_n)
    begin
        if(!i_rst_n)
        begin
            re_blink <= 4'b1111;                                    // �����λ���Mѡ�ź�ȫ��
        end
        else
        begin
            case (seg_sel)
                2'd0: re_blink <= 4'b1110;                          // ����ʾ�Jһʹ
                2'd1: re_blink <= 4'b1101;                          // ����ʾ�J��λ
                2'd2: re_blink <= 4'b1011;                          // ����ʾ�J��λ
                2'd3: re_blink <= 4'b0111;                          // ����ʾ�J��λ
                default: re_blink <= 4'b1111;                       // Ĭ�Ƃ�
            endcase
        end
    end

endmodule