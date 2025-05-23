// Galois Field multiplication for AES (multiply by 2 or 3 in GF(2^8))
module galois_multiplication(
    input [7:0] a,     
    input [7:0] b,     
    output [7:0] result 
);

    reg [15:0] product;  
    reg [7:0] temp;     

    always @(*) begin
        product = 0;
        temp = 0;

        // Galois Field multiplication for AES
        // Perform multiplication by 2
        
        if (a != 0 && b != 0) begin
            product = a * b;  
            temp = product[7:0]; 
        end
    end

    assign result = temp;  

endmodule
