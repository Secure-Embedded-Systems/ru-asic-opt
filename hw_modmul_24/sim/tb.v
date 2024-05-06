module tb;
   reg  [23:0] a;
   reg  [23:0] b;
   wire [23:0] m;
   reg  [47:0] r;
   
   modmul dut(.reset(),
	      .clk(),
	      .a(a),
	      .b(b),
	      .m(m));

   initial
     begin
        $dumpfile("trace.vcd");
        $dumpvars(0, tb);

	a = 24'hF0F0F0;
	b = 24'h0F0F0F;

	repeat (100) 
	  begin
	     #10;
	     
	     r = (a * b) % 24'hFFFFFD;
	     $display("%x %x %x", a, b, dut.m);
	     
	     if (dut.m != r[23:0])
	       $error("Expected %x ", r[23:0]);

	     a = a + 24'b1;
	     if (a == 24'b0)
	       b = b + 24'b1;
	     
	     if ((a == 24'b0) && (b == 24'b0))
	       $finish;
	  end 
	   
     end
endmodule
