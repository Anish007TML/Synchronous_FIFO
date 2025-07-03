# Synchronous_FIFO Design and Verification
A synchronous FIFO is a data buffer circuit which provides sequential data flow between two systems, synchronizing them using a common clock.
Here is a block diagram for synchronous FIFO :-

![image](https://github.com/user-attachments/assets/87ad34f2-4ab7-44b3-b469-a6a449c753c1)

This project implements a Synchronous FIFO in Verilog HDL, designed for simulation and synthesis in Xilinx Vivado. The FIFO operates on a single clock domain, supports parameterized data width and depth, and includes control/status signals like full, empty, w_en, r_en and reset.

**Design Module**

The Synchronous_FIFO module is designed to ensure efficient data handling in digital systems. Proper configuration prevents common issues like overflow or underflow, guaranteeing reliable data management. The FIFO operates on a single clock domain and supports configurable data width and depth. It uses a circular buffer with read and write pointers, and a counter to track the number of elements in the queue.

**PARAMETERS**
| Parameter | Description       | Default |
| --------- | ----------------- | ------- |
| WIDTH     | Data bus width    | 8       |
| DEPTH     | FIFO memory depth | 16      |

**INPUT AND OUTPUT PORTS**
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

**Test Bench Case Implementation**

The testbench for the FIFO module generates random data and writes it to the FIFO, then reads it back and compares the results. The test bench encompasses a wide range of tests designed to rigourously validate the FIFO's operation.
Functional tests verify the FIFO's basic operations: write, read, full and empty condition.
Stress tests evaluate behaviour under extreme conditions such as wrap-around, simultaneous read/write, and overflow/underflow.
Reset and Duration tests confirm the correct reset functionalitu and long-term stability.
This comprehensive approach guarantees robust performance.

The test cases are :- 
1. **Write Operation Test** - Writing a single element into the FIFO when it is not full to ensure that FIFO should not be longer be empty after the write.
2. **Read Operation Test** - Reading data from the FIFO when it is not empty to ensure the data read matches the expected value.
3. **Full Condition Test** - Write elements until the FIFO is full flag to ensure the full flag is asserted when FIFO reaches capacity.
4. **Empty Condition Test** - Reading elements until the FIFO is empty and check the empty flag and then verify that the empty flag is high when FIFO is empty.
5. **Single Element Write/Read Test** - Write and then single element to validate basic operation.
6. **Multiple Writes Test** - Write multiple elements sequentially without reading.
7. **Multiple Reads Test** - Read multiple elements after writing them to ensure FIFO behaviour.
8. **Reset Functionality Test** - Reset the FIFO during operation and verify pointers and flags.
9. **Wrap-around Test** - This test ensures that the FIFO correctly wraps pointers when the buffer reaches it maximum capacity, validating data integrity after pointer rollover.
10. **Simultaneous Read/Write Test** - This test checks the behaviour of FIFO under concurrent read and write operations to confirm no conflicts or race conditions occur.
11. **Overflow Handling Test** - This test ensures the FIFO behaves correctly when attempting to write to a full buffer and ignore writes when full.
12. **Underflow Handling Test** - This test ensures the FIFO behaves correctly when attempting to read from an empty buffer, preventing invalid data access.

The testbench uses a single clock for writing and reading, and includes reset signal to initialize the FIFO. The testbench finishes after running the test cases.

**Simulation Waveforms**

Test Case 1 : Write Operation Test
![image](https://github.com/user-attachments/assets/f6ff315d-fad9-4dfb-9cc0-6318dde2a78b)

Test Case 2 : Read Operation Test
![image](https://github.com/user-attachments/assets/8927237e-7b6d-49f7-95ad-028254f0766b)

Test Case 3 : Full Condition Test
![image](https://github.com/user-attachments/assets/1c14b300-d747-4e25-8aac-0b18d88a75ab)

Test Case 4 : Empty Condition Test
![image](https://github.com/user-attachments/assets/cde1edd2-8c0e-4fb8-b4a6-30446bff17fd)

Test Case 5 : Single Element Write/Read Test
![image](https://github.com/user-attachments/assets/af854b50-1696-4708-b957-025b843cba94)

Test Case 6 : Multiple Writes Test
![image](https://github.com/user-attachments/assets/23520f9d-b428-40ad-b1a1-06cfc6f196a3)

Test Case 7 : Multiple Reads Test
![image](https://github.com/user-attachments/assets/55c4ea26-38db-431d-b354-48b6fad60eed)

Test Case 8 : Reset Functionality Test
![image](https://github.com/user-attachments/assets/3a86ec10-f750-44d0-aa46-be0a0cdf894f)

Test Case 9 : Wrap-around Test
![image](https://github.com/user-attachments/assets/254270bf-a2de-4be2-bdf5-76b0f5753a42)

Test Case 10 : Simultaneous Read/Write Test
![image](https://github.com/user-attachments/assets/bf5aa5e9-1cb1-44d0-9ef4-12250fe6ed5d)

Test Case 11 : Overflow Handling Test 
![image](https://github.com/user-attachments/assets/5d41f0fa-c5b0-40d0-8e69-9ae1816bde57)

Test Case 12 : Underflow Handling Test
![image](https://github.com/user-attachments/assets/d88e27fe-25d1-4b81-94c1-7ba0b1c3f1e5)

**Results**

The synchronous FIFO design was tested using a testbench. The following key results were observed:-
1. Correct Data Storage and Retrieval: The FIFO correctly stored data when written to and retrieved the exact same data when read from. This was validated across multiple test cases with varying data patterns.
2. Full and Empty Conditions: The FIFO accurately indicated full and empty conditions. When the FIFO was full, additional write operations were correctly prevented, and when the FIFO was empty, additional read operations were correctly halted.

**Applications**
1. Keyboard input buffering
2. Data transfer between modules
3. Temporary storage in image processing
4. Communication in FPGA systems

**Conclusion**

The synchronous FIFO was successfully designed, implemented, and verified in Vivado using Verilog HDL. The FIFO efficiently handles data transfer between modules operating under the same clock domain, ensuring smooth and reliable data flow. Simulation and synthesis results confirmed correct functionality, with proper handling of full, empty, read, and write operations. This design can now be integrated into larger digital systems such as processors, image buffers, or communication interfaces.















