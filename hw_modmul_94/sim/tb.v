module tb;
   reg  [93:0] a;
   reg  [93:0] b;
   wire [93:0] m;
   reg  [187:0] r;
   
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
	     
	     r = (a * b) % 94'h3FFFFFFFFFFFFFFFFFFFFFFD;
	     $display("%x %x %x", a, b, dut.m);
	     
	     if (dut.m != r[93:0])
	       $error("Expected %x ", r[93:0]);

	     a = a + 24'b1;
	     if (a == 24'b0)
	       b = b + 24'b1;
	     
	     if ((a == 24'b0) && (b == 24'b0))
	       $finish;
	  end 
	   
     end
endmodule
