module modmul(input        reset,
              input	   clk,
              input [93:0]  a,
              input [93:0]  b,
              output [93:0] m);
   
   // compute (a*b) mod 2^24 - 3

   wire [187:0]		   result;
   wire [95:0]		   sum0;
   wire [94:0]		   sum1;

   assign result = a * b;
   assign sum0 = result[93:0] + result[187:94] + {result[187:94], 1'b0};
   assign sum1 = sum0[93:0] + sum0[95:94] + {sum0[95:94], 1'b0};
   assign m    = (sum1 >= 94'h3FFFFFFFFFFFFFFFFFFFFFD) ? 
		 (sum1 + 94'h3FFFFFFFFFFFFFFFFFFFFFD) : sum1;
endmodule
