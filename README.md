# Synchronous_FIFO Design and Verification
A synchronous FIFO is a data buffer circuit which provides sequential data flow between two systems, synchronizing them using a common clock.
Here is a block diagram for synchronous FIFO :-
![image](https://github.com/user-attachments/assets/87ad34f2-4ab7-44b3-b469-a6a449c753c1)
This project implements a Synchronous FIFO in Verilog HDL, designed for simulation and synthesis in Xilinx Vivado. The FIFO operates on a single clock domain, supports parameterized data width and depth, and includes control/status signals like full, empty, w_en, r_en and reset.

Design Module
The Synchronous_FIFO module is designed to ensure efficient data handling in digital systems. Proper configuration prevents common issues like overflow or underflow, guaranteeing reliable data management.  

PARAMETERS
| Parameter | Description       | Default |
| --------- | ----------------- | ------- |
| WIDTH     | Data bus width    | 8       |
| DEPTH     | FIFO memory depth | 16      |

INPUT AND OUTPUT PORTS
| Port       | Direction | Description            |
| ---------- | --------- | ---------------------- |
|  clk       | Input     | System clock           |
|  reset     | Input     | Asynchronous reset     |
|  data_in   | Input     | Data to be written     |
|  w_en      | Input     | Write enable           |
|  r_en      | Input     | Read enable            |
|  data_out  | Output    | Data being read        |
|  full      | Output    | FIFO full status flag  |
|  empty     | Output    | FIFO empty status flag |

Test Bench Module Implementation
The test bench encompasses a wide range of tests designed to rigourously validate the FIFO's operation.
Functional tests verify the FIFO's basic operations: write, read, full and empty condition.
Stress tests evaluate behaviour under extreme conditions such as wrap-around, simultaneous read/write, and overflow/underflow.
Reset and Duration tests confirm the correct reset functionalitu and long-term stability.
This comprehensive approach guarantees robust performance.
The test cases are :- 
1. Write Operation Test - Writing a single element into the FIFO when it is not full to ensure that FIFO should not be longer be empty after the write.
2. Read Operation Test - Reading data from the FIFO when it is not empty to ensure the data read matches the expected value.
3. Full Condition Test - Write elements until the FIFO is full flag to ensure the full flag is asserted when FIFO reaches capacity.
4. Empty Condition Test - Reading elements until the FIFO is empty and check the empty flag and then verify that the empty flag is high when FIFO is empty.
5. Single Element Write/Read Test - Write and then single element to validate basic operation.
6. Multiple Writes Test - Write multiple elements sequentially without reading.
7. Multiple Reads Test - Read multiple elements after writing them to ensure FIFO behaviour.
8. Reset Functionality Test - Reset the FIFO during operation and verify pointers and flags.
9. Wrap-around test - This test ensures that the FIFO correctly wraps pointers when the buffer reaches it maximum capacity, validating data integrity after pointer rollover.
10. Simultaneous Read/Write Test - This test checks the behaviour of FIFO under concurrent read and write operations to confirm no conflicts or race conditions occur.
11. Overflow Handling Test - This test ensures the FIFO behaves correctly when attempting to write to a full buffer and ignore writes when full.
12. Underflow Handling Test - This test ensures the FIFO behaves correctly when attempting to read from an empty buffer, preventing invalid data access.

SIMULATION WAVEFORM
Test Case 1 : WRITE OPERATION TEST
![image](https://github.com/user-attachments/assets/f6ff315d-fad9-4dfb-9cc0-6318dde2a78b)




