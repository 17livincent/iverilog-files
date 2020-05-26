// Filename: Vincent-Li-A1-Q3c-dec4x16_tb.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Test bench for Vincent-Li-A1-Q3c-dec4x16.v
*/
module dec4x16_tb;
    reg nE1, nE2, E3;
    reg [2 : 0] A;
    wire [15 : 0] nY;
    integer allCorrect = 1;

    dec4x16 D(.nE1(nE1), .nE2(nE2), .E3(E3), .A(A), .nY(nY));

    initial
        begin
            nE1 = 0;
            nE2 = 0;
            E3 = 1;
            A = 0;
            #1;
            repeat(2) begin // modify enable from 001 to 110
                repeat(8) begin // increment A
                    #1;
                    $display("nE1 = %b, nE2 = %b, E3 = %b, A = %b, nY = %b", nE1, nE2, E3, A, nY);
                    A = A + 1;
                end
                // reset a
                A = 0;
                // negating enable
                nE1 = 1;
                nE2 = 1;
                E3 = 0;
                #1;
            end
        end

endmodule
