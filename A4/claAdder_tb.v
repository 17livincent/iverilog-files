// claAdder_tb.v
// Vincent Li
// 3/27/2019
`timescale 1ns / 1ps

module claAdder_tb;
    parameter integer WIDTH = 64;
    reg [WIDTH - 1 : 0] A, B;
    reg Cin;
    wire [WIDTH - 1 : 0] S;
    wire Cout;
    
    claAdder #(.WIDTH(WIDTH)) M(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial
        begin
            // wrong
            A = 64'b101;
            B = 64'b101;
            Cin = 0;
            #1;
            $display("A = %b\nB = %b\nCin = %b\nS = %b\nCout = %b\n\n", A, B, Cin, S, Cout);
            // wrong
            A = 64'b1001;
            B = 64'b1001;
            Cin = 1;
            #1;
            $display("A = %b\nB = %b\nCin = %b\nS = %b\nCout = %b\n\n", A, B, Cin, S, Cout);
            
            A = 64'b111;
            B = 64'b111;
            Cin = 1;
            #1;
            $display("A = %b\nB = %b\nCin = %b\nS = %b\nCout = %b\n\n", A, B, Cin, S, Cout);
            
            A = 64'b11111;
            B = 64'b10000;
            Cin = 1;
            #1;
            $display("A = %b\nB = %b\nCin = %b\nS = %b\nCout = %b\n\n", A, B, Cin, S, Cout);
            
        end

endmodule
