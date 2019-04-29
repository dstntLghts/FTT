library ieee;
use ieee.std_logic_1164.all;

entity onebitregister is
        port(C, D : in std_logic;
             Q    : out std_logic
				 );
end onebitregister;
architecture archi of onebitregister is

 begin
      process (C)
      begin
           if (C'event and C='1') then
              Q <= D;
           end if;
       end process;
end archi;