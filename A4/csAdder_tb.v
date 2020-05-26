`timescale 1ns / 1ps
// csAdder_tb.v
// Vincent Li
// 3/26/2019


module csAdder_tb;
    parameter integer WIDTH = 64;
    reg [WIDTH - 1 : 0] A, B;
    reg Cin;
    wire [WIDTH - 1 : 0] S;
    wire Cout;

    csAdder #(.WIDTH(WIDTH)) adder(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    initial
        begin
            A = 0;
            B = 1;
            Cin = 1;
            #1;
            $display("A = %b\nB = %b\nCin = %b\nS = %b\nCout = %b", A, B, Cin, S, Cout);
            
            A = 1;
            B = 1;
            Cin = 0;
            #1;
            $display("A = %b\nB = %b\nCin = %b\nS = %b\nCout = %b", A, B, Cin, S, Cout);
            
            A = 240;
            B = 16;
            Cin = 0;
            #1;
            $display("A = %b\nB = %b\nCin = %b\nS = %b\nCout = %b", A, B, Cin, S, Cout);
            
            A = 240;
            B = 16;
            Cin = 1;
            #1;
            $display("A = %b\nB = %b\nCin = %b\nS = %b\nCout = %b", A, B, Cin, S, Cout);
            
        end
    
endmodule
