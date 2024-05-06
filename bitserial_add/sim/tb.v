module tb;

   parameter CTLLEN = 32;
   
   reg [9:0] a1, a2, a3, a4;
   wire	     a1s, a2s, a3s, a4s;
   wire	     qs;
   wire [9:0] q;
   
   reg	      reset;
   reg	      clk;
   
   wire	      syncl1, syncl2, syncl3;
   
   reg [CTLLEN-1:0] ctl;

   piso #(.LEN(10)) PSA1(
			 .reset(reset),
			 .clk(clk),
			 .i(a1),
			 .s(a1s),
			 .isync(syncl1),
			 .osync(syncl2)
			);
   
   piso #(.LEN(10)) PSA2( 
			 .reset(reset),
			 .clk(clk),
			 .i(a2),
			 .s(a2s),
			 .isync(syncl1),
			 .osync()
			);
   
   piso #(.LEN(10)) PSA3(
			 .reset(reset),
			 .clk(clk),
			 .i(a3),
			 .s(a3s),
			 .isync(syncl1),
			 .osync()
			);
   
   piso #(.LEN(10)) PSA4(
			 .reset(reset),
			 .clk(clk),
			 .i(a4),
			 .s(a4s),
			 .isync(syncl1),
			 .osync()
			 );
   
   serialadd DUT(
		 .reset(reset),
		 .clk(clk),
		 .a1(a1s),
		 .a2(a2s),
		 .a3(a3s),
		 .a4(a4s),
		 .q(qs),
		 .isync(syncl2),
		 .osync(syncl3)
		 );

   sipo #(.LEN(10)) QSP(
			.reset(reset),
			.clk(clk),
			.i(qs),
			.s(q),
			.isync(syncl3),
			.osync()
		       );
   
   always
     begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
     end

   always @(posedge clk)
     begin
	if (reset)
	  ctl <= 1'b1;
	else
	  ctl <= {ctl[CTLLEN-2:0], ctl[CTLLEN-1]};
     end

   assign syncl1 = ctl[0];

   initial
     begin
        $dumpfile("trace.vcd");
        $dumpvars(0, tb);

	reset = 1'b0;	
	a1 = 10'd1;
	a2 = 10'd2;
	a3 = 10'd3;
	a4 = 10'd4;

	@(posedge clk) ;
	reset = 1'b1;
		
	@(posedge clk) ;
	reset = 1'b0;
	
	#1;
	
	repeat (10)
	  begin
	     while (ctl[CTLLEN-1] != 1'b1)
	       @(posedge clk) ;
	     
	     $display("%x %x %x %x %x", a1, a2, a3, a4, q);
	     
	     a1 = a1 + 10'd1;
	     a2 = a2 + 10'd1;
	     a3 = a3 + 10'd1;
	     a4 = a4 + 10'd1;
	     
	     @(posedge clk) ;
	     
	  end // repeat (10)
	
	$finish;
	
     end
   
endmodule
