library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Block_Adder is
    Port ( SA : in STD_LOGIC;
           SB : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (27 downto 0);
           B : in STD_LOGIC_VECTOR (27 downto 0);
           A_S : in STD_LOGIC;
           Comp : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (27 downto 0);
           SO : out STD_LOGIC;
           CO : out STD_LOGIC);
end Block_Adder;

architecture Behavioral of Block_Adder is

    component Adder Port ( A : in STD_LOGIC_VECTOR (27 downto 0);
           B : in STD_LOGIC_VECTOR (27 downto 0);
           A_S : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (27 downto 0);
           CO : out STD_LOGIC);
    end component;
    
    component Signout Port ( SA : in STD_LOGIC;                             
               SB : in STD_LOGIC;                          
               A : in STD_LOGIC_VECTOR (27 downto 0);          
               B : in STD_LOGIC_VECTOR (27 downto 0);          
               A_S : in STD_LOGIC;                             
               Comp : in STD_LOGIC;                             
               Aa : out STD_LOGIC_VECTOR (27 downto 0);        
               Bb : out STD_LOGIC_VECTOR (27 downto 0);       
               AS : out STD_LOGIC;                           
               SO : out STD_LOGIC);
    end component;
    
    signal Aa_aux, Bb_aux, S_aux : std_logic_vector(27 downto 0);
    signal AS_aux, SO_aux, CO_aux : std_logic;

begin
    component00: Signout port map (SA => SA, SB => SB, A => A, B => B, A_S => A_S, Comp => Comp, Aa => Aa_aux, Bb => Bb_aux, AS => AS_aux, SO => SO_aux);
    component01: Adder port map (A => Aa_aux, B => Bb_aux, A_S => AS_aux, S => S_aux, CO => CO_aux);
    
    S <= (S_aux xor X"FFFFFFF") + '1' when ((AS_aux and SO_aux) = '1') else 
            S_aux;
    CO <= '0' when ((SB xor A_S) /= SA) else 
            CO_aux;
    SO <= SO_aux;

end Behavioral;
