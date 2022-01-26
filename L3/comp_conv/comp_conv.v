//2022-1-24
//补码转换逻辑
module comp_conv(a,
                 a_comp);
    input[7:0] a;
    output[7:0] a_comp;


    // wire[6:0] b; //按位取反的幅度位
    wire[7:0] y;//负数的补码
    // assign b      = ~a[6:0];
    assign y[6:0] = ~a[6:0]+1;//按位取反加一
    // assign y[7]   = a[7];//符号位不变
    assign y = {a[7],y[6:0]};
    
    assign a_comp=a[7]?y:a;
endmodule
