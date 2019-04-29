--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:39:37 02/02/2013
-- Design Name:   
-- Module Name:   /home/xhaar/FFT/address_gen_tb_v2.vhd
-- Project Name:  FFT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: address_generator
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY address_gen_tb IS
END address_gen_tb;
 
ARCHITECTURE behavior OF address_gen_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT address_generator
    PORT(
         stage : IN  std_logic_vector(2 downto 0);
         step : IN  std_logic_vector(4 downto 0);
         clk : IN  std_logic;
         read0 : OUT  std_logic_vector(4 downto 0);
         read1 : OUT  std_logic_vector(4 downto 0);
         write0 : OUT  std_logic_vector(4 downto 0);
         write1 : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal stage : std_logic_vector(2 downto 0) := (others => '0');
   signal step : std_logic_vector(4 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal read0 : std_logic_vector(4 downto 0);
   signal read1 : std_logic_vector(4 downto 0);
   signal write0 : std_logic_vector(4 downto 0);
   signal write1 : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: address_generator PORT MAP (
          stage => stage,
          step => step,
          clk => clk,
          read0 => read0,
          read1 => read1,
          write0 => write0,
          write1 => write1
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
      wait for clk_period/2;

      -- insert stimulus here 
		for j in 0 to 5 loop
			stage <= std_logic_vector(to_unsigned(j,3));
			for i in 0 to 31 loop
				step <= std_logic_vector(to_unsigned(i,5));
				wait for clk_period;
			end loop;
		end loop;
      wait;
   end process;

END;