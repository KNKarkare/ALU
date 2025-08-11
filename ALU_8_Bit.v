module ALU_8_Bit (ALU_Sel, Carry, Zero, Negative, Overflow, Parity, A, B, ALU_Out);
input [2:0]ALU_Sel;
input [7:0]A, B;

output reg Carry, Zero, Negative, Overflow, Parity;
output reg [7:0]ALU_Out;
//wire

always @(*) begin
    {Carry, ALU_Out} = 0;
    Zero = 0; Negative = 0; Overflow = 0;

    case (ALU_Sel)
        3'b000: begin // Addition
            {Carry, ALU_Out[7:0]} = A + B;
//            ALU_Out[15:8] = 0;
            Overflow = (~A[7] & ~B[7] & ALU_Out[7]) | (A[7] & B[7] & ~ALU_Out[7]); // Assuming 8th bit is sign bit, so two positive numbers can't make a negative number and vice a versa
        end

        3'b001: begin // Subtraction
            {Carry, ALU_Out[7:0]} = A - B;
//            ALU_Out[15:8] = 0;
            Overflow = (~A[7] & B[7] & ALU_Out[7]) | (A[7] & ~B[7] & ~ALU_Out[7]);
        end

        3'b010: begin // Left shift A
            ALU_Out = A << 1;
            Carry = A[7];
        end

        3'b011: begin // Right shift A
            ALU_Out = A >> 1;
            Carry = A[0];
        end

//        3'b100: begin // Multiplication
//            ALU_Out = A * B;
//            Carry = ALU_Out[8]; // optional
//        end
			3'b101: begin // AND
            ALU_Out = A & B;
            
        end
		  	3'b110: begin // OR
            ALU_Out = A | B;
            
        end
		  	3'b111: begin // NOT
            ALU_Out = ~A ;
            
        end

        default: ALU_Out = 8'h00;
    endcase
	 Parity = ^ALU_Out; // simple bitwise XOR
    Zero = ~|ALU_Out; // even if one 1 in the word output will be zero, only all zeroes will be output 1
    Negative = ALU_Out[7];
end

endmodule
