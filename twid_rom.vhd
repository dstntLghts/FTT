library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity twid_rom is	
generic(
	depth: integer:=32;
	twdlwidth: integer:=12;
	addr_width: integer:=5
	);

port (
	addr: IN std_logic_VECTOR(addr_width-1 downto 0);
	clk: IN std_logic;
	dout: OUT std_logic_VECTOR(2*twdlwidth-1 downto 0));
end twid_rom;

architecture Behavioral of twid_rom is
type rom_type is array ( 0 to depth-1) of std_logic_vector (23 downto 0);

--constant ROM : rom_type :=(
--x"7ff000",x"7f6f37",x"7d8e70",x"7a7dad",x"764cf0",x"70ec3a",x"6a6b8e",x"62faec",x"5a8a57",x"5139d0",x"471959",x"3c58f1",x"30f89b",x"252858",x"18f827",x"0c8809",
--x"000800",x"f37809",x"e70827",x"dad858",x"cf089b",x"c3a8f1",x"b8e959",x"aec9d0",x"a57a57",x"9d0aec",x"959b8e",x"8f1c3a",x"89bcf0",x"858dad",x"827e70",
--x"809f37");

constant ROM : rom_type :=(
x"7FF000",x"7F5F37",x"7D7E70",x"7A6DAD",x"763CF0",x"70DC3B",x"6A6B8E",x"62EAED",x"5A7A58",x"5129D1",x"471959",x"3C48F2",x"30F89C",x"252859",x"18F828",x"0C880A",
x"000801",x"F3780A",x"E70828",x"DAD859",x"CF089C",x"C3B8F2",x"B8E959",x"AED9D1",x"A58A58",x"9D1AED",x"959B8E",x"8F2C3B",x"89CCF0",x"859DAD",x"828E70",
x"80AF37");

begin

  process (clk)
    begin
      if rising_edge(clk) then
             dout <= ROM(conv_integer(addr))(2*twdlwidth-1 downto 0);  
      end if;
  end process;

end Behavioral;

