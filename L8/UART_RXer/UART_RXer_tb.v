module UART_RXer_tb ();
    
    reg   clk,rstn;
    wire  RX;
    wire [7:0] data_out;
    wire en_data_out;
    
    //串口输入，包含8bit数据，16个1，一个起始位，一个结束位
    reg [25:0] RX_send;
    assign RX = RX_send;//连接RX
    reg [12:0] con;
    
    UART_RXer UART_RXer(//同名例化
    clk,
    rstn,
    RX,
    en_data_out,
    data_out
    );
    
    /*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, UART_RXer_tb);    //tb模块名称
    end
/*iverilog */

    initial begin
        clk     <= 0;
        rstn    <= 0;
        RX_send <= {1'b1, 8'haa, 1'b0, 16'hffff};
        con     <= 0;
        #17 rstn <= 1;
        #4000000 $finish;
    end
    
    always #5 clk <= ~clk;
    
    always @(posedge clk) begin
        if (con == 5000 - 1) begin
            con <= 0;
        end
        else begin
            con <= con + 1;
        end
        
        //进行循环移位
        if (con == 0) begin
            RX_send[24:0] <= RX_send[25:1];
            RX_send[25]   <= RX_send[0];
        end
    end
    
endmodule //UART_RXer_tb
