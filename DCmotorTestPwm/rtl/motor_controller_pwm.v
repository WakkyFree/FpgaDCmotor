module motor_controller_pwm #(
  parameter DEAD_TIME = 27'd124999999
) (
input         CLK,  //125MHz
input         RST,
input         SW,
input         BTN,
input         PWM_EN,

output        MOTOR_DIR,
output        MOTOR_EN
);

parameter PWM_TIME = 17'd124999;        //1msec(pwm frequency : 1kHz)
parameter DUTY_LOW_TIME = 17'd74999;    //0.6msec(Duty ratio : 60%)

reg r_motor_dir;
reg [26:0]  r_dead_time_counter;
reg [16:0]  r_pwm_counter;

wire w_pwm_enable;

always @ (posedge CLK) begin
  r_motor_dir <= MOTOR_DIR;
end

always @ (posedge CLK) begin  // dead time counter
  if (RST)
    r_dead_time_counter <= 27'd0;
  else if (r_motor_dir ^ MOTOR_DIR)  //counter start
    r_dead_time_counter <= r_dead_time_counter + 27'd1;
  else if (r_dead_time_counter == DEAD_TIME)
    r_dead_time_counter <= 27'd0;
  else if (|r_dead_time_counter)
    r_dead_time_counter <= r_dead_time_counter + 27'd1;
  else
    r_dead_time_counter <= 27'd0;
end

always @ (posedge CLK) begin  // pwm coutner
  if (RST)
    r_pwm_counter <= 17'd0;
  else if (BTN & ~|r_dead_time_counter) 
    r_pwm_counter <= r_pwm_counter + 17'd1;
  else if (r_pwm_counter == PWM_TIME)
    r_pwm_counter <= 17'd0;
  else
    r_pwm_counter <= 17'd0;
end

assign w_pwm_enable = (r_pwm_counter > 11'd0) && (r_pwm_counter <= DUTY_LOW_TIME);

assign MOTOR_DIR = SW;
assign MOTOR_EN = PWM_EN ? w_pwm_enable: BTN & ~|r_dead_time_counter;

endmodule
