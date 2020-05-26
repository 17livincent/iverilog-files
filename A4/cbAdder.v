// cbAdder.v
// Vincent Li
// 3/19/2019
`timescale 1ns / 1ps
module cbAdder_unit ( // for 1 bit and without mux
    input wire A, B,
    input wire Cin,
    output wire P,
    output wire S,
    output wire Cout
    );
    wire G;
    // propogate and generate
    assign P = A ^ B;
    assign G = A * B;
    // carry out and sum
    assign Cout = G + P * Cin;
    assign S = A ^ B ^ Cin;
    
endmodule

// connecting for cbAdder_unit's with a mux
module cbAdder_4 (
    input wire [3 : 0] A, B,
    input wire Cin,
    output wire [3 : 0] S,
    output wire Cout
    );
    // internal wires
    wire [3 : 0] cin;
    wire [3 : 0] cout;
    wire [3 : 0] P;
    
    // instantiating 4 units
    cbAdder_unit four[3 : 0] (.A(A), .B(B), .Cin(cin), .P(P), .Cout(cout), .S(S));
    assign cin[0] = Cin;
    assign cin[3 : 1] = cout[2 : 0];
    assign Cout = (P[0] * P[1] * P[2] * P[3] == 1) ? Cin : cout[3];
    
endmodule

// connecting 16 cbAdder-4's
module cbAdder #(parameter integer WIDTH = 64) ( // WIDTH 4 for 4 bits, 16 for 16 bits
    input wire [WIDTH - 1 : 0] A, B,
    input wire Cin,
    output wire [WIDTH - 1 : 0] S,
    output wire Cout
    );
    
    wire [WIDTH / 4 - 1 : 0] cin, cout;
    
    genvar i;
    generate
        for(i = 0; i < WIDTH / 4; i = i + 1) begin: build
            cbAdder_4 cba (.A(A[(i+1)*4-1 : (i+1)*4-4]), .B(B[(i+1)*4-1 : (i+1)*4-4]), .Cin(cin[i]), .S(S[(i+1)*4-1 : (i+1)*4-4]), .Cout(cout[i]));   
        end
    endgenerate

    assign cin[0] = Cin;
    assign Cout = cout[WIDTH / 4 - 1];
    assign cin[WIDTH / 4 - 1 : 1] = cout[WIDTH / 4 - 2 : 0];
    
endmodule