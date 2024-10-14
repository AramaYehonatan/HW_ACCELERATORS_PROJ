LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY HEXdecode IS
  PORT 
  (  
	  Xin: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      Xout: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
  );
END HEXdecode;
-----------------------------------------
ARCHITECTURE HEXdecode OF HEXdecode IS
BEGIN
--    with Xin select
--        Xout <= "0111111" when "0000" ,
--                "0000110" when "0001" ,
--                "1011011" when "0010" ,
--               "1001111" when "0011" , 
--                "1100110" when "0100" ,
--                "1101101" when "0101" ,
--                "1111101" when "0110" ,
--                "0000111" when "0111" ,
--                "1111111" when "1000" ,
--                "1100111" when "1001" ,
--                "0000000" when others;


    with Xin select
    Xout <= "1000000" when "0000" ,
            "1111001" when "0001" ,
            "0100100" when "0010" ,
            "0110000" when "0011" , 
            "0011001" when "0100" ,
            "0010010" when "0101" ,
            "0000010" when "0110" ,
            "1111000" when "0111" ,
            "0000000" when "1000" ,
            "0011000" when "1001" ,
            "0001000" when "1010" ,
            "0000011" when "1011" ,
            "1000110" when "1100" ,
            "0100001" when "1101" ,
            "0000110" when "1110" ,
            "0001110" when "1111" ,
            "1110111" when others;
END HEXdecode;