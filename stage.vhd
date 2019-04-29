								library ieee;
      use ieee.std_logic_1164.all;
      use ieee.numeric_std.all;
      use ieee.std_logic_arith.all;
      use ieee.std_logic_signed.all;
      
      entity stage is
			  generic(
					bits: integer:=12
					   );
               port 
	               (
		          clk : in STD_LOGIC;
		      inputX1 : in STD_LOGIC_VECTOR (2*bits-1 downto 0);
		      inputX2 : in STD_LOGIC_VECTOR (2*bits-1 downto 0);
		      output1 : out STD_LOGIC_VECTOR (2*bits-1 downto 0);
		      output2 : out STD_LOGIC_VECTOR (2*bits-1 downto 0);
		 twiddle_addr :in STD_LOGIC_VECTOR (4 downto 0)    
	              );
      end stage;
	      
	      Architecture rtl of stage is
	      
	      component butterfly is
	      port 
		      (
			      a1		: in STD_LOGIC_VECTOR (bits-1 downto 0);
			      a2		: in STD_LOGIC_VECTOR (bits-1 downto 0);
			      b1		: in STD_LOGIC_VECTOR (bits-1 downto 0);
			      b2		: in STD_LOGIC_VECTOR (bits-1 downto 0);
			      w1		: in STD_LOGIC_VECTOR (bits-1 downto 0);
			      w2		: in STD_LOGIC_VECTOR (bits-1 downto 0);
			      f1		: out STD_LOGIC_VECTOR (bits-1 downto 0);
			      f2		: out STD_LOGIC_VECTOR (bits-1 downto 0);
			      g1		: out STD_LOGIC_VECTOR (bits-1 downto 0);
			      g2		: out STD_LOGIC_VECTOR (bits-1 downto 0);
			      clk	: in STD_LOGIC		
		      );
	      
	      end component;
	      
	        component twid_rom is
	      port (
				addr		: IN std_logic_VECTOR(4 downto 0);
				clk			: IN std_logic;
				dout		: OUT std_logic_VECTOR(2*bits-1 downto 0)
			);	      
	      end component;
	      
	      
      SIGNAL	a1:  STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL	a2:  STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL	b1:  STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL	b2:  STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL   w1:  STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL   w2:  STD_LOGIC_VECTOR (bits-1 downto 0);
      
      SIGNAL f1: STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL f2: STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL g1: STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL g2: STD_LOGIC_VECTOR (bits-1 downto 0);
      SIGNAL W: STD_LOGIC_VECTOR (2*bits-1 downto 0);
      
      Begin
          
          
          twid_rom_inst :twid_rom port map (
                                           clk=>clk,
                                           addr=>twiddle_addr,
                                           dout=>W 
                                           );
          
          
      
          butter_inst : butterfly port map (
                               		          a1=>a1,
                               		          a2=>a2,
                                              b1=>b1,
                                              b2=>b2,
                                              w1=>w1,
                                              w2=>w2,
                                              f1=>f1,
                                              f2=>f2,
                                              g1=>g1,
                                              g2=>g2,
                                              clk=>clk
								          );
								          
          
         
       a1<=inputX1(2*bits-1 downto bits);
       a2<=inputX1(bits-1 downto 0);
       b1<=inputX2(2*bits-1 downto bits);
       b2<=inputX2(bits-1 downto 0);
       output1(2*bits-1 downto bits)<=f1;
       output1(bits-1 downto 0)<=f2;
       output2(2*bits-1 downto bits)<=g1;
       output2(bits-1 downto 0)<=g2;
       w1<=W(2*bits-1 downto bits);
       w2<=W(bits-1 downto 0);
                 
      end rtl;