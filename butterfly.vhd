library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity butterfly is
generic(
	bits: integer:=12;
	extra: integer:=3
	);
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
		clk		: in STD_LOGIC			
	);

end butterfly;

architecture rtl of butterfly is
	SIGNAL b1xw1_big,b2xw1_big,b1xw2_big,b2xw2_big : STD_LOGIC_VECTOR (2*bits-1 DOWNTO 0);
	
	SIGNAL a1_d,a2_d: STD_LOGIC_VECTOR (bits-1 DOWNTO 0);

	SIGNAL bw1,bw2,b1xw1_big_d,b2xw1_big_d,b1xw2_big_d,b2xw2_big_d: STD_LOGIC_VECTOR (bits+extra-1 DOWNTO 0);

	SIGNAL f1_big,f2_big,g1_big,g2_big,f1_big_round,f2_big_round,g1_big_round,g2_big_round,round1,round2: STD_LOGIC_VECTOR (bits+extra-1 DOWNTO 0);
	
begin

			round1<="000000000000100";
		    round2<="111111111111011";
			b1xw1_big <= b1*w1;
			b2xw2_big <= b2*w2;
			b1xw2_big <= b1*w2;
			b2xw1_big <= b2*w1;
			
		--next clock
        
        bw1 <=   b1xw1_big_d - b2xw2_big_d;
	    bw2 <=   b1xw2_big_d + b2xw1_big_d;  
       
        
	    f1_big <= (a1_d(bits-1) & a1_d & a1_d(bits-1) & a1_d(bits-1) ) +  bw1;
	    f2_big <= (a2_d(bits-1) & a2_d & a2_d(bits-1) & a2_d(bits-1) ) +  bw2;
			 
	    g1_big <= (a1_d(bits-1) & a1_d & a1_d(bits-1) & a1_d(bits-1) ) - bw1;
	    g2_big <= (a2_d(bits-1) & a2_d & a2_d(bits-1) & a2_d(bits-1)) - bw2;
	    
	    
	   	f1<=f1_big_round(bits+extra-1 downto 3);		
		f2<=f2_big_round(bits+extra-1 downto 3);
		g1<=g1_big_round(bits+extra-1 downto 3);
		g2<=g2_big_round(bits+extra-1 downto 3);
		    		
 
PROCESS(f1_big, f2_big, g1_big, g2_big,clk)--rounding apo f1_big se f1_big_round
BEGIN	
		if ( (not(f1_big(14))) AND --8etikos
				(not (  (f1_big(3)) AND (f1_big(13)) AND (f1_big(12)) AND (f1_big(11)) AND (f1_big(10)) AND 
						(f1_big(9 )) AND (f1_big(8 )) AND (f1_big(7 )) AND (f1_big(6 )) AND (f1_big(5 )) AND (f1_big(4)) )))='1' then
			f1_big_round<= f1_big+round1;
		else 
			if ( (f1_big(14)) AND --arnitikos
			(not((not(f1_big(3))) AND (not(f1_big(13))) AND (not(f1_big(12))) AND (not(f1_big(11))) AND (not(f1_big(10))) AND 
				 (not(f1_big(9 ))) AND (not(f1_big(8 ))) AND (not(f1_big(7 ))) AND (not(f1_big(6 ))) AND (not(f1_big(5 ))) AND (not(f1_big(4))) )))='1' then
					f1_big_round<=f1_big-round1;
			else 
				f1_big_round<=f1_big;
			end if;		
		end if;
		
 
		
		if ( (not(f2_big(14))) AND --8etikos
				(not (  (f2_big(3)) AND (f2_big(13)) AND (f2_big(12)) AND (f2_big(11)) AND (f2_big(10)) AND 
						(f2_big(9 )) AND (f2_big(8 )) AND (f2_big(7 )) AND (f2_big(6 )) AND (f2_big(5 ))AND (f2_big(4)) )))='1' then
			f2_big_round<= f2_big+round1;
		else 	
			if( (f2_big(14)) AND --arnitikos
			(not((not(f2_big(3))) AND (not(f2_big(13))) AND (not(f2_big(12))) AND (not(f2_big(11))) AND (not(f2_big(10))) AND 
				 (not(f2_big(9 ))) AND (not(f2_big(8 ))) AND (not(f2_big(7 ))) AND (not(f2_big(6 ))) AND (not(f2_big(5 )))AND (not(f2_big(4 ))) )))='1' then
					f2_big_round<=f2_big-round1;
			else 
				f2_big_round<=f2_big;
			end if;		
		end if;

		
		if ( (not(g1_big(14))) AND(not (  (g1_big(14)) AND (g1_big(13)) AND (g1_big(12)) AND (g1_big(11)) AND (g1_big(10)) AND (g1_big(9 )) AND (g1_big(8 )) AND (g1_big(7 )) AND (g1_big(6 )) AND (g1_big(5 ))AND (g1_big(4 )) )))='1' then
			g1_big_round<= g1_big+round1;
		else 	
			if ( (g1_big(14)) AND --arnitikos
			(not((not(g1_big(3))) AND (not(g1_big(13))) AND (not(g1_big(12))) AND (not(g1_big(11))) AND (not(g1_big(10))) AND 
				 (not(g1_big(9 ))) AND (not(g1_big(8 ))) AND (not(g1_big(7 ))) AND (not(g1_big(6 ))) AND (not(g1_big(5 )))AND (not(g1_big(4 ))) )))='1' then
					g1_big_round<=g1_big-round1;
			else 
				g1_big_round<=g1_big;
			end if;		
		end if;
	
		
		if ( (not(g2_big(14))) AND --8etikos
				(not (  (g2_big(3)) AND (g2_big(13)) AND (g2_big(12)) AND (g2_big(11)) AND (g2_big(10)) AND 
						(g2_big(9 )) AND (g2_big(8 )) AND (g2_big(7 )) AND (g2_big(6 )) AND (g2_big(5 ))AND (g2_big(4)) )))='1' then
			g2_big_round<= g2_big+round1;
		else 	
			if( (g2_big(14)) AND --arnitikos
			(not((not(g2_big(3))) AND (not(g2_big(13))) AND (not(g2_big(12))) AND (not(g2_big(11))) AND (not(g2_big(10))) AND 
				 (not(g2_big(9 ))) AND (not(g2_big(8 ))) AND (not(g2_big(7 ))) AND (not(g2_big(6 ))) AND (not(g2_big(5 ))) AND (not(g2_big(4 ))) )))='1' then
					g2_big_round<=g2_big-round1;
			else 
				g2_big_round<=g2_big;
			end if;		
		end if;
	
	
	if rising_edge(clk) then
	
		
		    b1xw1_big_d<=b1xw1_big(2*bits-1 downto bits-extra);
			b2xw2_big_d<=b2xw2_big(2*bits-1 downto bits-extra);
			b1xw2_big_d<=b1xw2_big(2*bits-1 downto bits-extra);
			b2xw1_big_d<=b2xw1_big(2*bits-1 downto bits-extra);
			
			a1_d<=a1;
			a2_d<=a2;
	
		
		
    end if;

end process;
	
	

end rtl;
