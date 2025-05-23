`include "inv_mix_column.v"
`include "inv_shift_rows.v"
`include "inv_sub_bytes.v"


module aes_inv_round(
    input [127:0] state_in,
    input [127:0] round_key,
    input last_round,
    output [127:0] state_out
);
    wire [127:0] addkey_out;
    wire [127:0] invmixcolumns_out;
    wire [127:0] invshiftrows_out;
    wire [127:0] invsubbytes_out;

     aes_inv_round u_inv_round (
    .state_in(state_in),
    .state_out(state_out),
    .round_key(round_keys[round * 128 +: 128]),
    .last_round(last_round)      // last_round is 1 bit, not 32 bits
);

    assign addkey_out = state_in ^ round_key;
    inv_mix_columns u_invmixcolumns (.state_in(addkey_out), .state_out(invmixcolumns_out));
    inv_shift_rows u_invshiftrows (.state_in(last_round ? addkey_out : invmixcolumns_out), .state_out(invshiftrows_out));
    inv_sub_bytes u_invsubbytes (.state_in(invshiftrows_out), .state_out(invsubbytes_out));

    assign state_out = invsubbytes_out;
endmodule
