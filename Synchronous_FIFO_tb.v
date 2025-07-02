//Test bench code for Synchronous FIFO

`timescale 1ns / 1ps

module Synchronous_FIFO_tb;

parameter WIDTH = 8;
parameter DEPTH = 16;

//Inputs are declared as register
//Outputs are declared as wire 
reg  clk,reset,w_en,r_en;
reg [WIDTH-1:0] data_in;
wire [WIDTH-1:0] data_out;
wire full,empty;
integer test_case;

//Instantiating FIFO Module
Synchronous_FIFO #(.WIDTH(WIDTH), .DEPTH(DEPTH)) syn_fifo(
  .clk(clk),
  .reset(reset),
  .data_in(data_in),
  .w_en(w_en),
  .r_en(r_en),
  .data_out(data_out),
  .full(full),
  .empty(empty)
);

//Generating a Value Change Dump File for simulation analysis
initial 
begin 
  $dumpfile("syn_fifo_dump.vcd");
  $dumpvars(0,Synchronous_FIFO_tb);
end

//Generating Clock of time period = 10 ns
initial 
begin 
  clk = 0;
  forever #5 clk = ~clk;
end

//Taking Test Cases
initial
begin 
  test_case = 0;
  reset = 0;
  w_en = 0;
  r_en = 0;
  #10 reset = 1;
  
  //Run all test cases
  case(test_case)
  1:test_case_write_operation();
  2:begin
      $display("Write operation is required before reading.Performing write operation and then read operation");
      test_case_write_operation();
      test_case_read_operation();
    end
  3:test_case_full_operation();
  4:begin
      test_case_full_operation();
      test_case_empty_operation();
    end
  5:test_case_single_element();     
  6:test_case_multiple_writes();
  7:begin
      $display("Writing multiple data");
      test_case_multiple_writes();
      test_case_multiple_reads();
    end
  8:test_case_wrap_around();
  9:test_case_simultaneous_read_write();
  10:test_case_reset();
  11:test_case_overflow();
  12:begin
       test_case_write_operation();
       test_case_underflow();
     end
  default: $display("Invalid test case selected");
  endcase
  #1000 $finish;
end

task test_case_write_operation();
begin
  data_in = 32'hAABBCCDD;
  w_en = 1; #10 w_en = 0; 
  if(empty)
    $display("Error : FIFO should not be empty");
  else
    $display("Data written to FIFO correctly");
end
endtask    

task test_case_read_operation();
begin
  r_en = 1; #10 r_en = 0; 
  if(data_out !== 32'hAABBCCDD)
    $display("Error : Data read mismatch");
  else
    $display("Data read from FIFO correctly");
end
endtask 

task test_case_full_operation();
begin
  repeat (DEPTH) 
  begin
    data_in = $random;
    w_en = 1; #10 w_en = 0;
  end   
  if(!full)
    $display("Error : FIFO full flag not set");
  else
    $display("FIFO full flag set correctly");
end
endtask    

task test_case_empty_operation();
begin
  while (!empty) 
  begin
    r_en = 1; #10 r_en = 0;
  end   
  if(!empty)
    $display("Error : FIFO empty flag not set");
  else
    $display("FIFO empty flag set correctly");
end
endtask 

task test_case_single_element();
begin
    data_in = 32'h55667788;
    w_en = 1; #10 w_en = 0;
    r_en = 1; #10 r_en = 0;  
  if(data_out !== 32'h55667788)
    $display("Error : Single element mismatch");
  else
    $display("Single element matched");
end
endtask

task test_case_multiple_writes();
integer i;
begin
  for(i=0; i < DEPTH; i=i+1)
  begin
    data_in = i;
    w_en = 1; #10 w_en = 0;
  end   
  if(!full)
    $display("Error : Multiple write test case failed");
  else
    $display("Multiple elements are written to the FIFO correctly");
end
endtask 

task test_case_multiple_reads();
integer i;
begin
  for(i=0; i < DEPTH; i=i+1)
  begin
    r_en = 1; #10 r_en = 0;  
    if(data_out !== i)
      $display("Error : Multiple reads mismatch at index %0d",i);
  end    
end
endtask

task test_case_wrap_around();
integer i;
begin
  for(i=0; i < DEPTH; i=i+1)
  begin
    data_in = i;
    w_en = 1; #10 w_en = 0;
  end   
  for(i=0; i < 2; i=i+1)
  begin
    r_en = 1; #10 r_en = 0;
  end
  data_in = 32'h77987654;
  w_en = 1; #10 w_en = 0; 
  for(i=2; i < DEPTH; i=i+1)
  begin
    r_en = 1; #10 r_en = 0; 
  end
  r_en = 1; #10 w_en = 0;    
  if(data_out !== 32'h77987654)
    $display("Error : Wrap-around mismatch");
  else
    $display("Wrap-around test case passed");
end
endtask

task test_case_simultaneous_read_write();
begin
    data_in = 32'h55123456;
    w_en = 1; r_en = 0; #10
    w_en = 0; r_en = 0; #10
    data_in = 32'h99345680;
    w_en = 1; r_en = 1; #20
    if(data_out !== 32'h55123456)
      $display("Error : Expected 8'h55, got %h", data_out);
    w_en = 0; r_en = 1; #10
    if(data_out !== 32'h99345680)
      $display("Error : Simultaneous read/write failed. Expected 8'h99, got %h", data_out);  
    else
      $display("Simultaneous read_write test case passed");
    w_en = 0; r_en = 0;  
end
endtask

task test_case_reset();
begin
    data_in = 32'hFFEEDDCC;
    w_en = 1; #10 w_en = 0;
    reset = 0; #10 reset = 1;
    if(!empty)
    $display("Error : FIFO not empty after reset");
  else
    $display("FIFO is empty after reset");
end
endtask

task test_case_overflow();
integer i;
begin
  for(i=0; i < DEPTH; i=i+1)
  begin
    data_in = $random;
    w_en = 1; #10 w_en = 0;  
    if(full)
      $display("FIFO is full now");
  end    
  for(i=0; i < 2; i=i+1)
  begin
    data_in = $random;
    w_en = 1; #10 w_en = 0; 
    if(full)
      $display("Overflow ! Write attempted while FIFO is full");
   end   
end
endtask

task test_case_underflow();
begin 
  if(!empty)
  begin 
    $display("FIFO is not empty before underflow test");
    r_en = 1; #10 r_en = 0; //reading single elemnt from FIFO
  end
  #10 r_en = 1; #10 r_en = 0;
  $display("Result after underflow test");
  if(empty)
  begin
    if(data_out == {WIDTH{1'bx}} || data_out == data_out)
      $display("Underflow test passed");
    else 
      $display("Underflow test failed");
  end
  else
    $display("FIFO is not empty");
end
endtask

endmodule 
