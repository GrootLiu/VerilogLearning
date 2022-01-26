`timescale 1ns/10ps
module s_counter_tb;

reg clk,res;
wire[3:0] s_num;
s_counter s_counter(
    .clk(clk),
    .res(res),
    .s_num(s_num)
);

/*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, s_counter_tb);    //tb模块名称
    end
/*iverilog */

initial begin
        clk <= 0;
        res <= 0;
    #17 res <= 1;
    #10000 $finish;
end

always #5 clk <= ~clk;

endmodule