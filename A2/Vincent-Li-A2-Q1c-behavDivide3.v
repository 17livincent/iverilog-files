// Filename: Vincent-Li-A2-Q1c-behavDivide3.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Behavioral verilog program that creates a linear iterative array.
    Data flow is from left to right. It takes in an input of an 
    unsigned binary number x, and outputs z, which are the bits 
    of the quotient when x is divided by 3.
*/

module behavDivide3_1 (
    input wire X,
    output wire Z,
    input wire Yp1, Yp0,
    output wire Yn1, Yn0
    );
    assign Z = (Yp1 & !Yp0) | (!Yp1 & Yp0 & X);
    assign Yn1 = (!Yp1 & Yp0 & !X) | (Yp1 & !Yp0 & X);
    assign Yn0 = !Yp0 & ((!Yp1 & X) | (Yp1 & !X));

endmodule

module behavDivide3 #(parameter integer WIDTH = 4) (
    input wire [WIDTH - 1 : 0] X,
    output wire [WIDTH - 1 : 0] Z,
    input wire [1 : 0] Yin,
    output wire [1 : 0] Yout
    );
    
    wire [WIDTH - 1 : 0] Yp1, Yp0, Yn1, Yn0;

    behavDivide3_1 M[WIDTH - 1 : 0] (.X(X), .Z(Z), .Yp1(Yp1), .Yp0(Yp0), .Yn1(Yn1), .Yn0(Yn0));

    assign Yp1[WIDTH - 1]  = Yin[1];
    assign Yp0[WIDTH - 1] = Yin[0];

    assign Yp1[WIDTH - 2 : 0] = Yn1[WIDTH - 1 : 1];
    assign Yp0[WIDTH - 2 : 0] = Yn0[WIDTH - 1 : 1];

    assign Yout[1] = Yn1[0];
    assign Yout[0] = Yn0[0];

endmodule    