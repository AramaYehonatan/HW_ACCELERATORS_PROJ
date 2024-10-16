LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
--------------------------------------------------------------
entity top is
	generic (
		n : positive := 8 ;
		m : positive := 7 ;
		k : positive := 3
	); -- where k=log2(m+1)
	port(
		rst,ena,clk : in std_logic;
		x : in std_logic_vector(n-1 downto 0);
		DetectionCode : in integer range 0 to 3;
		detector : out std_logic
		
	);
end top;
------------- complete the top Architecture code --------------
architecture arc_sys of top is
	COMPONENT Adder IS
  	GENERIC (length : INTEGER);
  	PORT ( a, b: IN STD_LOGIC_VECTOR (length-1 DOWNTO 0);
          cin: IN STD_LOGIC;
            s: OUT STD_LOGIC_VECTOR (length-1 DOWNTO 0);
         cout: OUT STD_LOGIC);
	END COMPONENT;
	signal Xj1 : std_logic_vector (n-1 downto 0);
	signal Xj2 : std_logic_vector (n-1 downto 0);
	signal negXj2 : std_logic_vector (n-1 downto 0);
	signal carryFromAdder : std_logic;
	signal valid : std_logic;
	signal diff : std_logic_vector (n-1 downto 0);
	signal DetectionCodeVector : std_logic_vector (n-1 downto 0);
begin
	process (clk)
	begin
		if (rst = '1') then
			Xj1 <= (others => '0');
			Xj2 <= (others => '0');
		elsif (ena = '0') then 
			Xj1 <= Xj1;
			Xj2 <= Xj2;
		elsif (clk 'event and clk='1') then
			Xj2 <= Xj1;
			Xj1 <= x;
		end if;
	end process;
	negXj2 <= NOT Xj2;
	adderInst : Adder generic map (n) port map (Xj1 , negXj2 , '1' , diff , carryFromAdder);
	DetectionCodeVector(n-1 downto 4) <= (others => '0');
    with DetectionCode select
		DetectionCodeVector(3 downto 0) <=
        "0001" when 0,
		"0010" when 1,
		"0011" when 2,
		"0100" when 3,
		"0000" when others; -- Default case
    valid <= '1' when (DetectionCodeVector = diff) and (carryFromAdder = '1') else '0';
	process (clk)
		variable streak : integer range 0 to m := 0;
	begin
		if (rst = '1') then
			detector <= '0';
			streak := 0;
		elsif (ena = '0') then
			streak := streak; 
			if ((valid = '1') and streak = m) then
				detector <= '1';
			else
				detector <= '0';
			end if;
		elsif (clk 'event and clk='1') then
			if ((valid = '1') and streak = m) then
				detector <= '1';
			elsif ((valid = '1') and streak = m-1) then
				detector <= '1';
				streak := streak+1;
			elsif ((valid = '1') and streak < m-1) then
				detector <= '0';
				streak := streak+1;
			else
				detector <= '0'; 
				streak := 0;
			end if;
		end if;
	end process;
end arc_sys;







