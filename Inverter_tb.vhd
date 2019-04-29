--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:28:01 01/28/2013
-- Design Name:   
-- Module Name:   /home/xhaar/FFT/Inverter_tb.vhd
-- Project Name:  FFT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Inverter
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Inverter_tb IS
END Inverter_tb;
 
ARCHITECTURE behavior OF Inverter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Inverter
    PORT(
         invert : IN  std_logic;
         clk : IN  std_logic;
         In1 : IN  std_logic_vector(23 downto 0);
         In2 : IN  std_logic_vector(23 downto 0);
         Out1 : OUT  std_logic_vector(23 downto 0);
         Out2 : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal invert : std_logic := '0';
   signal clk : std_logic := '0';
   signal In1 : std_logic_vector(23 downto 0) := (others => '0');
   signal In2 : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal Out1 : std_logic_vector(23 downto 0);
   signal Out2 : std_logic_vector(23 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Inverter PORT MAP (
          invert => invert,
          clk => clk,
          In1 => In1,
          In2 => In2,
          Out1 => Out1,
          Out2 => Out2
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
       In1 <= "111111111111111111111111";
       In2 <= "000000000000000000000000";
		 invert <= '1';
      wait for clk_period*10;
		 In1 <= "111111111111111111111111";
       In2 <= "000000000000000000000000";
		 invert <= '0';
      wait for clk_period*10;
		 In1 <= "000000000000000000000000";
       In2 <= "111111111111111111111111";
		 invert <= '1';
      wait for clk_period*10;
       In1 <= "000000000000000000000000";
       In2 <= "111111111111111111111111";
		 invert <= '0';
		 wait;
   end process;
END;