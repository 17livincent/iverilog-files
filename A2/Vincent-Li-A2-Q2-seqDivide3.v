// Filename: Vincent-Li-A2-Q1c-seqDivide3.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Moore type finite state machine that has a 1-bit primary input X 
    and 1-bit primary output Z.  It can recieve an arbitrarily long 
    input sequence of bits as X (MSB first).
*/

module seqDivide3_1 (
    input X,
    input reset,
    input clock,
    output reg Z
    );
    reg [1 : 0] Sp, Sn;
    // state parameters
    parameter s0 = 2'b00;
    parameter s1 = 2'b01;
    parameter s2 = 2'b10;

    // next state logic
    always @(*) begin
        if(Sp == s0 && X == 0) Sn <= s0;
        else if(Sp == s0 && X == 1) Sn <= s1;
        else if(Sp == s1 && X == 0) Sn <= s2;
        else if(Sp == s1 && X == 1) Sn <= s0;
        else if(Sp == s2 && X == 0) Sn <= s1;
        else if(Sp == s2 && X == 1) Sn <= s2;
    end

    // state update
    always @(posedge clock, posedge reset) begin
        if(reset) Sp <= s0;
        else Sp <= Sn;
    end

    // output logic
    always @(*) begin
        if(Sp == s0 && X == 0) Z = 0;
        else if(Sp == s0 && X == 1) Z = 0;
        else if(Sp == s1 && X == 0) Z = 0;
        else if(Sp == s1 && X == 1) Z = 1;
        else if(Sp == s2 && X == 0) Z = 0;
        else if(Sp == s2 && X == 1) Z = 1;
    end

endmodule

module seqDivide3 #(parameter integer WIDTH = 4) (
    input [WIDTH - 1 : 0] X,
    input reset,
    input clock,
    output reg [WIDTH - 1 : 0] Z
    );
    integer i;
    reg x;
    reg z;

    seqDivide3_1 M(.X(x), .reset(reset), .clock(clock), .Z(z));

    for(i = WIDTH - 1; i >= 0; i = i - 1) begin
        assign x = X[i];
        assign Z[i] = z;
    end

endmodule