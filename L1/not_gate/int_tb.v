`timescale 1ns/1ps
//-------testbench--------
module int_tb; 
reg aa; 
wire yy; 
inv inv (.A(aa), .Y(yy));
    
    /*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, int_tb);    //tb模块名称
    end
    /*iverilog */
    
    initial begin
        aa     <= 0;
        #10 aa <= 1;
        #10 aa <= 0;
        #10 aa <= 1;
        #10 $stop;
    end
endmodule
