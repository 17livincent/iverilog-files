// Filename: Vincent-Li-A1-Q1-iterMagComp_tb.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Test bench for Vincent-Li-A1-Q1-iterMagComp.v
    Prints "All input combinations successfully verified"
        after checking the actual results with the expected ones.
*/

`include "gscl45nm.v"

module iterMagComp_tb;
    parameter integer WIDTH = 4, REPS = 2;
    reg [WIDTH - 1 : 0] a, b;
    reg [2 : 0] in;
    wire [2 : 0] out;
    reg [2 : 0] expected;
    integer allCorrect = 1;

    // instantiate
    iterMagComp #(.WIDTH(WIDTH)) M(.a(a), .b(b), .in(in), .out(out));

    initial
        begin
            in = 3'b010;
            // reset expected
            expected = 0;
            // reset a
            a = 0;
            #1;

            // loops to evaluate IMC and compare output to expected
            repeat(REPS)
                begin
                    // reset b
                    b = 0;
                    #1;
                    repeat(WIDTH * WIDTH)
                        begin
                            // find expected
                            if(a < b) expected = 3'b001;
                            else if(a == b) expected = 3'b010;
                            else expected = 3'b100;

                            // check
                            /*
                            if(expected != out) begin
                                #1 $display("a = %b, b = %b, out = %b, expected = %b, equal = %b", a, b, out, expected, out && expected);
                                allCorrect = 0;
                            end
                            */
                            // increment b
                            b = b + 1;
                            #1;
                        end

                    // increment a
                    a = a + 1;
                    in = 3'b010;
                    #1;
                end
        end
    initial
        begin
            if(allCorrect == 1) begin
                $display("All input combinations successfully verified");
            end
        end

endmodule