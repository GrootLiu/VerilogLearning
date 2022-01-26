//2022-1-10
//与非门
module nand_gate(A,
                 B,
                 Y);
    input A;
    input B;
    output Y;
    
    assign Y = ~(A&B);
endmodule
