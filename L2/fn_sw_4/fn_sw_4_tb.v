`timescale 1ps/1ps
module fn_sw_4_tb; 
    reg[3:0] absel; 
    wire y;
    fn_sw_4 fn_sw_4(
        .a(absel[0]), 
        .b(absel[1]), 
        .sel(absel[3:2]), 
        .y(y)
        );
    /*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, fn_sw_4_tb);    //tb模块名称
    end
    /*iverilog */
    initial begin
            absel<=0;
        #200 $finish;
    end

    always #10 absel<=absel+1;

endmodule
