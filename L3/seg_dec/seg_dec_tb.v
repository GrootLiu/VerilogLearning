`timescale 1ps/1ps
module seg_dec_tb;
reg [3:0] a_in;
wire [6:0] y_out;

seg_dec seg_dec(
    .num(a_in),
    .a_g(y_out)
);

/*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, seg_dec_tb);    //tb模块名称
    end
/*iverilog */

initial begin
        a_in<=0;
    #128 $finish;
end
always #10 a_in<=a_in+1;

endmodule