module aes_mix_columns (
    input  wire [31:0] state_in,
    output reg  [31:0] state_out
);

    wire [7:0] s0, s1, s2, s3;
    reg  [7:0] y0, y1, y2, y3;

    // Extract input bytes
    assign s0 = state_in[31:24];
    assign s1 = state_in[23:16];
    assign s2 = state_in[15:8];
    assign s3 = state_in[7:0];

    // Function to compute xtime
    function [7:0] xtime;
        input [7:0] x;
        begin
            xtime = {x[6:0], 1'b0} ^ (8'h1b & {8{x[7]}});  // conditional xor with 0x1b if MSB is 1
        end
    endfunction

    // Combinational logic for MixColumns transformation
    always @(*) begin
        y0 = xtime(s0) ^ xtime(s1) ^ s1 ^ s2 ^ s3;
        y1 = s0 ^ xtime(s1) ^ xtime(s2) ^ s2 ^ s3;
        y2 = s0 ^ s1 ^ xtime(s2) ^ xtime(s3) ^ s3;
        y3 = xtime(s0) ^ s0 ^ s1 ^ s2 ^ xtime(s3);
        state_out = {y0, y1, y2, y3};
    end

endmodule
