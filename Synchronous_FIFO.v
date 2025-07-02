// Design code for Synchronous FIFO

`timescale 1ns / 1ps
 
module Synchronous_FIFO #(
       parameter WIDTH = 8, //Data width
       parameter DEPTH = 16 //FIFO depth
)(
     input wire clk,
     input wire reset, //Asynchronous Reset
     input wire [WIDTH-1:0] data_in,
     input wire w_en,
     input wire r_en,
     output reg [WIDTH-1:0] data_out,
     output wire full,
     output wire empty
);

//Memory and pointers
reg [WIDTH-1:0] fifo [0:DEPTH-1];
reg [$clog2(DEPTH)-1:0] w_ptr,r_ptr;
reg [$clog2(DEPTH):0] count;

//Reset Logic
always @(posedge clk or negedge reset)
begin
  if (!reset)
  begin
    w_ptr <= 0;
    r_ptr <= 0;
    count <= 0;
    data_out <= 0;
  end
  else
  begin 
    //Write operation
    if(w_en && !full)          
    begin
      fifo[w_ptr] <= data_in;
      w_ptr <= (w_ptr + 1) % DEPTH;
      count <= count + 1;
    end
    //Read operation
    if(r_en && !empty)
    begin
      data_out <= fifo[r_ptr];
      r_ptr <= (r_ptr + 1) % DEPTH;
      count <= count - 1;
    end 
  end
end

//Status Flags
assign full = (count  == DEPTH);
assign empty = (count == 0);
   
endmodule
