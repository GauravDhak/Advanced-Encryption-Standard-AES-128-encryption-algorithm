`include "aes_round.v"
`include "key_expansion.v"

module aes_cbc_encrypt (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [127:0] plaintext,
    input wire [127:0] key,
    input wire [127:0] iv_in,
    output reg [127:0] ciphertext,
    output reg [127:0] iv_out,
    output reg done
);
    wire [127:0] aes_input, aes_output;
    wire [1407:0] round_keys;
    wire [127:0] states [0:10];
    integer i;

    assign aes_input = plaintext ^ iv_in;  // XOR Plaintext with IV

    assign states[0] = aes_input ^ key;     // Initial key addition

    generate
        genvar j;
        for (j = 1; j < 10; j = j + 1) begin : rounds
            aes_round r (
                .state_in(states[j-1]),
                .round_key(round_keys[j*128 +: 128]),
                .last_round(0),
                .state_out(states[j])
            );
        end
    endgenerate

    aes_round final_round (
        .state_in(states[9]),
        .round_key(round_keys[10*128 +: 128]),
        .last_round(1),
        .state_out(aes_output)
    );

    key_expansion ke (
        .key_in(key),
        .round_keys(round_keys)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ciphertext <= 0;
            iv_out <= 0;
            done <= 0;
        end else if (start) begin
            ciphertext <= aes_output;
            iv_out <= aes_output; // IV for next block
            done <= 1;
        end else begin
            done <= 0;
        end
    end
endmodule
