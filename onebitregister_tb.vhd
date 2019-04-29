LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY onebitregister_tb IS
END onebitregister_tb;
 
ARCHITECTURE behavior OF onebitregister_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT onebitregister
    PORT(
         C : IN  std_logic;
         D : IN  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal C : std_logic := '0';
   signal D : std_logic := '0';

 	--Outputs
   signal Q : std_logic;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: onebitregister PORT MAP (
          C => C,
          D => D,
          Q => Q
        );
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
      C <= '0';
      D <= '0';
      wait for 10 ns;	
      C <= '1';
      D <= '0';
		wait for 10 ns;	
      C <= '0';
      D <= '1';
		wait for 10 ns;	
      C <= '1';
      D <= '1';
		wait for 10 ns;	
      C <= '0';
      D <= '1';
		wait for 10 ns;	
      C <= '1';
      D <= '0';
   end process;

END;
