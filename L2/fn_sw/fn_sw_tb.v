`timescale 1ps/1ps
module fn_sw_tb;
reg a,b,sel;
wire y;
fn_sw fn_sw(
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

 /*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, fn_sw_tb);    //tb模块名称
    end
    /*iverilog */

initial begin
        a<=0;b<=0;sel<=0;
    #10 a<=0;b<=0;sel<=1;
    #10 a<=0;b<=1;sel<=0;
    #10 a<=0;b<=1;sel<=1;
    #10 a<=1;b<=0;sel<=0;
    #10 a<=1;b<=0;sel<=1;
    #10 a<=1;b<=1;sel<=0;
    #10 a<=1;b<=1;sel<=1;
    #10 $finish;
end

endmodule