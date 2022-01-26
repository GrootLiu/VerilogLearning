//---------------testbench------------------
`timescale 1ns/1ns
module nand_gate_tb; 
reg aa, bb; 
wire yy; 
nand_gate nand_gate(.A(aa), .B(bb), .Y(yy));
    
    /*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, nand_gate_tb);    //tb模块名称
    end
    /*iverilog */
    
    initial begin
        aa     <= 0;
        bb     <= 0;
        #10 aa <= 0;
        bb     <= 1;
        #10 aa <= 1;
        bb     <= 0;
        #10 aa <= 1;
        bb     <= 1;
        #10 aa <= 0;
        bb     <= 0;
        #10 $stop;
    end
endmodule
