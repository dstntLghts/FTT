library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Inverter is
    Port ( invert : in  STD_LOGIC;
			  clk : in STD_LOGIC;
           In1 : in  STD_LOGIC_VECTOR (23 downto 0);
           In2 : in  STD_LOGIC_VECTOR (23 downto 0);
			  Out1 : out  STD_LOGIC_VECTOR (23 downto 0);
           Out2 : out  STD_LOGIC_VECTOR (23 downto 0)
			 );
end Inverter;

architecture Behavioral of Inverter is

begin

process (invert,In2,In1)
begin
	
		if (invert='1') then
			Out1<=In2;
			Out2<=In1;
		else
			Out1<=In1;
			Out2<=In2;
		end if;

end process;

end Behavioral;
