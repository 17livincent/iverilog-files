// csAdder.v
// Vincent Li
// 3/19/2019
`timescale 1ns / 1ps

module rca_1 (
    // modified from assignment 1
    input wire a, b, c_in,
    output wire sum, c_out
    );
    assign sum = a ^ b ^ c_in;
    assign c_out = a * b + c_in * (a ^ b);
    
endmodule

// 4-bit rca
module rca_4 #(parameter integer WIDTH = 4) (
    // from assigment 1
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

// csAdder for 4 bits
module csAdder_4 (
    input wire [3 : 0] A, B,
    input wire Cin,
    output wire [3 : 0] S,
    output wire Cout
    );
    // internal wires
    wire carry0out, carry1out;
    wire [3 : 0] carry0S, carry1S;
    // instantiating both rca's
    rca_4 carry0[3 : 0] (.a(A), .b(B), .in(1'b0), .sum(carry0S), .out(carry0out));
    rca_4 carry1[3 : 0] (.a(A), .b(B), .in(1'b1), .sum(carry1S), .out(carry1out));
    // mux for carry out
    assign Cout = Cin ? carry1out : carry0out;
    // mux for sums
    assign S = Cin ? carry1S : carry0S;

endmodule


module csAdder #(parameter integer WIDTH = 64) (
    input wire [WIDTH - 1 : 0] A, B,
    input wire Cin,
    output wire [WIDTH - 1 : 0] S,
    output wire Cout
    );
    // internal wires
    wire [WIDTH / 4 - 1 : 0] cin, cout;
    // generate
    genvar i;
    generate
        for(i = 0; i < WIDTH / 4; i = i + 1) begin: build
            csAdder_4 csa(.A(A[(i+1)*4-1 : (i+1)*4-4]), .B(B[(i+1)*4-1 : (i+1)*4-4]), .Cin(cin[i]), .S(S[(i+1)*4-1 : (i+1)*4-4]), .Cout(cout[i]));   
        end
    endgenerate
    // connections
    assign cin[0] = Cin;
    assign Cout = cout[WIDTH / 4 - 1 : 0];
    assign cin[WIDTH / 4 - 1 : 1] = cout[WIDTH / 4 - 2 : 0];
    
endmodule
