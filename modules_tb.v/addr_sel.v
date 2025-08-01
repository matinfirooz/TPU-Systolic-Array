//////////////////////////////////////////////////////////////////////////////////
// Course: Hardware-Accelerators
// Engineer: Matin Firoozbakht
// Module Name: addr_sel
// Project Name: TPU-Systolic-Array
//////////////////////////////////////////////////////////////////////////////////
module addr_sel
(
	input clk,
	//max = 126, setting all of the addr127 = 0
	input [6:0] addr_serial_num,							
	
	//sel for w0~w7
	//queue 0~3
	output reg [9:0] sram_raddr_w0,
	//queue 4~7			
	output reg [9:0] sram_raddr_w1,			

	//sel for d0~d7
	output reg [9:0] sram_raddr_d0,
	output reg [9:0] sram_raddr_d1
);

//queue 0~3
wire [9:0] sram_raddr_w0_nx;
//queue 4~7			
wire [9:0] sram_raddr_w1_nx;			

//sel for d0~d7
wire [9:0] sram_raddr_d0_nx;
wire [9:0] sram_raddr_d1_nx;


//fit in output flip-flop
always@(posedge clk) begin				
	sram_raddr_w0 <= sram_raddr_w0_nx;
	sram_raddr_w1 <= sram_raddr_w1_nx;

	sram_raddr_d0 <= sram_raddr_d0_nx;
	sram_raddr_d1 <= sram_raddr_d1_nx;
end

assign sram_raddr_w0_nx = (addr_serial_num<=98)? { {3{1'd0}} , addr_serial_num} : 127;
assign sram_raddr_w1_nx = (addr_serial_num>=4 && addr_serial_num<=102)? { {3{1'd0}} , addr_serial_num-7'd4} : 127;

assign sram_raddr_d0_nx = (addr_serial_num<=98)? { {3{1'd0}} , addr_serial_num} : 127;
assign sram_raddr_d1_nx = (addr_serial_num>=4 && addr_serial_num<=102)? { {3{1'd0}} , addr_serial_num-7'd4} : 127;


endmodule
