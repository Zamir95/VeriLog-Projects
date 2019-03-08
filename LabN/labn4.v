//Zamir Lalji	212779997
module labm9;
reg a, b;
reg [31:0] entryPt;
wire [31:0] ins, rd2, wb;

yChip myChip(ins, rd2, wb, entryPoint, b, a);

initial
begin
	//------------------------------Entry point
	entryPt = 128; 
	b = 1; 
	#1;
	//------------------------------Run program
	repeat (43)
	begin
		//--------------------------Fetch an ins
		a = 1; 
		#1; 
		b = 0;
		a = 0; 
		#1;
		//--------------------------View the result
		$display("instruction = %h: rd2=%2d wb=%2d", ins, rd2, wb);
	end
	$finish;
end

endmodule
