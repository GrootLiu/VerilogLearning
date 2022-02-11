/*
 *  ┌───┐   ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┬───┐ ┌───┬───┬───┐
 *  │Esc│   │ F1│ F2│ F3│ F4│ │ F5│ F6│ F7│ F8│ │ F9│F10│F11│F12│ │P/S│S L│P/B│  ┌┐    ┌┐    ┌┐
 *  └───┘   └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┴───┘ └───┴───┴───┘  └┘    └┘    └┘
 *  ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐ ┌───┬───┬───┐ ┌───┬───┬───┬───┐
 *  │~ `│! 1│@ 2│# 3│$ 4│% 5│^ 6│& 7│* 8│( 9│) 0│_ -│+ =│ BacSp │ │Ins│Hom│PUp│ │N L│ / │ * │ - │
 *  ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤ ├───┼───┼───┤ ├───┼───┼───┼───┤
 *  │ Tab │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │{ [│} ]│ | \ │ │Del│End│PDn│ │ 7 │ 8 │ 9 │   │
 *  ├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤ └───┴───┴───┘ ├───┼───┼───┤ + │
 *  │ Caps │ A │ S │ D │ F │ G │ H │ J │ K │ L │: ;│" '│ Enter  │               │ 4 │ 5 │ 6 │   │
 *  ├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────────┤     ┌───┐     ├───┼───┼───┼───┤
 *  │ Shift  │ Z │ X │ C │ V │ B │ N │ M │< ,│> .│? /│  Shift   │     │ ↑ │     │ 1 │ 2 │ 3 │   │
 *  ├─────┬──┴─┬─┴──┬┴───┴───┴───┴───┴───┴──┬┴───┼───┴┬────┬────┤ ┌───┼───┼───┐ ├───┴───┼───┤ E││
 *  │ Ctrl│    │Alt │         Space         │ Alt│    │    │Ctrl│ │ ← │ ↓ │ → │ │   0   │ . │←─┘│
 *  └─────┴────┴────┴───────────────────────┴────┴────┴────┴────┘ └───┴───┴───┘ └───────┴───┴───┘
 *
 * @Author: Groot
 * @Date: 2022-02-10 12:30:20
 * @LastEditTime: 2022-02-11 10:00:20
 * @LastEditors: Groot
 * @Description:
 * @FilePath: /groot/VerilogLearning/L9/UART_TXer/UART_TXer.v
 * 版权声明
 */

//串口发送模块
module UART_TXer (input wire clk,
                  input wire rst,
                  input wire en_data_in,    //输出使能信号
                  input wire [7:0] data_in, //准备发送的数据
                  output wire TX,
                  output reg rdy);          //空闲标志，0表示空闲
    
    reg state;                        //主状态机寄存器
    reg [9:0] send_buff;                    //发送寄存器
    
    assign TX = send_buff[0];               //连接TX
    
    reg [9:0] send_flag;                    //用于判断右移结束
    
    reg [12:0] con;                         //用于计算波特周期
    
    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            state     <= 0;
            send_buff <= 1;
            send_flag <= 10'b10_0000_0000;
            con       <= 0;
            rdy       <= 0;
        end
        else begin
            case (state)
                0 : //等待使能信号
                begin
                    if (en_data_in) begin
                        send_buff <= {1'b1,data_in,1'b0};
                        send_flag <= 10'b10_0000_0000;
                        rdy       <= 1;
                        state     <= 1;
                    end
                end
                1 : //串口发送，寄存器右移
                begin
                    if (con == 5000 - 1) begin
                        send_buff[8:0] <= send_buff[9:1];
                        send_flag[8:0] <= send_flag[9:1];
                        con <= 0;
                    end
                    else begin
                        con <= con + 1;
                    end
                    //判断右移是否结束
                    if (send_flag[0] == 1'b1) begin
                        rdy   <= 0;
                        state <= 0;
                    end
                end
            endcase
        end
    end
endmodule //UART_TXer
