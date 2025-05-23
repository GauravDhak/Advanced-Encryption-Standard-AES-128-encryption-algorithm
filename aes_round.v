`include "aes_mix_columns.v"
module aes_round (
    input  wire [127:0] state_in,
    input  wire [127:0] round_key,
    input  wire         last_round,
    output wire [127:0] state_out
);

    wire [127:0] sub_bytes_out;
    wire [127:0] shift_rows_out;
    wire [127:0] mix_columns_out;

    assign sub_bytes_out = state_in ^ round_key; 

    
    assign shift_rows_out = {sub_bytes_out[127:96], sub_bytes_out[87:80], sub_bytes_out[47:40], sub_bytes_out[7:0],
                             sub_bytes_out[95:88], sub_bytes_out[55:48], sub_bytes_out[15:8], sub_bytes_out[103:96],
                             sub_bytes_out[63:56], sub_bytes_out[23:16], sub_bytes_out[111:104], sub_bytes_out[71:64],
                             sub_bytes_out[31:24], sub_bytes_out[119:112], sub_bytes_out[79:72], sub_bytes_out[39:32]};

    
    wire [31:0] mc0, mc1, mc2, mc3;

    aes_mix_columns u_mix0 (.state_in(shift_rows_out[127:96]), .state_out(mc0));
    aes_mix_columns u_mix1 (.state_in(shift_rows_out[95:64]), .state_out(mc1));
    aes_mix_columns u_mix2 (.state_in(shift_rows_out[63:32]), .state_out(mc2));
    aes_mix_columns u_mix3 (.state_in(shift_rows_out[31:0]),  .state_out(mc3));

    assign mix_columns_out = {mc0, mc1, mc2, mc3};

    assign state_out = last_round ? shift_rows_out ^ round_key : mix_columns_out ^ round_key;

endmodule
