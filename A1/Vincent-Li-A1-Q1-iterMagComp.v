// Filename: Vincent-Li-A1-Q1-iterMagComp.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Structural verilog module for a two-input, n-bit comparator.
    Design should be parameterized in terms of the
    word sizes of the operands. Test for n = 4.
*/

`include "gscl45nm.v"

// iterMagComp for 1 bit
module iterMagComp_1 (
    // input and output wires
    input wire a, b, 
    input wire pL, pE, pG,
    output wire nL, nE, nG
    );
    
    wire g_bar, e_bar, l_bar, a_bar, b_bar;
    wire w1, w2, w3, w4, w5, w6, w7;
    // nots
    not n1(g_bar, pG);
    not n2(e_bar, pE);
    not n3(l_bar, pL);
    not n4(a_bar, a);
    // for L = g_out[0]
    and a1(w1, e_bar, pL);
    xor xo1(w2, pE, pL);
    and a2(w3, w2, a_bar, b);
    or o1(w4, w1, w3);
    and a3(nL, g_bar, w4);
    // for E = g_out[1]
    xnor xn1(w5, a, b);
    and a4(nE, w5, g_bar, pE, l_bar);
    // for G = g_out[2]
    and a5(w6, pG, e_bar, l_bar);
    and a6(w7, g_bar, pE, l_bar, a, b_bar);
    or o2(nG, w6, w7);

endmodule

module iterMagComp #(parameter integer WIDTH = 4) (
    // input and output wires
    input wire [WIDTH - 1 : 0] a, b,
    input wire [2 : 0] in,
    output wire [2 : 0] out
    );
    // main input and output per module
    wire [WIDTH - 1 : 0] pL, pE, pG, nL, nE, nG;
    
    // instantiate 1-bit modules
    iterMagComp_1 M[WIDTH - 1 : 0] (.a(a), .b(b), .pL(pL), .pE(pE), .pG(pG), .nL(nL), .nE(nE), .nG(nG));
    // Input to iterMagComp[n-1]
    assign pL[WIDTH - 1] = in[0];
    assign pE[WIDTH - 1] = in[1];
    assign pG[WIDTH - 1] = in[2];
    // Connecting the output signal to cell 0
    assign out[0] = nL[0];
    assign out[1] = nE[0];
    assign out[2] = nG[0];
    // Connecting the intermediate signals
    assign pL[WIDTH - 2 : 0] = nL[WIDTH - 1 : 1];
    assign pE[WIDTH - 2 : 0] = nE[WIDTH - 1 : 1];
    assign pG[WIDTH - 2 : 0] = nG[WIDTH - 1 : 1];

endmodule