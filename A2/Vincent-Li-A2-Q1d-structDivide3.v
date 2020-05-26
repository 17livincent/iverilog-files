// Filename: Vincent-Li-A2-Q1c-structDivide3.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Structural version of Vincent-Li-A2-Q1c-behavDivide3.v
*/

module structDivide3_1 (
    input wire X,
    output wire Z,
    input wire Yp1, Yp0,
    output wire Yn1, Yn0
    );
    wire Z_bar, Yp1_bar, Yp0_bar, X_bar;
    wire w1, w2, w3, w4, w5;
    // nots
    not n0(Z_bar, Z);
    not n1(Yp1_bar, Yp1);
    not n2(Yp0_bar, Yp0);
    not n3(X_bar, X);
    // for Z
    and a0(w1, Yp1, Yp0_bar);
    and a1(w2, Yp1_bar, Yp0, X);
    or o0(Z, w1, w2);
    // for Yn1
    and a2(w3, Yp1_bar, Yp0, X_bar);
    and a3(w4, Yp1, Yp0_bar, X);
    or o1(Yn1, w3, w4);
    // for Yn0
    xor xo1(w5, Yp1, X);
    and a4(Yn0, Yp0_bar, w5);

endmodule

module structDivide3 #(parameter integer WIDTH = 4) (
    input wire [WIDTH - 1 : 0] X,
    output wire [WIDTH - 1 : 0] Z,
    input wire [1 : 0] Yin,
    output wire [1 : 0] Yout
    );
    
    wire [WIDTH - 1 : 0] Yp1, Yp0, Yn1, Yn0;

    structDivide3_1 M[WIDTH - 1 : 0] (.X(X), .Z(Z), .Yp1(Yp1), .Yp0(Yp0), .Yn1(Yn1), .Yn0(Yn0));

    assign Yp1[WIDTH - 1]  = Yin[1];
    assign Yp0[WIDTH - 1] = Yin[0];

    assign Yp1[WIDTH - 2 : 0] = Yn1[WIDTH - 1 : 1];
    assign Yp0[WIDTH - 2 : 0] = Yn0[WIDTH - 1 : 1];

    assign Yout[1] = Yn1[0];
    assign Yout[0] = Yn0[0];

endmodule    