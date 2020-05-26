// Filename: Vincent-Li-A2-Q1c-seqDivide3_tb.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Moore type finite state machine that has a 1-bit primary input X 
    and 1-bit primary output Z.  It can recieve an arbitrarily long 
    input sequence of bits as X (MSB first).
*/

module seqDivide3_tb;
    parameter integer WIDTH = 4;
    reg [WIDTH - 1 : 0] X;
    reg clock, reset;
    reg [WIDTH -1 : 0] Z;
    
    integer i;

    initial 
        begin
            X = 0;
            clock = 0;
            reset = 1;
            #1; 
            reset = 0;
            forever
                #1 clock = ~clock;
        end
    
    seqDivide3 M(.X(X), .clock(clock), .reset(reset), .Z(Z));

    initial
        begin
            x = #1 0;
            repeat(WIDTH * WIDTH) begin
                #1 $display("X = %b\tZ = %b", X, Z);
                X = X + 1;
                reset = 1;
                #1; 
                reset = 0;
            end
            $finish;
        end

endmodule