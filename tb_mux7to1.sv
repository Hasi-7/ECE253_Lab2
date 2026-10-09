`timescale 1ns / 1ps

module tb_mux7to1;
    logic [2:0] MuxSelect;
    logic [6:0] MuxIn;
    logic Out;
    logic expected;
    integer data, sel, errors;

    mux7to1 dut (.MuxSelect(MuxSelect), .MuxIn(MuxIn), .Out(Out));

    initial begin
        errors = 0;
        for (data = 0; data < 128; data = data + 1) begin
            for (sel = 0; sel < 8; sel = sel + 1) begin
                MuxIn = data;
                MuxSelect = sel;
                #1;
                expected = (sel == 7) ? 1'b0 : MuxIn[sel];
                if (Out !== expected) begin
                    if (errors < 10)
                        $display("FAIL: MuxIn=%b MuxSelect=%b expected=%b got=%b",
                                 MuxIn, MuxSelect, expected, Out);
                    errors = errors + 1;
                end
            end
        end

        if (errors == 0)
            $display("PASS: all 1024 mux7to1 input combinations");
        else
            $fatal(1, "FAIL: %0d of 1024 input combinations", errors);
        $finish;
    end
endmodule
