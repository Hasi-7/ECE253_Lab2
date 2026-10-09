`timescale 1ns / 1ns // `timescale time_unit/time_precision

// SW[2:0] data inputs;
// SW[9] select signals;

// LEDR[0] output display

module v7404(input logic pin1, pin3, pin5, pin9, pin11, pin13,
	         output logic pin2, pin4, pin6, pin8, pin10, pin12);

	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;

endmodule

module v7432 (input logic pin1, output logic pin3, input logic pin5, 
input logic pin9, output logic pin11, input logic pin13, input logic pin2, 
input logic pin4, output logic pin6, output logic pin8, input logic pin10, 
input logic pin12);

	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin9 | pin10;
	assign pin11 = pin12 | pin13;

endmodule

module v7408 (input logic pin1, output logic pin3, 
input logic pin5, input logic pin9, output logic pin11, 
input logic pin13, input logic pin2, input logic pin4, 
output logic pin6, output logic pin8, input logic pin10, 
input logic pin12);

	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin9 & pin10;
	assign pin11 = pin12 & pin13;

endmodule

module mux2to1(input logic x, input logic y, input logic s,output logic m);
    // x: select 0
    // y: select 1
    // s: select signal
    //m: output

	logic Sy_Out;
	logic S_Not;
	logic X_S_Not_Out;
	
	v7408 G1 (.pin1(s), .pin2(y), .pin3(Sy_Out));
	v7404 G2 (.pin1(s), .pin2(S_Not));
	G1 (.pin4(S_Not), .pin5(x), .pin6(X_S_Not_Out));
	v7432 G4 (.pin1(Sy_Out), .pin2(X_S_Not_Out), .pin3(m));

endmodule