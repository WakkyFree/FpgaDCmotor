module zybo_top (

input         CLK,
input         RST,
input         SW0,
input         BTN0,

output [3:0]  LED,
output        MOTOR_DIR1,
output        MOTOR_EN1,
output        MOTOR_DIR2,
output        MOTOR_EN2

);

motor_controller #(.DEAD_TIME(27'd124999999)) motor_controller1 (
  .CLK(CLK),
  .RST(RST),
  .SW(SW0),
  .BTN(BTN0),

  .MOTOR_DIR(MOTOR_DIR1),
  .MOTOR_EN(MOTOR_EN1)
);

assign LED[0] = MOTOR_DIR1;
assign LED[1] = MOTOR_EN1;
assign LED[2] = SW0;
assign LED[3] = BTN0;

assign MOTOR_DIR2 = 1'b0;
assign MOTOR_EN2 = 1'b0;

endmodule
