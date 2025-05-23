`include "key_expansion.v"
`include "aes_round.v"
`include "iv_generator.v"
//`include "aes_mix_columns.v"

module aes_top (
    input clk,
    input rst,
    input start,
    input [127:0] plaintext,
    input [127:0] key,
    output [127:0] ciphertext,
    output [127:0] iv_out,
    output [255:0] cipher_bundle
);
    wire [127:0] iv;
    wire [1407:0] round_keys; // 11 round keys × 128 bits = 1408
    wire [127:0] states [0:10]; // States after each round (0 to 10)

    // Instantiate IV generator (Galois LFSR)
    galois_lfsr_128bit iv_gen (
        .clk(clk),
        .rst(rst),
        .enable(start),
        .iv(iv)
    );

    assign iv_out = iv;

    // Initial AddRoundKey + IV XOR
    assign states[0] = plaintext ^ key ^ iv;

    // Generate AES Rounds (1 to 10)
    genvar i;
    generate
        for (i = 0; i < 10; i = i + 1) begin : rounds
            aes_round u_round (
                .state_in(states[i]),
                .round_key(round_keys[i*128 +: 128]),
                .last_round(i == 9),
                .state_out(states[i+1])
            );
        end
    endgenerate

    // Final ciphertext output from last round
    assign ciphertext = states[10];

    // Pack IV and Ciphertext together for transmission or storage
    assign cipher_bundle = {iv, ciphertext};

    // AES Key Expansion Module
    key_expansion ke (
        .key_in(key),
        .round_keys(round_keys)
    );

endmodule
