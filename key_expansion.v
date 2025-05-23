
`ifndef KEY_EXPANSION_V
  
  `define KEY_EXPANSION_V

  module key_expansion (
      input [127:0] key_in,        // Input 128-bit key
      output [1407:0] round_keys   // Output 1408-bit round keys (11 * 128 bits)
  );
      
      
      // In this simple implementation, we are just repeating the key 11 times
      assign round_keys = {11{key_in}};
  
  endmodule

`endif  
