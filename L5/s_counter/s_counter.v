//2022-1-25
//秒计数器，0-9循环
module s_counter (clk,
                  res,
                  s_num);
    
    input clk;
    input res;
    output[3:0] s_num;
    
    parameter frequency_clk = 24 ;//24MHz
    
    reg[24:0] con_t; //秒脉冲分频计数器
    reg s_pulse;//秒脉冲尖
    reg [3:0] s_num;//秒计数
    
    always @(posedge clk or negedge res)
    begin
        if (~res)
        begin//将所有的寄存器进行复位
            con_t   <= 0;
            s_pulse <= 0;
            s_num   <= 0;
        end
        else
        begin
            //计数器计数到24000000，满置一
            // if (con_t == frequency_clk*1000000 - 1)
            if (con_t == frequency_clk - 1)
            begin
                con_t <= 0;
                // $display("ok\n");
            end
            else
            begin
                con_t <= con_t+1;
            end
            
            //con_t每遇到counter为0时，产生一个上升沿
            if (con_t == 0)
            begin
                s_pulse <= 1;
            end
            else
            begin
                s_pulse <= 0;
            end
            
            //每次遇到s_pulse上升沿，秒计数器加一，满9置一
            if (s_pulse == 1)
            begin
                if (s_num == 9)
                begin
                    s_num <= 0;
                end
                else
                begin
                    s_num <= s_num+1;
                end
            end
        end
    end
endmodule