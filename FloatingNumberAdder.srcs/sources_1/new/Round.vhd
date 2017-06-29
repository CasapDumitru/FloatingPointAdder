library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Round is
    Port ( Min : in STD_LOGIC_VECTOR (26 downto 0);
           Mout : out STD_LOGIC_VECTOR (22 downto 0));
end Round;

architecture Behavioral of Round is

signal M_aux : std_logic_vector(22 downto 0);

begin
    process(Min)
        begin
            if Min(3 downto 0) = "----" then
                M_aux <= "-----------------------";
            elsif Min(3 downto 0) >= "1000" then
                M_aux <= Min(26 downto 4) + '1';
            else 
                M_aux <= Min(26 downto 4);
            end if;
    end process;
    
    Mout <= M_aux;

end Behavioral;
