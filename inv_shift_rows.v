// Inverse ShiftRows operation for AES decryption
module inv_shift_rows(
    input [127:0] state_in,  
    output [127:0] state_out 
);

    // Inverse ShiftRows: Shift the rows in the opposite direction
    assign state_out[127:120] = state_in[127:120];    // First row stays the same
    assign state_out[119:112] = state_in[111:104];    
    assign state_out[111:104] = state_in[95:88];     
    assign state_out[95:88] = state_in[79:72];        
    assign state_out[87:80] = state_in[87:80];        
    assign state_out[79:72] = state_in[79:72];        
    assign state_out[71:64] = state_in[71:64];       
    assign state_out[63:56] = state_in[63:56];        

endmodule
