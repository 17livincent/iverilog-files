module behavDivide3_1_tb;
    reg X;
    reg [1 : 0] Yin;
    wire Z;
    wire [1 : 0] Yout;

    behavDivide3_1 M(.X(X), .Yp1(Yin[1]), .Yp0(Yin[0]), .Z(Z), .Yn1(Yout[1]), .Yn0(Yout[0]));

    initial
        begin
            Yin = 2'b00;
            X = 0;
            repeat(2) begin
                repeat(3) begin
                    #1 $display("X = %b\tYin = %b\tZ = %b\tYout = %b", X, Yin, Z, Yout);
                    #1 Yin = Yin + 1;
                end
                
                // increment X
                X = X + 1;
                // Reset Yin
                Yin = 2'b00;

            end
            
        end

endmodule