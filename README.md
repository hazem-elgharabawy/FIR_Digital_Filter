# FIR_Digital_Filter

## FIR filter transposed form
![alt text](<report/transposed FIR BD.png>)

## Design
```
module FIR_filter # (
    parameter L = 8,
    parameter b0 = 0,
    parameter b1 = 1,
    parameter b2 = 2,
    parameter b3 = 3
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
```

## Testbench
```
module FIR_filter_tb ();
    
    bit CLK;
    logic RST;
    logic [7:0] Xn;
    logic [7:0] Yn;
    
    logic [7:0] inputs_map [0:99];
    logic [7:0] outputs_map [0:99];

    integer error_counter=0;
    integer correct_counter=0;


    FIR_filter DUT (.*);

    initial begin
        forever begin
            #5 CLK = ~CLK;
        end
    end


    initial begin
        RST = 0;
        @(negedge CLK);
        @(negedge CLK);
        
        RST = 1;

        $readmemh("inputs_map.txt",inputs_map);
        $readmemh("outputs_map.txt",outputs_map);
        
        for (integer i = 0; i < 99; i++) begin
            Xn = inputs_map[i];
            @ (negedge CLK);
            if (Yn != outputs_map[i]) begin
                $display("error time: %0t",$time);
                $display("Input: %0h, Expected: %0h, Received: %0h", Xn, outputs_map[i], Yn);
                error_counter++;
            end
            else
                correct_counter++;
        end

        $display("Total errors: %d, Total correct: %d", error_counter, correct_counter);
        $stop;

    end




endmodule
```

## test results
![alt text](report/result.png)

