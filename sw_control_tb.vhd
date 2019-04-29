LIBRARY ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
ENTITY sw_control_tb IS
END sw_control_tb;
 
ARCHITECTURE behavior OF sw_control_tb IS 
 
    COMPONENT sw_control
    PORT(
         step  : IN  std_logic_vector(4 downto 0);
         stage : IN  std_logic_vector(2 downto 0);
         swIN  : OUT  std_logic;
         swOUT : OUT  std_logic
        );
    END COMPONENT;
    
   signal step  : std_logic_vector(4 downto 0) := (others => '0');
   signal stage : std_logic_vector(2 downto 0) := (others => '0');
   signal swIN  : std_logic;
   signal swOUT : std_logic;
	
BEGIN
   uut: sw_control PORT MAP (
          step  => step,
          stage => stage,
          swIN  => swIN,
          swOUT => swOUT
        );
		  
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;
      step  <= "00000";
      stage <= "000"; 	
      wait for 10ns;		
		for I in 5 downto 0 loop
		   for H in 32 downto 0 loop
		       stage <= std_logic_vector(to_unsigned(I,3));
		    	 step  <= std_logic_vector(to_unsigned(H,5));
				 wait for 10ns;
         end loop;
			wait for 100ns;
     end loop; 
   end process;

END;