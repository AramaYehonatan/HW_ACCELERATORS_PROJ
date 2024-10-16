LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;

entity tb_top is
    generic(n:INTEGER := 8;
            k: INTEGER := 3;
	    m: INTEGER :=4);
end tb_top;


architecture dataflow of tb_top is


	component top IS
  	GENERIC (n : INTEGER;
		   k : integer;  
		   m : integer	);  
	PORT 
  	(       rst , clk , enb: IN STD_LOGIC;
		  Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC;
		  PWMout: OUT STD_LOGIC
  	); -- Zflag,Cflag,Nflag,Vflag
	END component;

    signal rst, clk, enb : std_logic := '0';
    signal Y_i,X_i : std_logic_vector(n-1 downto 0) := (others => '0');
    signal ALUFN_i : std_logic_vector(4 downto 0) := (others => '0');
    signal PWMout, Nflag_o,Cflag_o,Zflag_o,Vflag_o : std_logic := '0';
    signal ALUout_o : std_logic_vector(n-1 downto 0) := (others => '0');

    begin

        top_inst : top generic map(n=>n , k=>k , m=>m) port map (rst, clk, enb,Y_i,X_i,ALUFN_i , ALUout_o , Nflag_o , Cflag_o,Zflag_o,Vflag_o , PWMout );

        gen_clk : process	
        begin
            clk <= '0';
            wait for 50 ns;
            clk <= not clk;
            wait for 50 ns;
        end process;
        
        top_stim : process
        begin
	    Y_i <= "00001000";
 	    X_i <= "00000100";
            ALUFN_i <= "01000";
            enb <= '1';
                wait until rising_edge(clk);
                wait until falling_edge(clk);
                wait until rising_edge(clk);
                wait until falling_edge(clk);
                ALUFN_i <= "00000";
		for i in 0 to 10 loop
            		wait until rising_edge(clk);
                	wait until falling_edge(clk);
        	end loop;
                ALUFN_i <= "00001";
		for i in 0 to 10 loop
            		wait until rising_edge(clk);
                	wait until falling_edge(clk);
        	end loop;
            enb <= '0';
		for i in 0 to 10 loop
            		wait until rising_edge(clk);
                	wait until falling_edge(clk);
        	end loop;
        end process;

    end dataflow;