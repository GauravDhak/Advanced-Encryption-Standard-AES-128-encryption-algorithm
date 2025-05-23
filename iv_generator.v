module galois_lfsr_128bit (
    input  wire clk,
    input  wire rst,
    input  wire enable,
    input  wire load_seed,
    input  wire [127:0] seed,
    output reg  [127:0] iv
);

    reg feedback;

    always @(posedge clk or posedge rst) begin
        if (rst)
            iv <= 128'h1;
        else if (load_seed)
            iv <= seed;
        else if (enable) begin
            feedback = iv[127]; // MSB as feedback

            iv[127:1] <= iv[126:0];  // Shift left
            iv[0] <= feedback;       // Insert feedback at LSB

            // XOR feedback into specific tap positions
            if (feedback) begin
                iv[104] <= iv[104] ^ 1'b1;
                iv[101] <= iv[101] ^ 1'b1;
                iv[99]  <= iv[99]  ^ 1'b1;
            end
        end
    end

endmodule



/*Aspect  Galois LFSR (this version)
Feedback insertion  During shift
Critical path Very short (XOR + shift)
Maximum frequency  Higher
Area (LUT usage)  Less
Code complexity Slightly more complex*/