module scratch;
    reg [7 : 0] A, B;
    reg Cin;
    reg [7 : 0] D;
    reg Cout;

    reg [8 : 0] d;

    initial
        begin
            A = 8'b10101010;
            B = 8'b01010101;
            Cin = 0;
        end

    initial
        begin
            d = ~A & ~B;
        end

    initial
        begin
            D = d[7 : 0];
            Cout = d[8];
            $display("A = %b\nB = %b\tCin = %b\nD = %b\tCout = %b", A, B, Cin, D, Cout);
        end

endmodule