`timescale 1ns / 1ps

module ALU_8_Bit_tb;

    // Inputs
    reg [7:0] A, B;
    reg [2:0] ALU_Sel;

    // Outputs
    wire [7:0] ALU_Out;
    wire Carry, Zero, Negative, Overflow, Parity;

    // Instantiate the ALU
    ALU_8_Bit uut (
        .ALU_Sel(ALU_Sel),
        .Carry(Carry),
        .Zero(Zero),
        .Negative(Negative),
        .Overflow(Overflow),
		  .Parity(Parity),
        .A(A),
        .B(B),
        .ALU_Out(ALU_Out)
    );

    initial begin
        $display("Time\tSel\tA\tB\tALU_Out\t\tCarry Zero Neg Ovf Par");
        $monitor("%0t\t%b\t%h\t%h\t%h\t%b\t%b\t%b\t%b\t%b", 
                 $time, ALU_Sel, A, B, ALU_Out, Carry, Zero, Negative, Overflow, Parity);

        // Test 1: Addition
        A = 8'd100; B = 8'd50; ALU_Sel = 3'b000; #10;

        // Test 2: Subtraction
        A = 8'd50; B = 8'd100; ALU_Sel = 3'b001; #10;

        // Test 3: Left Shift
        A = 8'b10011011; B = 8'd0; ALU_Sel = 3'b010; #10;

        // Test 4: Right Shift
        A = 8'b10011011; B = 8'd0; ALU_Sel = 3'b011; #10;

        // Test 5: AND
        A = 8'b11001100; B = 8'b10101010; ALU_Sel = 3'b101; #10;

        // Test 6: OR
        A = 8'b11001100; B = 8'b10101010; ALU_Sel = 3'b110; #10;

        // Test 7: NOT
        A = 8'b11001100; B = 8'd0; ALU_Sel = 3'b111; #10;

        // Test 8: Overflow example (127 + 1)
        A = 8'd127; B = 8'd1; ALU_Sel = 3'b000; #10;

        $finish;
    end

endmodule
