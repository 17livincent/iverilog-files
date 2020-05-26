// Filename: gcd.v
// Name: Vincent Li
// Course: CSE320 T/TH 4:30PM
// Professor: Vrudhula
/*
    GCD designed in class, but uses an ALU for all calculations.
*/
module gcd (
    input clk,
    input go,
    input [31 : 0] Xi, Yi,
    output reg [31 : 0] XYGCD
    );
    reg [31 : 0] PX, NX, PY, NY;   // main inputs, present and next
    reg [31 : 0] NGCD; // next output
    reg Xsel, Ysel; // controls to switch between x & x - y and y & y - x
    reg Xld, Yld, Dld;  // pulsed by clock

    // State info
    parameter S0 = 2'b00;  // waiting for go. Set controls and NX and NY from Xi and Yi. Goes to 01
    parameter S1 = 2'b01;  // Set Xsel and Ysel. If PX and PY are equal, go to 11, else go to 10
    parameter S2 = 2'b10;  // Update NX and NY based on Xsel and Ysel, and go to 01
    parameter S3 = 2'b11;  // Found output
    reg [2 : 0] PS; // present state
    reg [2 : 0] NS = S0; // next state

    // ALU
    reg [3 : 0] S = 4'b0000; // ALU control
    reg Cin = 0;
    wire [31 : 0] D; // ALU output
    wire Cout;
    parameter integer WIDTH = 32;
    alu32 #(.WIDTH(WIDTH)) ALU (.A(PX), .B(PY), .S(S), .Cin(Cin), .D(D), .Cout(Cout));

    // next state logic
    always @(*) begin
        case(PS)
            S0: begin
                NX = Xi;
                NY = Yi;
                Xld = 1'b0;
                Yld = 1'b0;
                Dld = 1'b0;
                //Xsel = 0;
                //Ysel = 0;
                if(go == 1) begin
                    NS = S1;
                end
                else begin
                    NS = S0;
                end
            end

            S1: begin
                S = 4'b0010; // to calculate < or >
                if(D == 0) begin
                    Xsel = 0;
                    Ysel = 0;
                    NS = S3;
                end
                else if(Cout == 0) begin // X > Y
                    Xsel = 1;
                    Ysel = 0;
                    NS = S2;
                end
                else if(Cout == 1) begin // X < Y
                    Xsel = 0;
                    Ysel = 1;
                    NS = S2;
                end
                S = 4'b0000;
            end

            S2: begin
                if(Xsel == 1'b0) begin
                    NX = PX;
                end
                else if(Xsel == 1'b1) begin
                    NX = PX - PY;
                end
                if(Ysel == 1'b0) begin
                    NY = PY;
                end
                else if(Ysel == 1'b1) begin
                    NY = PY - PX;
                end
                NS = S1;
            end

            S3: begin
                NGCD = PX;
                NS = S0;
            end

        endcase
    end

    // state update
    always @(posedge clk) begin
        //$display("PX = %b\nPY = %b\nXsel = %b\nYsel = %b\nXYGCD = %b\n", PX, PY, Xsel, Ysel, XYGCD);
        PS <= NS;
        Xld <= ~Xld;
        Yld <= ~Yld;
        Dld <= ~Dld;
        #1;
    end

    // output logic
    always @(posedge clk) begin
        if(Xld == 1'b1) begin
            PX <= NX;
        end
        if(Yld == 1'b1) begin
            PY <= NY;
        end
        if(Dld == 1'b1) begin
            XYGCD <= NGCD;
        end
        #1;
    end

endmodule