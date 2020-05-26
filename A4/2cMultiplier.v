// 2cMultiplier.v
// Vincent Li
// 3/28/2019
`timescale 1ns / 1ps

module fullAdder (
    input A, B, Cin,
    output S, Cout
    );
    assign S = A ^ B ^ Cin;
    assign Cout = A * B + Cin * (A ^ B);
    
endmodule

module twosCMultiplier #(parameter integer W = 6) (
    input wire [W - 1 : 0] X, Y,
    output wire [W * 2 - 1 : 0] Z
    );
    
    wire [2 * W - 1 : 0] interm [W - 1 : 0];  // 2W bits each wire, W wires 
    wire [2 * W - 2 : 0] S [W - 1 : 0];
    wire [2 * W - 2 : 0] carries [W - 2 : 0];
    
    genvar i;
    generate
        // and gates and sign extensions
        for(i = 0; i < W; i = i + 1) begin: ands
            and a[W - 1 : 0] (Y, {W{X[i]}}, interm[i][W - 1 + i : i]);
            assign interm[i][2 * W - 1 : W + i] = {(W - i){interm[i][W - 1 + i]}};
        end
        // adders
        for(i = 0; i < W - 1; i = i + 1) begin: genAdders
            if(i == 0) begin
                fullAdder fa [2 * W - 3 - i : 0] (.A(interm[0][2 * W - 2 : i + 1]), .B(interm[1][2 * W - 2 : i + 1]), .Cin({(2 * W - 1){0}}), .S(S[i][2 * W - 2 : i]), .Cout(carries[i][2 * W - 2 : i]));
            end
            else begin
                fullAdder fa [2 * W - 3 - i : 0] (.A(S[i - 1][2 * W - 2 : i]), .B(interm[i + 1][2 * W - 1 : i + 1]), .Cin(carries[i - 1][2 * W - 2 : i - 1]), .S(S[i][2 * W - 2 : i]), .Cout(carries[i][2 * W - 2 : i]));
            end
        end
        // assigning Z's
        // first W bits
        for(i = 0; i < 2 * W; i = i + 1) begin
            // first bit of Z
            if(i == 0) begin
                assign Z[i] = interm[i][i];
            end
            // second to W - 1 bit
            else if(i < W - 1) begin
                assign Z[i] = S[i][i];
            end
            // the rest
            else begin
                assign Z[i] = S[W - 1][i];
            end
        end
    endgenerate
    
    
endmodule
