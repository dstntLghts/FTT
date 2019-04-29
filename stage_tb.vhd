library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
USE ieee.std_logic_textio.all;
use std.textio.all; 
entity stage_tb is
	generic(
			bits: integer:=12
			);
end entity;

Architecture Beh of stage_tb is
    
    component stage is
port 
   (
			  clk,SYNC_IN		: in STD_LOGIC;
		      inputX1 : in STD_LOGIC_VECTOR (2*bits-1 downto 0);
		      inputX2 : in STD_LOGIC_VECTOR (2*bits-1 downto 0);
		      output1 : out STD_LOGIC_VECTOR (2*bits-1 downto 0);
		      output2 : out STD_LOGIC_VECTOR (2*bits-1 downto 0);
		      twiddle_addr :in STD_LOGIC_VECTOR (4 downto 0);
	          SYNC_OUT: out STD_LOGIC
    );

end component;


type inp_data is array (127 downto 0) of std_logic_vector(11 downto 0);

Signal input : inp_data;

SIGNAL inputX1,inputX2,output1,output2: STD_LOGIC_VECTOR (2*bits-1 downto 0);
SIGNAL twiddle_addr : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL clk: STD_LOGIC;
SIGNAL SYNC_OUT: STD_LOGIC;
SIGNAL SYNC_IN : STD_LOGIC;

Begin
    
    
    module_inst : stage port map (
                               		   
                                        clk=>	clk,
                                        SYNC_OUT=>SYNC_OUT,
                                        SYNC_IN =>SYNC_IN,
                                        inputX1=>inputX1,
                                        inputX2=>inputX2,
                                        output1=>output1,
                                        output2=>output2,
										twiddle_addr=>twiddle_addr
								   );
  


Data_in: process

file Xin1: text open read_mode is "/home/nickname/fft/testing_butterfly/Xreal.txt";

file Xin2: text open read_mode is "/home/nickname/fft/testing_butterfly/Ximag.txt";



variable l :line ;
variable sample:std_logic_vector(11 downto 0);
Begin
   for i in 0 to 31 loop
        
     readline(Xin1,l);
     hread(l,sample);
     input(i*4)<=sample;
      
   
     readline(Xin2,l);
     hread(l,sample);
     input(i*4+1)<=sample;
     
     readline(Xin1,l);
     hread(l,sample);
     input(i*4+2)<=sample;
      
   
     readline(Xin2,l);
     hread(l,sample);
     input(i*4+3)<=sample;
           
     
   end loop;
   wait;
end process;



data_process: process
Begin
  wait for 200 ns;
   SYNC_IN<='0';
   inputX1<=(others=>'1');
   inputX2<=(others=>'1');
   twiddle_addr<=(others=>'1');

  
        
   wait for 30 ns;
 
       
   wait until clk='0';
    
      
   SYNC_IN<='1'; 
   
  wait for 5 ns;
   for i in 0 to 31 loop
		 inputX1 <= input(i*4)&input(i*4+1);
		 inputX2 <= input(i*4+2)&input(i*4+3);
		-- inputX1<=x"7ff000";
		 --inputX2<=x"7ff000";
      twiddle_addr<="00000";
  
      wait for 10 ns;
      SYNC_IN<='0';
   end loop;
   wait for 30 ns;
  
        
   
   wait;
  
End process;



clock_process: process
Begin
  clk<='0';
  wait for 5 ns;
  clk<='1';
  wait for 5 ns;
end process;

end;
