// Zamir Lalji
// Student Id: 212779997
module labK;

   reg a, b, w;
   
   reg [1:0] expect;
   wire s, count;
   wire xor1, xor2;
   wire and1, and2;
   integer i, j, k;

   xor(xor1, b, a);
   xor(s, w, xor1);
   and(and1, b, a);
   and(and2, xor1, w);
   or(count, and2, and1);

   initial
     begin
      

        for (i = 0; i < 2; i = i + 1)
          for (j = 0; j < 2; j = j + 1)
            for (k = 0; k < 2; k = k + 1)
              begin
                 a = i;
                 b = j;
                 w = k;

                 expect = a + b + w;

                 #1; 
                 if (expect[0] === s && expect[1] === count)
                   $display("PASS: a=%b b=%b w=%b s=%b count=%b",
                            a, b, w, s, count);
                 else
                   $display("FAIL: a=%b b=%b w=%b s=%b count=%b",
                            a, b, w, s, count);
              end
        $finish;
     end

endmodule
