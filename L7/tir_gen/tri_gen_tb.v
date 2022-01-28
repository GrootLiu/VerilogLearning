`timescale 1ns/10ps
module tri_gen_tb ();

reg clk, rstn;
wire [8:0] d_out;

tri_gen U1(
    .clk(clk),
    .rstn(rstn),
    .d_out(d_out)
);

/*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, tri_gen_tb);    //tb模块名称
    end
/*iverilog */

initial begin
    clk <= 0;
    rstn <= 0;
    #17 rstn<=1;
    #20000 $finish;
end

always #5 clk <= ~clk;
endmodule //tri_gen_tb