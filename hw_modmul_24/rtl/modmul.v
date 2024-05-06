module modmul(input        reset,
              input	   clk,
              input [23:0]  a,
              input [23:0]  b,
              output [23:0] m);
   
   // compute (a*b) mod 2^24 - 3

   wire [47:0]		   result;
   wire [25:0]		   sum0;
   wire [24:0]		   sum1;

   assign result = a * b;
   assign sum0 = result[23:0] + result[47:24] + {result[47:24], 1'b0};
   assign sum1 = sum0[23:0] + sum0[25:24] + {sum0[25:24], 1'b0};
   assign m    = (sum1 >= 24'hFFFFFD) ? (sum1 + 25'h3333) : sum1;

endmodule
