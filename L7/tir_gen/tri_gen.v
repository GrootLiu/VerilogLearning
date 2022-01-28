//2022-1-28
//最简单的状态机，三角波发生器
module tri_gen (input wire clk,
                input wire rstn,
                output reg[8:0] d_out);
    reg[1:0] state;//主状态机寄存器
    reg[7:0] con;//计数器，记录平顶周期个数
    
    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            state <= 0;
            d_out <= 0;
            con   <= 0;
        end
        else begin
            case (state)
                0 : begin //上升
                    d_out <= d_out+1;
                    if (d_out == 299) begin
                        state <= 1;
                    end
                end
                1 : begin//平顶
                    if (con == 200) begin
                        con   <= 0;
                        state <= 2;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
                2 : begin//下降
                    d_out <= d_out-1;
                    if (d_out == 1) begin
                        state <= 3;
                    end
                end
                3 : begin
                     if (con == 200) begin
                        con   <= 0;
                        state <= 0;
                    end
                    else begin
                        con <= con + 1;
                    end
                end
            endcase
        end
    end
endmodule //tri_gen
