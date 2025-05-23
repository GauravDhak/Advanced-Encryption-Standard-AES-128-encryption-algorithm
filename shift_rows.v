module shift_rows (
    input [127:0] state_in,
    output [127:0] state_out
);
    wire [7:0] s [0:15];

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1)
            assign s[i] = state_in[i*8 +: 8];
    endgenerate

    assign state_out = {
        s[0],  s[5],  s[10], s[15],
        s[4],  s[9],  s[14], s[3],
        s[8],  s[13], s[2],  s[7],
        s[12], s[1],  s[6],  s[11]
    };
endmodule
