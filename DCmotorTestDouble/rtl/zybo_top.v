module zybo_top (

input         CLK,
input         RST,
input         SW0,
input         SW1,
input         BTN0,
input         BTN1,

output [3:0]  LED,
output        MOTOR_EN1,
output        MOTOR_EN2,
output        MOTOR_DIR1,
output        MOTOR_DIR2

);

parameter DEAD_TIME = 27'd124999999;

motor_controller #(.DEAD_TIME(DEAD_TIME)) motor_controller1 (
  .CLK(CLK),
  .RST(RST),
  .SW(SW0),
  .BTN(BTN0),

  .MOTOR_DIR(MOTOR_DIR1),
  .MOTOR_EN(MOTOR_EN1)
);

motor_controller #(.DEAD_TIME(DEAD_TIME)) motor_controller2 (
  .CLK(CLK),
  .RST(RST),
  .SW(SW1),
  .BTN(BTN1),

  .MOTOR_DIR(MOTOR_DIR2),
  .MOTOR_EN(MOTOR_EN2)
);

assign LED[0] = MOTOR_DIR1;
assign LED[1] = MOTOR_DIR2;
assign LED[2] = MOTOR_EN1;
assign LED[3] = MOTOR_EN2;

endmodule
