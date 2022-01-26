//2022-1-24
//计数器
module counter (clk,
                res,
                y);
    input clk;
    input res;
    output[7:0] y;
    
    reg[7:0] y;
    
    // wire[7:0] sum; //加一运算的结果
    // assign sum = y+1;//组合逻辑的的结果
    
    always @(posedge clk or negedge res) begin
        if (~res) begin
            y <= 0;
        end
        else begin
            y <= y+1;
        end
    end
    
endmodule
