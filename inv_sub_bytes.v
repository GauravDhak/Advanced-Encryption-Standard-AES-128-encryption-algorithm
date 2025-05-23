module inv_sub_bytes (
    input  wire [127:0] state_in,
    output reg  [127:0] state_out
);

    // Inverse S-box function
    function [7:0] inv_sbox;
        input [7:0] in_byte;
        begin
            case (in_byte)
                8'h00: inv_sbox = 8'h52;
                8'h01: inv_sbox = 8'h09;
                8'h02: inv_sbox = 8'h6A;
                8'h03: inv_sbox = 8'hD5;
                8'h04: inv_sbox = 8'h30;
                8'hFE: inv_sbox = 8'hC0;
                8'hFF: inv_sbox = 8'h7D;
                default: inv_sbox = 8'h00;
            endcase
        end
    endfunction

    integer i;
    always @* begin
        for (i = 0; i < 16; i = i + 1) begin
            state_out[(i*8) +: 8] = inv_sbox(state_in[(i*8) +: 8]);
        end
    end

endmodule
