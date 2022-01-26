//---------------testbench------------------
`timescale 1ns/1ns
module nand_gate_4bits_tb; 
reg[3:0] aa, bb; 
wire[3:0] yy; 
nand_gate_4bits nand_gate_4bits
(
    .A(aa), 
    .B(bb), 
    .Y(yy)
    );
    
    /*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, nand_gate_4bits_tb);    //tb模块名称
    end
    /*iverilog */
    initial begin
        aa     <= 4'b0000;
        bb     <= 4'b1111;
        #10 aa <= 4'b0010;
        bb     <= 4'b0110;
        #10 aa <= 4'b0111;
        bb     <= 4'b0100;
        #10 aa <= 4'b0000;
        bb     <= 4'b1110;
        #10 $finish;
    end
endmodule
