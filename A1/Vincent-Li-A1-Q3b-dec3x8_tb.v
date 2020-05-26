// Filename: Vincent-Li-A1-Q3b-dec3x8.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Test bench for Vincent-Li-A1-Q1-dec3x8.v
*/
module dec3x8_tb;
    reg nE1, nE2, E3;
    reg [2 : 0] A;
    wire [7 : 0] nY;
    integer allCorrect = 1;

    dec3x8 M(.nE1(nE1), .nE2(nE2), .E3(E3), .A(A), .nY(nY));

    initial 
        begin 
            // nE1 = 1, nE2 = X, E3 = X
            nE1 = 1;
            #1;
            //$display("nE1 = %b\tnE2 = %b\tE3 = %b\tA2 = %b\tA1 = %b\tA0 = %b\t\tnY7 = %b\tnY6 = %b\tnY5 = %b\tnY4 = %b\tnY3 = %b\tnY2 = %b\tnY1 = %b\tnY0 = %b", nE1, nE2, E3, A[2], A[1], A[0], nY[7], nY[6], nY[5], nY[4], nY[3], nY[2], nY[1], nY[0]);
            if(nY[7] != 1 || nY[6] != 1 || nY[5] != 1 || nY[4] != 1 || nY[3] != 1 || nY[2] != 1 || nY[1] != 1 || nY[0] != 1) begin
                allCorrect = 0;
            end

            // nE1 = X, nE2 = 1, E3 = X
            nE2 = 1;
            #1;
            //$display("nE1 = %b\tnE2 = %b\tE3 = %b\tA2 = %b\tA1 = %b\tA0 = %b\t\tnY7 = %b\tnY6 = %b\tnY5 = %b\tnY4 = %b\tnY3 = %b\tnY2 = %b\tnY1 = %b\tnY0 = %b", nE1, nE2, E3, A[2], A[1], A[0], nY[7], nY[6], nY[5], nY[4], nY[3], nY[2], nY[1], nY[0]);
            if(nY[7] != 1 || nY[6] != 1 || nY[5] != 1 || nY[4] != 1 || nY[3] != 1 || nY[2] != 1 || nY[1] != 1 || nY[0] != 1) begin
                allCorrect = 0;
            end

            // nE1 = X, nE2 = X, E3 = 0
            E3 = 0;
            #1;
            //$display("nE1 = %b\tnE2 = %b\tE3 = %b\tA2 = %b\tA1 = %b\tA0 = %b\t\tnY7 = %b\tnY6 = %b\tnY5 = %b\tnY4 = %b\tnY3 = %b\tnY2 = %b\tnY1 = %b\tnY0 = %b", nE1, nE2, E3, A[2], A[1], A[0], nY[7], nY[6], nY[5], nY[4], nY[3], nY[2], nY[1], nY[0]);
            if(nY[7] != 1 || nY[6] != 1 || nY[5] != 1 || nY[4] != 1 || nY[3] != 1 || nY[2] != 1 || nY[1] != 1 || nY[0] != 1) begin
                allCorrect = 0;
            end

            // increment A
            #1 nE1 = 0;
            #1 nE2 = 0;
            #1 E3 = 1;
            #1 A = 0;
            repeat(8) begin
                #1;
                //$display("nE1 = %b\tnE2 = %b\tE3 = %b\tA2 = %b\tA1 = %b\tA0 = %b\t\tnY7 = %b\tnY6 = %b\tnY5 = %b\tnY4 = %b\tnY3 = %b\tnY2 = %b\tnY1 = %b\tnY0 = %b", nE1, nE2, E3, A[2], A[1], A[0], nY[7], nY[6], nY[5], nY[4], nY[3], nY[2], nY[1], nY[0]);
                if(nY[A] != 0) begin
                    allCorrect = 0;
                end
                A = A + 1;

            end
        end
    
    initial
        begin
            if(allCorrect == 1) begin
                $display("Actual outputs equal expected outputs for all input combinations.");
            end
        end

endmodule