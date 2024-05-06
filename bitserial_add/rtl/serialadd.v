module serialadd(
		 input  reset,
		 input  clk,
		 input  a1,
		 input  a2,
		 input  a3,
		 input  a4,
		 output q,
		 input  isync,
		 output osync
		 );

   wire			sum1, sum2;
   wire			sum1_sync, sum2_sync;
   
   bsadd adder1(.reset(reset),
		.clk(clk),
		.a(a1),
		.b(a2),
		.q(sum1),
		.isync(isync),
		.osync(sum1_sync));

   bsadd adder2(.reset(reset),
		.clk(clk),
		.a(a3),
		.b(a4),
		.q(sum2),
		.isync(isync),
		.osync(sum2_sync));

   bsadd adder3(.reset(reset),
		.clk(clk),
		.a(sum1),
		.b(sum2),
		.q(q),
		.isync(sum1_sync),
		.osync(osync));
   
endmodule
