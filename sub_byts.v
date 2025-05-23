`include "sbox.v"

module sub_bytes (
    input [127:0] state_in,
    output [127:0] state_out
);
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : sb_loop
            sbox s (
                .in(state_in[i*8 +: 8]),
                .out(state_out[i*8 +: 8])
            );
        end
    endgenerate
endmodule
