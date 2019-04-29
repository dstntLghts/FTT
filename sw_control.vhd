library IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

entity sw_control is
                    port( step  : in std_logic_vector (4 downto 0);
                          stage : in std_logic_vector (2 downto 0);
								  swIN  : out std_logic;
								  swOUT : out std_logic
								 );
end sw_control;

architecture Behavioral of sw_control is

begin
     stg: process(step,stage) is
      begin
          case stage is 
               when "000" => swIN  <= '0';
									  swOUT <= step(0);
               when "001" => swIN  <= step(0);
                             swOUT <= step(1); 
               when "010" => swIN  <= step(1);
                             swOUT <= step(2);												  
               when "011" => swIN  <= step(2);
                             swOUT <= step(3);							  
               when "100" => swIN  <= step(3);
                             swOUT <= step(4);											  
               when "101" => swIN  <= step(4);
								     swOUT <= '0';
               when others =>swIN  <= '0';
								     swOUT <= '0';												  
         end case;
    end process stg;
end Behavioral;