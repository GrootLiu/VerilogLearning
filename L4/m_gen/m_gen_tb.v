`timescale 1ns/10ps
module m_gen_tb;
reg clk, res;

wire y;

m_gen m_gen(
    .clk(clk),
    .res(res),
    .y(y)
);
/*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, m_gen_tb);    //tb模块名称
    end
/*iverilog */
initial begin
        clk <= 0;
        res <= 0;
    #17 res <= 1;
    #600 $finish;
end
always #5 clk<=~clk;
endmodule