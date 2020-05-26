// claAdder.v
// Vincent Li
// 3/19/2019
`timescale 1ns / 1ps

module claAdder_4 (
    input wire [3 : 0] A, B,
    input wire Cin,
    output wire [3 : 0] S,
    output wire Cout
    );
    wire [3 : 0] cin; // carries
    wire [3 : 0] P, G;

    // propogate and generate
    assign P[0] = A[0] ^ B[0];
    assign P[1] = A[1] ^ B[1];
    assign P[2] = A[2] ^ B[2];
    assign P[3] = A[3] ^ B[3];
    assign G[0] = A[0] * B[0];
    assign G[1] = A[1] * B[1];
    assign G[2] = A[2] * B[2];
    assign G[3] = A[3] * B[3];
    // sums
    assign S[0] = P[0] ^ cin[0];
    assign S[1] = P[1] ^ cin[1];
    assign S[2] = P[2] ^ cin[2];
    assign S[3] = P[3] ^ cin[3];
    // carries
    assign cin[0] = Cin;
    assign cin[1] = G[0] + P[0]*cin[0];
    assign cin[2] = G[1] + P[1]*cin[1];
    assign cin[3] = G[2] + P[2]*cin[2];
    assign Cout = G[3] + P[3]*cin[3];
    
endmodule

module claAdder #(parameter integer WIDTH = 64) (
    input wire [WIDTH - 1 : 0] A, B,
    input wire Cin,
    output wire [WIDTH - 1 : 0] S,
    output wire Cout
    );
    // connecting wires
    wire [WIDTH / 4 - 1 : 0] cin, cout;
    // generating modules
    genvar i;
    generate
        for(i = 0; i < WIDTH / 4; i = i + 1) begin: build
            claAdder_4 claa (.A(A[(i+1)*4-1 : (i+1)*4-4]), .B(B[(i+1)*4-1 : (i+1)*4-4]), .Cin(cin[i]), .S(S[(i+1)*4-1 : (i+1)*4-4]), .Cout(cout[i]));   
        end
    endgenerate
    // connections
    assign cin[0] = Cin;
    assign Cout = cout[WIDTH / 4 - 1];
    assign cin[WIDTH / 4 - 1 : 1] = cout[WIDTH / 4 - 2 : 0];
    
endmodule
