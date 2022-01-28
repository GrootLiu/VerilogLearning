/*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, tb);    //tb模块名称
    end
/*iverilog */