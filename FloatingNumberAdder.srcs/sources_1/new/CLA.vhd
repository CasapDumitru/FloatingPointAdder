library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CLA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           S : out STD_LOGIC;
           Cout : out STD_LOGIC);
end CLA;

architecture Behavioral of CLA is
signal c_p, c_g : std_logic;

begin
    c_g <= A and B;                         -- carry generation
    c_p <= A xor B;                         -- carry propagation
    
    Cout <= c_g or (c_p and Cin);
    S <= c_p xor Cin;

end Behavioral;
