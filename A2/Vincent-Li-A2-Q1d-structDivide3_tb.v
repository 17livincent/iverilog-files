// Filename: Vincent-Li-A2-Q1c-behavDivide3_tb.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Test bench for Vincent-Li-A2-Q1c-structDivide3.v
*/

module structDivide3_tb;
    parameter integer WIDTH = 4;
    reg [WIDTH - 1 : 0] X;
    reg [1 : 0] Yin;
    wire [WIDTH - 1 : 0] Z;
    wire [1 : 0] Yout;

    structDivide3 #(.WIDTH(WIDTH)) M(.X(X), .Yin(Yin), .Z(Z), .Yout(Yout));

    initial
        begin
            Yin = 2'b00;
            X = 0;
            repeat(WIDTH * WIDTH) begin
                //repeat(3) begin
                    #1 $display("X = %b\tYin = %b\tZ = %b\tYout = %b", X, Yin, Z, Yout);
                    //#1 Yin = Yin + 1;
                //end
                
                // increment X
                X = X + 1;
                // Reset Yin
                Yin = 2'b00;
                #1;

            end
            
        end

endmodule