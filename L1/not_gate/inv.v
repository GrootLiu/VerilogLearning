//2022-1-6
//反相器设计
module inv (A,
            Y);
    //定义端口属性
    input A;
    output A;
    //assign定义输入输出关系
    assign Y = ~A;
endmodule
    //编译命令iverilog -o wave -y ./ inv.v int_tb.v
    //生成wave图像vvp wave
