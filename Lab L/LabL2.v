module LabL;

   reg   [1:0] a, b, expect;
   reg   c;
   wire   [1:0] z;
   integer     i, j, k;
   yMux2 mux(z, a, b, c);

   initial
     begin

        for (i = 0; i < 4; i = i + 1)
          begin
             for (j = 0; j < 4; j = j + 1)
               begin
                  for (k = 0; k < 2; k = k + 1)
                    begin
                       a = i;
                       b = j;
                       c = k;

                       expect = c ? b : a;

                       #1; // wait for z
                       if (z === expect)
                         $display("PASS: a=%b b=%b c=%b z=%b", a, b, c, z);
                       else
                         $display("FAIL: a=%b b=%b c=%b z=%b", a, b, c, z);
                    end
               end
          end
        $finish;
     end

endmodule // LabL