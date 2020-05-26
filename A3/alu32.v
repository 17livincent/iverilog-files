// Filename: alu32.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    32-bit ALU with inputs A and B, output D,
    4-bit select input S, Cin, and Cout
*/

module alu32 #(parameter integer WIDTH = 32) (
    input [3 : 0] S,
    input [WIDTH - 1 : 0] A, B,
    input Cin,
    output reg [WIDTH - 1 : 0] D,
    output reg Cout
    );
    
    reg [WIDTH : 0] d;

    always @(S, A, B, Cin) begin
        if(S == 4'b0000) begin
            // do nothing
        end
        else if(S == 4'b0001) begin
            d = A + B + Cin;
        end
        else if(S == 4'b0010) begin
            d = A - B + Cin;
        end
        else if(S == 4'b0011) begin
            d = A * B;
        end
        else if(S == 4'b0100) begin
            d = A / B;
        end
        else if(S == 4'b0101) begin
            d = A << 1;
            d[0] = Cin;
        end
        else if(S == 4'b0110) begin
            d = A >> 1;
        end
        else if(S == 4'b0111) begin
            d = A << 1;
            d[0] = d[WIDTH];
            d[WIDTH] = 0;
        end
        else if(S == 4'b1000) begin
            d[WIDTH] = d[0];
            d = A >> 1;
        end
        else if(S == 4'b1001) begin
            d = A & B;
        end
        else if(S == 4'b1010) begin
            d = A | B;
        end
        else if(S == 4'b1011) begin
            d = A ^ B;
        end
        else if(S == 4'b1100) begin
            d = ~A + ~B;
        end
        else if(S == 4'b1101) begin
            d = ~A & ~B;
        end
        else if(S == 4'b1110) begin
            if(A < B) d = 0;
            else begin
                d[WIDTH : 1] = 0;
                d[0] = 1;
            end
        end
        else if(S == 4'b1111) begin
            if(~A == B) d = 0;
            else begin
                d[WIDTH : 1] = 0;
                d[0] = 1;
            end
        end
    end

    always @(d) begin
        D = d[WIDTH - 1 : 0];
        Cout = d[WIDTH];
    end

endmodule