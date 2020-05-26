// srclsAdder.v
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
module rca_X #(parameter integer X = 2) (
    // from assigment 1
    output wire [X - 1 : 0] sum, 
    output wire out,
    input wire [X - 1 : 0] a, b,
    input wire in
    );

    wire [X - 1 : 0] c_in, c_out;
    wire [X - 1 : 0] s;

    rca_1 M[X - 1 : 0] (.a(a), .b(b), .c_in(c_in), .sum(s), .c_out(c_out));
    // connecting wires
    // for c_in and c_out
    assign c_in[0] = in;
    assign out = c_out[X - 1];
    assign c_in[X - 1 : 1] = c_out[X - 2 : 0];
    // for sum
    assign sum[X - 1 : 0] = s[X - 1 : 0];
    
endmodule

// csAdder for 4 bits
module csAdder_X #(parameter integer X = 2) (
    input wire [X - 1 : 0] A, B,
    input wire Cin,
    output wire [X - 1 : 0] S,
    output wire Cout
    );
    // internal wires
    wire carry0out, carry1out;
    wire [X - 1 : 0] carry0S, carry1S;
    // instantiating both rca's
    rca_X #(.X(X)) carry0 (.a(A), .b(B), .in(1'b0), .sum(carry0S), .out(carry0out));
    rca_X #(.X(X)) carry1 (.a(A), .b(B), .in(1'b1), .sum(carry1S), .out(carry1out));
    // mux for carry out
    assign Cout = Cin ? carry1out : carry0out;
    // mux for sums
    assign S = Cin ? carry1S : carry0S;

endmodule

// 2 bits to 11 bits. 10 modules
module srlcsAdder #(parameter integer WIDTH = 64) (
    input wire [WIDTH - 1 : 0] A, B,
    input wire Cin,
    output wire [WIDTH - 1 : 0] S,
    output wire Cout
    );

    // internal wires
    wire [10 : 0] cin, cout;
    // generate
    genvar i, j;
    generate
        for(i = 0; i < 10; i = i + 1) begin
            // 
            for(j = i; j < i + 2; j = j + 1) begin: build
                // generate rca's and link to a mux
                
            end
            
        end
    endgenerate
    // connections
    assign cin[0] = Cin;
    assign Cout = cout[WIDTH / 4 - 1 : 0];
    assign cin[WIDTH / 4 - 1 : 1] = cout[WIDTH / 4 - 2 : 0];

endmodule
