`timescale 1ps/1ps
module counter_tb;

reg clk,res;

wire [7:0] y;

counter counter(
    .clk(clk),
    .res(res),
    .y(y)
);
/*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, counter_tb);    //tb模块名称
    end
/*iverilog */
initial begin
        clk <= 0;
        res <= 0;
    #17 res <= 1;
    #6000 $finish;
end
always #5 clk<=~clk;
endmodule