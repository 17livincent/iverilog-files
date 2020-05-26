// Filename: alu32_tb.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Test bench for alu32.v
*/

module alu32_tb;
    parameter integer WIDTH = 32;
    reg [WIDTH - 1 : 0] A, B;
    reg [3 : 0] S;
    reg Cin;
    wire [WIDTH - 1 : 0] D;
    wire Cout;

    integer allCorrect = 1;

    alu32 #(.WIDTH(WIDTH)) ALU (.A(A), .B(B), .S(S), .Cin(Cin), .D(D), .Cout(Cout));

    initial
        begin
            S = 4'b0000;

            A = 32'b10101010101010101010101010101010;
            B = 32'b01010101010101010101010101010101;
            Cin = 0;
            #1;
        end
    initial
        begin
        
            repeat(16) begin
                
                // #1 $display("S = %b\nA = %b\nB = %b\nCin = %b\nD = %b\tCout = %b\n",S, A, B, Cin, D, Cout);
                S = S + 1;
                #1;

                if(S == 4'b0001) begin
                    if(D != 32'b11111111111111111111111111111111 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b0010) begin
                    if(D != 32'b01010101010101010101010101010101 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b0011) begin
                    if(D != 32'b01110001110001110001110001110010 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b0100) begin
                    if(D != 32'b00000000000000000000000000000010 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b0101) begin
                    if(D != 32'b01010101010101010101010101010100 && Cout != 1) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b0110) begin
                    if(D != 32'b01010101010101010101010101010101 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b0111) begin
                    if(D != 32'b01010101010101010101010101010101 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b1000) begin
                    if(D != 32'b01010101010101010101010101010101 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b1001) begin
                    if(D != 32'b00000000000000000000000000000000 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b1010) begin
                    if(D != 32'b11111111111111111111111111111111 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b1011) begin
                    if(D != 32'b11111111111111111111111111111111 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b1100) begin
                    if(D != 32'b11111111111111111111111111111111 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b1101) begin
                    if(D != 32'b00000000000000000000000000000000 && Cout != 1) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b1110) begin
                    if(D != 32'b00000000000000000000000000000001 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end
                else if(S == 4'b1111) begin
                    if(D != 32'b00000000000000000000000000000000 && Cout != 0) begin
                        allCorrect = 0;
                        $display(S);
                    end
                end

            end
        /*
            S = 4'b0010;
            #1 $display("S = %b\nA = %b\nB = %b\nCin = %b\nD = %b\tCout = %b\n",S, A, B, Cin, D, Cout);
        */
            if(allCorrect == 1) $display("All input combos successfully verified");
            
            $finish;
        end

endmodule