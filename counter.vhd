----------------------------------------------------------------------------------
-- Company: UOA
-- Engineer: C.Tzeranis
-- 
-- Create Date:    16:58:19 12/26/2012 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity counter is 
      port ( clk : in std_logic;
            reset: in std_logic;
	          step: out std_logic_vector(4 downto 0);
            stage: out std_logic_vector(2 downto 0) 
            );				 
end counter;

architecture Behavioral of counter is

BEGIN
 PROCESS (clk,reset)
		VARIABLE sgnl2: INTEGER :=0;
      VARIABLE sgnl3: INTEGER :=0;	
   BEGIN
	IF reset = '0' THEN
      IF (clk'EVENT AND clk = '1') THEN
			IF (sgnl2 = 31) THEN 
				 sgnl3 := sgnl3 + 1;
				 sgnl2 := 0; 
				 ELSE  
				 sgnl2 := sgnl2 + 1;
			END IF; 
			IF (sgnl3 = 6)THEN 
				 sgnl3 := 0;
			END IF;
      END IF;
	ELSE 
	sgnl2 := -1;
	sgnl3 := 0;	
   END IF;  
	step <= std_logic_vector(to_unsigned(sgnl2,5));
	stage <= std_logic_vector(to_unsigned(sgnl3,3));
 END PROCESS;
end Behavioral;