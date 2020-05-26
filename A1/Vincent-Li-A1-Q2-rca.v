// Filename: Vincent-Li-A1-Q2-rca.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Ripple carry adder using n full adders. 3 inputs and 2 inputs.
    Uses the parameter feature to make it general for any input size n.
*/

`include "gscl45nm.v"

module rca_1 (
    input wire a, b, c_in,
    output wire sum, c_out
    );
    wire AxorB, w1, w2;
    // for sum
    XOR2X1 xo1(a, AxorB, b);
    XOR2X1 x02(c_in, sum, AxorB);
    // for c_out
    AND2X1 a1(c_in, AxorB, w1);
    AND2X1 a2(a, b, w2);
    OR2X1 o1(w1, w2, c_out);

endmodule

module rca #(parameter integer WIDTH = 4) (
    output wire [WIDTH - 1 : 0] sum, 
    output wire out,
    input wire [WIDTH - 1 : 0] a, b,
    input wire in
    );

    wire [WIDTH - 1 : 0] c_in, c_out;
    wire [WIDTH - 1 : 0] s;

    rca_1 M[WIDTH - 1 : 0] (.a(a), .b(b), .c_in(c_in), .sum(s), .c_out(c_out));
    // connecting wires
    // for c_in and c_out
    assign c_in[0] = in;
    assign out = c_out[WIDTH - 1];
    assign c_in[WIDTH - 1 : 1] = c_out[WIDTH - 2 : 0];
    // for sum
    assign sum[WIDTH - 1 : 0] = s[WIDTH - 1 : 0];
    
endmodule