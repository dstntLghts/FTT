library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SwitchingNetwork is 
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
end SwitchingNetwork;

architecture Behavioral of SwitchingNetwork is 
----------------------------------------------------------------------------
component Inverter is
		 Port ( invert : in  STD_LOGIC;
			     clk : in STD_LOGIC;
              In1 : in  STD_LOGIC_VECTOR (23 downto 0);
              In2 : in  STD_LOGIC_VECTOR (23 downto 0);
			    Out1 : out  STD_LOGIC_VECTOR (23 downto 0);
             Out2 : out  STD_LOGIC_VECTOR (23 downto 0)
			   );
end component;
----------------------------------------------------------------------------
component onebitregister is
		 Port( C : in std_logic;
		       D : in std_logic;
             Q : out std_logic
				);	
end component;
----------------------------------------------------------------------------			 
component sw_control is
		 port( step  : in std_logic_vector (4 downto 0);
             stage : in std_logic_vector (2 downto 0);
			    swIN  : out std_logic;
				 swOUT : out std_logic
			  );	 
end component;
--==================== Internal Signals ==================================--
	signal w_CLK 			: std_logic;
	signal w_reg2inv, w_reg2inv_d ,w_reg1inv    : std_logic;
	signal w_swin			: std_logic;
	signal w_swout	      : std_logic;
--============================ Wiring ====================================--
	begin
	w_CLK <= CLK ;
	
		INSW : Inverter 
		       port map( 
						  invert => w_reg1inv, 
							  clk => w_clk,
							  In1 => InRA,
							  In2 => InRB,
							 Out1 => OutRA,
							 Out2 => OutRB
						   );
		OUTsw: Inverter 
		       port map( 
						    invert => w_reg2inv_d,
							    clk => w_clk,
							    In1 => InB1,
							    In2 => InB2,
							   Out1 => OutB1,
							   Out2 => OutB2
							 );				
		DELAY : onebitregister 
		        port map( 
							  C => w_clk,
							  D => w_swout,
							  Q => w_reg2inv
							  );
							  
		DELAY2 : onebitregister 
		        port map( 
							  C => w_clk,
							  D =>  w_reg2inv,
							  Q => w_reg2inv_d
							  );
							  
		DELAY3 : onebitregister 
		        port map( 
							  C => w_clk,
							  D => w_swin,
							  Q => w_reg1inv
							  );
								
		SWCNTRL: sw_control 
		        port map( 
							  step  => stp,
							  stage => stg,
							  swIN  => w_swin,
							  swOUT => w_swout
			             );	 
end Behavioral;
