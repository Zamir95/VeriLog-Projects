module labm9;
reg a, b;
reg [31:0] entryPoint;
wire [2:0] op;
wire [1:0] ALUop;
wire [31:0] PCin, ins, PCp4, wd, rd1, rd2, imm, z, memOut, wb;
wire [25:0] jTarget;
wire zero, RegDst, RegWrite, ALUSrc, Mem2Reg, MemRead, MemWrite, branch, jump;
wire [5:0] opCode, fnCode;

yIF myIF(ins, PCp4, PCin, a);
yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, a);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, a, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
yPC myPC(PCin, PCp4, INT, entryPoint, imm, jTarget, zero, branch, jump);
yC1 myC1(rtype, lw, sw, jump, branch, opCode);
yC2 myC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite, rtype, lw, sw, branch);
yC3 myC3(ALUop, rtype, branch);
yC4 myC4(op, ALUop, fnCode);
assign wd = wb;
assign opCode = ins[31:26];
assign fnCode = ins[5:0];

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
		$display("instruction = %h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d", ins, rd1, rd2, z, zero, wb);
	end
	$finish;
end

endmodule
