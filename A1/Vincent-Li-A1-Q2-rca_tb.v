// Filename: Vincent-Li-A1-Q2-rca_tb.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Test bench for Vincent-Li-A1-Q2-rca.v
*/

module rca_tb;
    parameter integer WIDTH = 4;
    integer reps = 1;

    reg [WIDTH - 1 : 0] a, b;
    reg in;
    wire [WIDTH - 1 : 0] sum;
    wire out;
    reg [WIDTH : 0] expectedSum;
    integer allCorrect = 1;

    // instantiate rca
    rca #(.WIDTH(WIDTH)) Mn(.a(a), .b(b), .in(in), .sum(sum), .out(out));

    initial
        begin
            // initial input values
            a = 0;
            b = 0;
            in = 0;

            // find value for REPS
            repeat(WIDTH) begin
                reps = reps * 2;
            end 

            // main loops
            repeat(reps) begin // modify a
                repeat(reps) begin // modify b
                    repeat(2) begin // modify in
                        expectedSum = a + b + in;
                        
                        //#1 $display("a = %b\tb = %b\tin = %b\tsum = %b\tout = %b\texpected sum = %b\texpected out = %b", a, b, in, sum, out, expectedSum[WIDTH - 1 : 0], expectedSum[WIDTH]);
                        
                        if(expectedSum[WIDTH - 1 : 0] != sum || expectedSum[WIDTH] != out) begin
                            allCorrect = 0;
                        
                        end
                        in = in + 1;
                    
                    end
                    in = 0;
                    b = b + 1;
                
                end
                b = 0;
                a = a + 1;
            
            end
            // check allCorrect
            if(allCorrect == 1) begin
                $display("All input combinations successfully verified");
            end
        end
endmodule