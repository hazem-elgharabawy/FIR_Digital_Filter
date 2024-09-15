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
