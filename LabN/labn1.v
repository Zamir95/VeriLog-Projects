//Zamir Lalji	212779997
module labm9;
reg a, RegDst, RegWrite, ALUSrc, Mem2Reg, MemRead, MemWrite, INT, branch, jump;
reg [31:0] entryPoint;
reg [2:0] op;
wire [31:0] PCin, ins, PCp4, wd, rd1, rd2, imm, z, memOut, wb;
wire [25:0] jTarget;
wire zero;

yIF myIF(ins, PCp4, PCin, a);
yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, a);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, a, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
yPC myPC(PCin, PCp4, INT, entryPoint, imm, jTarget, zero, branch, jump);
assign wd = wb;

initial
begin
	//------------------------------Entry point
	entryPoint = 128; 
	b = 1; 
	#1;
	//------------------------------Run program
	repeat (43)
	begin
		//--------------------------Fetch an ins
		a = 1; 
		#1; 
		b = 0;
		//---------------------------------Set control signals   
		RegDst = 0; 
		RegWrite = 0; 
		ALUSrc = 1; 
		op = 3'b010;
		branch = (ins[31:26] == 'h4);
		jump = (ins[31:26] == 'h2);
		//---------------------------------Execute the ins
		// Add statements to adjust the above defaults
        // R format
        if (ins[31:26] == 0)
        begin
           RegDst = 1;
           RegWrite = 1;
           ALUSrc = 0;
           MemRead = 0;
           MemWrite = 0;
           Mem2Reg = 0;

           // add
           if (ins[5:0] == 'h20)
             op = 3'b010;
           // or
           else if (ins[5:0] == 'h25)
             op = 3'b001;
        end

        // J format (jump)
        else if (ins[31:26] == 'h2)
        begin
           RegDst = 0;
           RegWrite = 0;
           ALUSrc = 1;
           MemRead = 0;
           MemWrite = 0;
           Mem2Reg = 0;
        end

        // lw
        else if (ins[31:26] == 'h23)
        begin
           RegDst = 0;
           RegWrite = 1;
           ALUSrc = 1;
           MemRead = 1;
           MemWrite = 0;
           Mem2Reg = 1;
        end

        // beq
        else if (ins[31:26] == 'h4)
        begin
           RegDst = 0;
           RegWrite = 0;
           ALUSrc = 0;
           MemRead = 0;
           MemWrite = 0;
           Mem2Reg = 0;
        end

        // addi
        else if (ins[31:26] == 'h8)
        begin
           RegDst = 0;
           RegWrite = 1;
           ALUSrc = 1;
           MemRead = 0;
           MemWrite = 0;
           Mem2Reg = 0;
        end

        // sw
        else if (ins[31:26] == 'h2b)
        begin
           RegDst = 0;
           RegWrite = 0;
           ALUSrc = 1;
           MemRead = 0;
           MemWrite = 1;
           Mem2Reg = 0;
        end
		//--------------------------Execute the ins
		a = 0; #1;
		//--------------------------View the result
		$display("instruction = %h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d", ins, rd1, rd2, z, zero, wb);
	end
	$finish;
end

endmodule
