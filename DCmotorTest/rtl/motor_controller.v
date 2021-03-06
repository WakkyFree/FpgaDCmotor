module motor_controller #(
  parameter DEAD_TIME = 27'd124999999
) (
input         CLK,
input         RST,
input         SW,
input         BTN,

output        MOTOR_DIR,
output        MOTOR_EN
);

reg r_motor_dir;
reg [26:0]  r_counter;

always @ (posedge CLK) begin
  r_motor_dir <= MOTOR_DIR;
end

always @ (posedge CLK) begin  // dead time
  if (RST)
    r_counter <= 27'd0;
  else if (r_motor_dir ^ MOTOR_DIR)  // r_counter start
    r_counter <= r_counter + 27'd1;
  else if (r_counter == DEAD_TIME)
    r_counter <= 27'd0;
  else if (|r_counter)
    r_counter <= r_counter + 27'd1;
  else
    r_counter <= 27'd0;
end

assign MOTOR_DIR = SW;
assign MOTOR_EN = BTN & ~|r_counter;

endmodule
