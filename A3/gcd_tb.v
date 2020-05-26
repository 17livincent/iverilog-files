// Filename: gcd_tb.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    Test bench for gcd.v
*/

module gcd_tb;
    reg clk;
    reg go;
    reg [31 : 0] Xi, Yi;
    wire [31 : 0] XYGCD;
    integer i;
    integer allCorrect = 1;

    gcd M(.clk(clk), .go(go), .Xi(Xi), .Yi(Yi), .XYGCD(XYGCD));

    initial
        begin
            go = 0;
            #1;

            // test X > Y
            Xi = 32'b1010;
            Yi = 32'b10;
            #1;
            go = 1;
            #1;
            clk = 0;
            for(i = 0; i < 20; i = i + 1) begin
                clk = ~clk;
                #1;
                clk = ~clk;
                #1;
            end
            if(XYGCD != 32'b1010) begin
                allCorrect = 0;
            end

            // test X < Y
            go = 0;
            #1;
            Xi = 32'b10;
            Yi = 32'b1010;
            #1;
            go = 1;
            #1;
            clk = 0;
            for(i = 0; i < 20; i = i + 1) begin
                clk = ~clk;
                #1;
                clk = ~clk;
                #1;
            end
            if(XYGCD != 32'b1010) begin
                allCorrect = 0;
            end

            // test X == Y
            go = 0;
            #1;
            Xi = 32'b10;
            Yi = 32'b10;
            #1;
            go = 1;
            #1;
            clk = 0;
            for(i = 0; i < 20; i = i + 1) begin
                clk = ~clk;
                #1;
                clk = ~clk;
                #1;
            end
            if(XYGCD != 32'b10) begin
                allCorrect = 0;
            end


            if(allCorrect == 1) $display("All input combos verified");
            else $display("Not all input combos verified");

            $finish;

        end

endmodule