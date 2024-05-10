`timescale 1ns/1ps

module tb;
   reg [127:0]  r;
   reg [127:0]	s;
   reg [127:0]	m;
   reg		fb;   
   reg	        ld;
   reg	        first;
   wire [127:0]	p;
   wire		rdy;
   reg		reset;
   reg		clk;   
   
   poly1305 dut(.reset(reset),
		.clk(clk),
		.r(r),
		.s(s),
		.m(m),
		.fb(fb),
		.ld(ld),
		.first(first),
		.p(p),
		.rdy(rdy));

   always
     begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
     end
   
   initial
     begin
        $dumpfile("trace.vcd");
        $dumpvars(0, tb);
	
	#1;
	r      = 128'h806d5400e52447c036d555408bed685;
	s      = 128'h1bf54941aff6bf4afdb20dfb8a800301;
	ld     = 1'b0;
	
	reset = 1'b1;	
	repeat(3)
	  @(posedge clk);
	
	#1;
	reset = 1'b0;
	@(posedge clk);

	repeat(3)
	  begin
		
	     #1;
	     m      = 128'h6f462063_69687061_72676f74_70797243;
	     first  = 1'b1;
	     ld     = 1'b1;
	     fb     = 1'b1;
	     	       
	     @(posedge clk);
	     
	     while (rdy == 1'b0)
	       begin
		  #1;
		  ld = 1'b0;
		  @(posedge clk);
	       end
	     
	     #1;
	     m     = 128'h6f724720_68637261_65736552_206d7572;
	     ld    = 1'b1;
	     first = 1'b0;	
	     
	     @(posedge clk);
	     
	     while (rdy == 1'b0)
	       begin
		  #1;
		  ld = 1'b0;
		  @(posedge clk);
	       end
	     
	     #1;
	     m     = 128'h017075;
	     ld    = 1'b1;
	     fb    = 1'b0;

	     @(posedge clk);
	     
	     while (rdy == 1'b0)
	       begin
		  #1;
		  ld = 1'b0;
		  @(posedge clk);
	       end
	     
	     $display("%h", p);
	     
	     #1;
	     ld = 1'b0;

	     @(posedge clk);
	     @(posedge clk);
	     @(posedge clk);
	     @(posedge clk);
	     
	  end // repeat (3)
	
	$finish;
     end
	
endmodule
