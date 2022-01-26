//2022-1-24
//伪随机码发生器
module m_gen (clk,
              res,
              y);
    
    input clk;
    input res;
    output y;
    
    reg [3:0] d;
    assign y = d[0];
    
    always @(posedge clk or negedge res) begin
        if (~res) begin
            d <= 4'b1111;
        end
        else begin
            d[2:0] <= d[3:1];
            d[3] = d[3] +d[0];
        end
    end
    
endmodule
