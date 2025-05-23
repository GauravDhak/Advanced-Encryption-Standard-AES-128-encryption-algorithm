`include "aes_top.v"
`include "aes_cbc_decrypt.v"

module aes_cbc_tb;
    reg clk;
    reg rst;
    reg start;
    reg [127:0] plaintext, key;
    wire [127:0] ciphertext;
    wire [127:0] decrypted_text;
    wire [127:0] iv_out;
    wire [255:0] cipher_bundle;  

    // Instantiate encryption module
    aes_top aes_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext),
        .iv_out(iv_out),
        .cipher_bundle(cipher_bundle)
    );

    // Instantiate decryption module
    aes_cbc_decrypt aes_decrypt_inst (
        .clk(clk),
        .rst(rst),
        .ciphertext(ciphertext),    
        .key(key),
        .iv(iv_out),
        .plaintext(decrypted_text) 
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 100 MHz clock
    end

    integer i;
    reg [127:0] pt[0:9];
    reg [127:0] k [0:9];

    initial begin
        // Initialize clock and reset
        clk = 0;
        rst = 0;
        start = 0;

        
        #10 rst = 1;
        #10 rst = 0;

        
        pt[0] = 128'h48656c6c6f414553576f726c64212131; // "HelloAESWorld!!1"
        k[0]  = 128'h4d795365637265744b65793132333435; // "MySecretKey12345"

        pt[1] = 128'h557365724c6f67696e44617461313233; // "UserLoginData123"
        k[1]  = 128'h53656375726550617373414553323536; // "SecurePassAES256"

        pt[2] = 128'h436f6e666964656e7469616c54787421; // "ConfidentialTxt!"
        k[2]  = 128'h50617373776f72643132333435363738; // "Password12345678"

        pt[3] = 128'h546573744d6573736167654145532121; // "TestMessageAES!!"
        k[3]  = 128'h556e697175654b657939383736353433; // "UniqueKey9876543"

        pt[4] = 128'h456e6372797074546869734e6f772121; // "EncryptThisNow!!"
        k[4]  = 128'h52616e646f6d4b657958795a39383736; // "RandomKeyXyZ9876"

        pt[5] = 128'h44617461546f42656372797074656421; // "DataToBecrypted!"
        k[5]  = 128'h4c6f636b6564546573744b6579383736; // "LockedTestKey876"

        pt[6] = 128'h4d7950617373776f7264313233343536; // "MyPassword123456"
        k[6]  = 128'h4165734b657931323334353637383930; // "AesKey1234567890"

        pt[7] = 128'h4c6f67696e5f52657175657374313233; // "Login_Request123"
        k[7]  = 128'h53657373696f6e4b6579383736353433; // "SessionKey876543"

        pt[8] = 128'h546869734973416e45534d7367732121; // "ThisIsAnESMsgs!!"
        k[8]  = 128'h547279416553506173734b6579383736; // "TryAESPassKey876"

        pt[9] = 128'h496e707574537472696e674865726521; // "InputStringHere!"
        k[9]  = 128'h4f7574507574436f6f6c4b6579383736; // "OutPutCoolKey876"

        
        for (i = 0; i < 10; i = i + 1) begin
            plaintext = pt[i];
            key = k[i];

            
            start = 1;
            #20;
            start = 0;

            
            #100;

            $display("-------------------------------------------------");
            $display("Test %0d:", i);
            $display("  Plaintext       : %h", pt[i]);
            $display("  Key             : %h", k[i]);
            $display("  Ciphertext      : %h", ciphertext);
            $display("  Decrypted Text  : %h", decrypted_text);
            $display("  IV Used         : %h", iv_out);
           // $display("  Cipher Bundle   : %h", cipher_bundle);

           
            if (decrypted_text == plaintext)
                $display("  [PASS] Decryption successful!\n");
            else
                $display("  [FAIL] Decryption mismatch!\n");

            
            #50;
        end

        
        $finish;
    end

    
    initial begin
        $dumpfile("aes_cbc_tb.vcd");
        $dumpvars(0, aes_cbc_tb);
    end
endmodule
