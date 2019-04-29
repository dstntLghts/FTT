----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:03:31 02/02/2013 
-- Design Name: 
-- Module Name:    FFToplvl - Behavioral 
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
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity FFToplvl is 
                  port( 
								clk: in std_logic;
								SYNC_IN: in std_logic;
								we: in std_logic;
								SYNC_OUT: out std_logic;                                 
                                x1: out std_logic_vector( 23 downto 0);
								x2: out std_logic_vector( 23 downto 0) 
                       );						 
end FFToplvl;

architecture Behavioral of FFToplvl is
----------------------------------------------------------------------------
component counter is 
               port( 
					 clk : in std_logic;
               reset: in std_logic;
	             step: out std_logic_vector(4 downto 0);
               stage: out std_logic_vector(2 downto 0) 
                   );				 
end component;
----------------------------------------------------------------------------
component SwitchingNetwork is
							  port(
							  InRA : in std_logic_vector(23 downto 0);
							  InRB : in std_logic_vector(23 downto 0);
							  InB1 : in std_logic_vector(23 downto 0);
							  InB2 : in std_logic_vector(23 downto 0);
								stp : in std_logic_vector(4 downto 0);
								stg : in std_logic_vector(2 downto 0);
								clk : in std_logic;
							 OutRA : out std_logic_vector(23 downto 0);
							 OutRB : out std_logic_vector(23 downto 0);
							 OutB1 : out std_logic_vector(23 downto 0);
							 OutB2 : out std_logic_vector(23 downto 0)
							      );								  
end component;
----------------------------------------------------------------------------
component address_generator is
                   port( 
				       stage : in  STD_LOGIC_VECTOR (2 downto 0);	
                    step : in  STD_LOGIC_VECTOR (4 downto 0);
                     clk : in  STD_LOGIC;
                   read0 : out  STD_LOGIC_VECTOR (4 downto 0);
                   read1 : out  STD_LOGIC_VECTOR (4 downto 0);
					twid_addr : out  std_logic_vector(4 downto 0);
						write0 : out  STD_LOGIC_VECTOR (4 downto 0);
                  write1 : out  STD_LOGIC_VECTOR (4 downto 0)           
			              );
end component;
----------------------------------------------------------------------------
component stage is
	            generic(
			              bits: integer:=12
			              );
                  port(
		            clk : in STD_LOGIC;
				  inputX1 : in STD_LOGIC_VECTOR (2*bits-1 downto 0);
				  inputX2 : in STD_LOGIC_VECTOR (2*bits-1 downto 0);
				  output1 : out STD_LOGIC_VECTOR (2*bits-1 downto 0);
				  output2 : out STD_LOGIC_VECTOR (2*bits-1 downto 0);
		   twiddle_addr : in STD_LOGIC_VECTOR (4 downto 0)		
	                   );
end component;
----------------------------------------------------------------------------
component DRAM0 is 
               port(
					 clk   : in std_logic;
			       we    : in std_logic;
					raddr  : in std_logic_vector(4 downto 0); --read address
					waddr  : in std_logic_vector(4 downto 0);	--write address
					din    : in std_logic_vector(23 downto 0);
					dout   : out std_logic_vector(23 downto 0)
     );
end component;
----------------------------------------------------------------------------
component DRAM1 is 
               port(
					 clk   : in std_logic;
			       we    : in std_logic;
					raddr  : in std_logic_vector(4 downto 0); --read address
					waddr  : in std_logic_vector(4 downto 0);	--write address
					din    : in std_logic_vector(23 downto 0);
					dout   : out std_logic_vector(23 downto 0)
                   );
end component;
--==================== Internal Signals ==================================--
	signal w_CLK       : std_logic;
	signal w_WE        : std_logic;
	signal w_stage     : std_logic_vector  (2 downto 0) := (others => '0');
	signal w_step      : std_logic_vector  (4 downto 0) := (others => '0');
	signal w_wradrs1   : std_logic_vector  (4 downto 0) := (others => '0');
	signal w_wradrs2   : std_logic_vector  (4 downto 0) := (others => '0');
	signal w_rdadrs1   : std_logic_vector  (4 downto 0) := (others => '0');
	signal w_rdadrs2   : std_logic_vector  (4 downto 0) := (others => '0');
	signal w_twdleadrs : std_logic_vector  (4 downto 0) := (others => '0');
	signal w_fromRAM1  : std_logic_vector (23 downto 0) := (others => '0');
	signal w_fromRAM2  : std_logic_vector (23 downto 0) := (others => '0'); 
	signal w_fromswIN1 : std_logic_vector (23 downto 0) := (others => '0');
	signal w_fromswIN2 : std_logic_vector (23 downto 0) := (others => '0');
	signal w_frombf1   : std_logic_vector (23 downto 0) := (others => '0');
	signal w_frombf2   : std_logic_vector (23 downto 0) := (others => '0');
	signal w_fromswOUT1: std_logic_vector (23 downto 0) := (others => '0');
	signal w_fromswOUT2: std_logic_vector (23 downto 0) := (others => '0');
--============================ Wiring ====================================--
begin
 w_CLK <= clk;
  w_WE <= we;
 x1 <= w_frombf1;
 x2 <= w_frombf2;
  SYNC_OUT<= ((w_stage(2)) AND (not(w_stage(1))) AND ((w_stage(0))) AND (not(w_step(4))) AND ( not(w_step(3))) AND ( not(w_step(2))) AND ( w_step(1) ) AND (not(w_step(0))));
  
  
     STEPER: counter  port map(
			       clk => w_CLK,
              reset => SYNC_IN,
	            step => w_step,
              stage => w_stage
                   );			

		RAM1: DRAM0
		     port map(
			         clk => w_CLK,
                   we => w_WE,
					 waddr => w_wradrs1,
                raddr => w_rdadrs1,
                   din => w_fromswOUT1,
                  dout => w_fromRAM1
						);

	   RAM2: DRAM1
		     port map(
			         clk => w_CLK,
                   we => w_WE,
					 waddr => w_wradrs2,
                raddr => w_rdadrs2,
                   din => w_fromswOUT2,
                  dout => w_fromRAM2
						);

      SWIO: SwitchingNetwork 
		     port map(
			   	  InRA => w_fromRAM1,
					  InRB => w_fromRAM2,
					  InB1 => w_frombf1,
					  InB2 => w_frombf2,
						stp => w_step,
					   stg => w_stage,
					   clk => w_CLK,
					 OutRA => w_fromswIN1,
					 OutRB => w_fromswIN2,
					 OutB1 => w_fromswOUT1,
					 OutB2 => w_fromswOUT2
						  );					
						  
	BttrFly: stage
	    generic map(bits =>12)
          port map(
                  clk => w_CLK,
		        inputX1 =>w_fromswIN1,
		        inputX2 =>w_fromswIN2,
		        output1 =>w_frombf1,
		        output2 =>w_frombf2,
		   twiddle_addr =>w_twdleadrs
                   );
						
AddrssGnrtr:address_generator
           port map( 
					 stage => w_stage,
					  step => w_step, 
					   clk => w_CLK,
					 read0 => w_rdadrs1,
					 read1 => w_rdadrs2,
			   twid_addr => w_twdleadrs,
					write0 => w_wradrs1,
					write1 => w_wradrs2  					
					     );						
  
end Behavioral;
