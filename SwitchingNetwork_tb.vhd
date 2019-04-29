--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:26:50 01/29/2013
-- Design Name:   
-- Module Name:   /home/xhaar/FFT/SwitchingNetwork_tb.vhd
-- Project Name:  FFT
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SwitchingNetwork
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY SwitchingNetwork_tb IS
END SwitchingNetwork_tb;
 
ARCHITECTURE behavior OF SwitchingNetwork_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SwitchingNetwork
    PORT(
         InRA : IN  std_logic_vector(23 downto 0);
         InRB : IN  std_logic_vector(23 downto 0);
         InB1 : IN  std_logic_vector(23 downto 0);
         InB2 : IN  std_logic_vector(23 downto 0);
         stp : IN  std_logic_vector(4 downto 0);
         stg : IN  std_logic_vector(2 downto 0);
         clk : IN  std_logic;
         OutRA : OUT  std_logic_vector(23 downto 0);
         OutRB : OUT  std_logic_vector(23 downto 0);
         OutB1 : OUT  std_logic_vector(23 downto 0);
         OutB2 : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal InRA : std_logic_vector(23 downto 0) := (others => '0');
   signal InRB : std_logic_vector(23 downto 0) := (others => '0');
   signal InB1 : std_logic_vector(23 downto 0) := (others => '0');
   signal InB2 : std_logic_vector(23 downto 0) := (others => '0');
   signal stp : std_logic_vector(4 downto 0) := (others => '0');
   signal stg : std_logic_vector(2 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal OutRA : std_logic_vector(23 downto 0);
   signal OutRB : std_logic_vector(23 downto 0);
   signal OutB1 : std_logic_vector(23 downto 0);
   signal OutB2 : std_logic_vector(23 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: SwitchingNetwork PORT MAP (
          InRA => InRA,
          InRB => InRB,
          InB1 => InB1,
          InB2 => InB2,
          stp => stp,
          stg => stg,
          clk => clk,
          OutRA => OutRA,
          OutRB => OutRB,
          OutB1 => OutB1,
          OutB2 => OutB2
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

 stim_proc: process
   begin
      wait for 10 ns;
		InRA <= "000000000000000000000000";
	   InRB <= "000000000000000000000000";
		InB1 <= "000000000000000000000000";
		InB2 <= "000000000000000000000000";
      stp <= "00000";
      stg <= "000";
      wait for 10ns;		
		for I in 0 to 5 loop
		   for H in 0 to 32 loop
			    InRA <= "010101010101010101010101";
	          InRB <= "101010101010101010101010";
		       InB1 <= "111111110000000000111111";
		       InB2 <= "000000000111111111111000";
		       stg <= std_logic_vector(to_unsigned(I,3));
		    	 stp  <= std_logic_vector(to_unsigned(H,5));
				 wait for clk_period*10;
         end loop;
			wait for clk_period*10;
     end loop; 
   end process;
END;