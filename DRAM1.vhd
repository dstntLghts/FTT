----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;


entity DRAM1 is port(    
         clk   : in std_logic;
			we    : in std_logic;
			raddr : in std_logic_vector(4 downto 0); --read address
			waddr : in std_logic_vector(4 downto 0);	--write address
			din   : in std_logic_vector(23 downto 0);
			dout  : out std_logic_vector(23 downto 0)
                    );
end DRAM1;

architecture Behavioral of DRAM1 is

type dram_type is array (0 to 31) of std_logic_vector(23 downto 0);


--init Bank_1 from file bank_1.dat--
impure function InitRamFromFile (RamFileName : in string) return dram_type is
	FILE 		RamFile 		: text is in RamFileName;
	variable RamFileLine : line;
	variable RAM			: dram_type;
	
begin
	for i in 0 to 31 loop
		readline(RamFile, RamFileLine);
		hread (RamFileLine, RAM(i));
	end loop;
	return RAM;
end function;
-----------------------------------------


signal RAM : dram_type:=InitRamFromFile("X2.dat");


begin
 process(clk)
  begin
	if rising_edge(clk) then
		if we = '1' then
			ram(conv_integer(waddr)) <= din;
		end if;
			dout <= ram(conv_integer(raddr));
	end if;
end process;
end Behavioral;