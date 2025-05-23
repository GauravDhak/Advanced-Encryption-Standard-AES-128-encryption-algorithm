module inv_mix_columns (
    input  [127:0] state_in,   // 128-bit AES state
    output [127:0] state_out   // 128-bit output after inverse MixColumns
);

    // GF multiplication functions
    function [7:0] gm2(input [7:0] b);
        gm2 = (b << 1) ^ ((b[7]) ? 8'h1b : 8'h00);
    endfunction

    function [7:0] gm3(input [7:0] b);
        gm3 = gm2(b) ^ b;
    endfunction

    function [7:0] gm9(input [7:0] b);
        gm9 = gm2(gm2(gm2(b))) ^ b;
    endfunction

    function [7:0] gm11(input [7:0] b);
        gm11 = gm2(gm2(gm2(b)) ^ b) ^ b;
    endfunction

    function [7:0] gm13(input [7:0] b);
        gm13 = gm2(gm2(gm2(b) ^ b)) ^ b;
    endfunction

    function [7:0] gm14(input [7:0] b);
        gm14 = gm2(gm2(gm2(b) ^ b) ^ b);
    endfunction

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : column_loop
            wire [7:0] s0, s1, s2, s3;
            assign s0 = state_in[(32*i) +: 8];
            assign s1 = state_in[(32*i + 8) +: 8];
            assign s2 = state_in[(32*i + 16) +: 8];
            assign s3 = state_in[(32*i + 24) +: 8];

            assign state_out[(32*i) +: 8]      = gm14(s0) ^ gm11(s1) ^ gm13(s2) ^ gm9(s3);
            assign state_out[(32*i + 8) +: 8]  = gm9(s0)  ^ gm14(s1) ^ gm11(s2) ^ gm13(s3);
            assign state_out[(32*i + 16) +: 8] = gm13(s0) ^ gm9(s1)  ^ gm14(s2) ^ gm11(s3);
            assign state_out[(32*i + 24) +: 8] = gm11(s0) ^ gm13(s1) ^ gm9(s2)  ^ gm14(s3);
        end
    endgenerate

endmodule
