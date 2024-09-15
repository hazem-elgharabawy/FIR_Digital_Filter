module FIR_filter # (
    parameter L = 8,
    parameter b0 = 1,
    parameter b1 = 2,
    parameter b2 = 3,
    parameter b3 = 4
) (
    input   bit     CLK,
    input   logic   RST,
    input   logic   [L-1:0] Xn,
    output  logic   [L-1:0] Yn
);
    

    logic [L-1:0] X_n1;
    logic [L-1:0] X_n2;
    logic [L-1:0] X_n3;

    always @(posedge CLK or negedge RST) begin
        if (!RST) begin    
            X_n1 <= 0;    
            X_n2 <= 0;    
            X_n3 <= 0; 
            Yn <= 0;   
        end
        else begin     
            X_n3 <= (Xn >> b3);            // Transposed Form
            X_n2 <= X_n3 + (Xn >> b2);
            X_n1 <= X_n2 + (Xn >> b1);
            Yn <= X_n1 + (Xn >> b0);                
        end
    end
endmodule