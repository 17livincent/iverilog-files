// Filename: Vincent-Li-A1-Q3c-dec4x16.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    A 4x16 decoder composed of two 3x8 decoders (74HC138).
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

module dec4x16 (
    input wire nE1, nE2, E3,
    input wire [2 : 0] A,
    output wire [15 : 0] nY
    );
    wire E1, E2, nE3;
    assign E1 = !nE1;
    assign E2 = !nE2;
    assign nE3 = !E3;

    wire [7 : 0] nYFirstHalf, nYSecondHalf;
    assign nY[7 : 0] = nYFirstHalf;
    assign nY[15 : 8] = nYSecondHalf;

    // D1 for outputs 0 to 7.
    dec3x8 D1(.nE1(nE1), .nE2(nE2), .E3(E3), .A(A), .nY(nYFirstHalf));
    // D2 for outputs 8 t0 15. Enable is negated
    dec3x8 D2(.nE1(E1), .nE2(E2), .E3(nE3), .A(A), .nY(nYSecondHalf));

endmodule