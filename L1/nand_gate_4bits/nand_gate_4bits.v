//2022-1-12
//四位与非门
module nand_gate_4bits (A,
                        B,
                        Y);
    input[3:0]  A;
    input[3:0]  B;
    output[3:0] Y;
    
    assign Y = ~(A&B);
    
endmodule
