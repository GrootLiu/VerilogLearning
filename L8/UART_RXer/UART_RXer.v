//2022-2-2
//串口接收模块
/*
 RX为串口输入
 data_out为接收到的串口字节(8位)
 每接受完成一个字节，en_data_out就产生一个同步脉冲
 用户见到en_data_out即可接收数
 波特率位4800，系统时钟频率24MHz
 
 状态一：空闲识别
 状态二：等起始位
 状态三：收b0
 ...
 状态十：收b7
 */
module UART_RXer (input wire clk,
                  input wire rstn,
                  input wire RX,
                  output reg en_data_out,    //输出使能端口
                  output reg[7:0] data_out);
    
    reg [7:0]   state;      //主状态机
    reg [12:0]  con;        //用于计算bit宽度
    reg [3:0]   con_bits;   //用于计算比特数
    
    reg RX_delay;           //RX的延时
    
    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            state       <= 0;
            con         <= 0;
            con_bits    <= 0;
            RX_delay    <= 0;
            data_out    <= 0;
            en_data_out <= 0;
        end
        else begin
            RX_delay <= RX;
            case(state)
                0://等空闲
                begin
                    if (con == 5000-1) begin
                        con <= 0;
                    end
                    else begin
                        con <= con+1;
                    end
                    if (con == 0) begin
                        if (RX) begin
                            con_bits <= con_bits+1;
                        end
                        else begin
                            con_bits <= 0;
                        end
                    end
                    if (con_bits == 12) begin //此时肯定处于空闲状态，要离开空闲状态
                        state <= 1;
                    end
                end
                1://等起始位
                begin
                    en_data_out <= 0;
                    if (~RX&RX_delay) begin
                        state <= 2;
                    end
                end
                2://收最低位b0
                begin
                    if (con == 7500-1) begin
                        data_out[0] <= RX;
                        state       <= 3;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                3://收最低位b1
                begin
                    if (con == 5000-1) begin
                        data_out[1] <= RX;
                        state       <= 4;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                4://收最低位b2
                begin
                    if (con == 5000-1) begin
                        data_out[2] <= RX;
                        state       <= 5;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                5://收最低位b3
                begin
                    if (con == 5000-1) begin
                        data_out[3] <= RX;
                        state       <= 6;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                6://收最低位b4
                begin
                    if (con == 5000-1) begin
                        data_out[4] <= RX;
                        state       <= 6;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                7://收最低位b5
                begin
                    if (con == 5000-1) begin
                        data_out[5] <= RX;
                        state       <= 8;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                8://收最低位b6
                begin
                    if (con == 5000-1) begin
                        data_out[6] <= RX;
                        state       <= 9;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                9://收最低位b7
                begin
                    if (con == 5000-1) begin
                        data_out[7] <= RX;
                        state       <= 10;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                10://产生使能脉冲
                begin
                    en_data_out <= 1;
                    state       <= 1;
                end
                default:
                begin
                    state       <= 0;
                    con         <= 0;
                    con_bits    <= 0;
                    en_data_out <= 0;
                end
            endcase
        end
    end
endmodule //UART_RXer
