`timescale 1ps/1ps
module comp_conv_tb;
reg[7:0] a_in;
wire[7:0] y_out;
comp_conv comp_conv(
    .a(a_in),
    .a_comp(y_out)
);

/*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, comp_conv_tb);    //tb模块名称
    end
    /*iverilog */

initial begin
            a_in<=0;
    #2560   $finish;
end

always #10 a_in=a_in+1;

endmodule