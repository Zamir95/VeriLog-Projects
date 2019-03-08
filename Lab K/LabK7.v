// Zamir Lalji
// Student Id: 212779997

module labK;

   reg a, b, c, flag;
   wire notOut, lowInput;
   wire frstAndOut, frstAndIn;
   wire scndAndOut, scndAndIn;

   not (notOut, c);
   and (frstAndOut, a, lowInput);
   and (scndAndOut, c, b);
   or (z, frstAndIn, scndAndIn);
   assign lowInput = notOut;
   assign frstAndIn = frstAndOut;
   assign scndAndIn = scndAndOut;

   initial
     begin
        flag = $value$plusargs("a=%b", a);
        if (flag === 0)
          $display(" a is missing.");

        flag = $value$plusargs("b=%b", b);
        if (flag === 0)
          $display("b is missing.");

        flag = $value$plusargs("c=%b", c);
        if (flag === 0)
          $display("c is missing.");

        #1; // wait for z
        $display("a=%b b=%b c=%b z=%b", a, b, c, z);
        $finish;
     end

endmodule
