`include "aes_inv_round.v"
`include "key_expansion.v"


module aes_cbc_decrypt (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [127:0] ciphertext,
    input wire [127:0] key,
    input wire [127:0] iv,
    output reg [127:0] plaintext,
    output reg [127:0] iv_out,
    output reg done
);
    wire [127:0] aes_decrypted;
    wire [1407:0] round_keys;
    wire [127:0] states [0:10];
    integer i;

    assign states[0] = ciphertext ^ round_keys[10*128 +: 128];

    generate
        genvar j;
        for (j = 1; j < 10; j = j + 1) begin : rounds
        end
    endgenerate

    assign aes_decrypted = states[9];

    key_expansion ke (
        .key_in(key),
        .round_keys(round_keys)
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            plaintext <= 0;
            iv_out <= 0;
            done <= 0;
        end else if (start) begin
            plaintext <= aes_decrypted ^ iv; // Decrypted XOR previous IV
            iv_out <= ciphertext;               // Update IV to ciphertext
            done <= 1;
        end else begin
            done <= 0;
        end
    end
endmodule
