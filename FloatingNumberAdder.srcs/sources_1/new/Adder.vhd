library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder is
    Port ( A : in STD_LOGIC_VECTOR (27 downto 0);
           B : in STD_LOGIC_VECTOR (27 downto 0);
           A_S : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (27 downto 0);
           CO : out STD_LOGIC);
end Adder;

architecture Behavioral of Adder is
    component CLA port (
            A, B, Cin : std_logic; 
            S, Cout : out std_logic );
    end component;
    
    signal B1, aux, S_aux: std_logic_vector(27 downto 0);
begin
    
    Compon: for i in 0 to 27 generate
        B1(i) <= B(i) xor A_S;
        sum_0: if (i=0) generate
                    sum_0comp: CLA port map (A => A(i), B => B1(i), Cin => A_S, S => S_aux(i), Cout => aux(i));
                end generate;
        sum_i: if ((i > 0) and (i < 28)) generate
                    sum_icomp: CLA port map (A => A(i), B => B1(i), Cin => aux(i-1), S => S_aux(i), Cout => aux(i));
                end generate;
    end generate;
    
    S <= S_aux;
    CO <= aux(27);

end Behavioral;
