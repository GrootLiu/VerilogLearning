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
                  output wire en_data_out,   //输出使能端口
                  output reg[7:0] data_out);
    
    reg[7:0] state;//主状态机
    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            state <= 0;
        end
            case(state)
                0://等空闲
                begin
                    
                end
                1:
                begin
                    
                end
                2:
                begin
                    
                end
                3:
                begin
                    
                end
                4:
                begin
                    
                end
                5:
                begin
                    
                end
                6:
                begin
                    
                end
                7:
                begin
                    
                end
                8:
                begin
                    
                end
                9:
                begin
                    
                end
                10:
                begin
                    
                end
            endcase
    end
endmodule //UART_RXer
