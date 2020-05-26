// Filename: Vincent-Li-A1-Q3b-dec3x8.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Behavioral verilog description of a 3x8 decoder with 3 controls,
    E1, E2, and E3, and 3 inputs, A2, A1, A0.
    Every output will be high unless E1 and E2 are low and E3 is high.
    When the decoder is disabled, all outputs are 1.
    When enabled, only the i'th output is active (0) 
    and all other outputs are 1.
*/
module dec3x8 (
    input wire nE1, nE2, E3,
    input wire [2 : 0] A,
    output wire [7 : 0] nY
    );
    wire enable;

    assign enable = !nE1 && !nE2 && E3;

    assign nY[0] = nE1 || enable && !(!A[2] && !A[1] && !A[0]);
    assign nY[1] = nE1 || enable && !(!A[2] && !A[1] && A[0]);
    assign nY[2] = nE1 || enable && !(!A[2] && A[1] && !A[0]);
    assign nY[3] = nE1 || enable && !(!A[2] && A[1] && A[0]);
    assign nY[4] = nE1 || enable && !(A[2] && !A[1] && !A[0]);
    assign nY[5] = nE1 || enable && !(A[2] && !A[1] && A[0]);
    assign nY[6] = nE1 || enable && !(A[2] && A[1] && !A[0]);
    assign nY[7] = nE1 || enable && !(A[2] && A[1] && A[0]);

endmodule