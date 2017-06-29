library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Signout is
    Port ( SA : in STD_LOGIC;                               -- Sign A
           SB : in STD_LOGIC;                               -- Sign B
           A : in STD_LOGIC_VECTOR (27 downto 0);           -- Number A
           B : in STD_LOGIC_VECTOR (27 downto 0);           -- Number B
           A_S : in STD_LOGIC;                              -- Add or Sub (0) (1)
           Comp : in STD_LOGIC;                             -- determine the higher number
           Aa : out STD_LOGIC_VECTOR (27 downto 0);         -- Number A'
           Bb : out STD_LOGIC_VECTOR (27 downto 0);         -- Number B'
           AS : out STD_LOGIC;                              -- A_S'
           SO : out STD_LOGIC);                             -- Determine output's sign
end Signout;

architecture Behavioral of Signout is

signal SB_aux : std_logic := '0';
signal Aaux, Baux : std_logic_vector (27 downto 0) := (others => '0');

begin
    SB_aux <= SB xor A_S;                               -- B's sign 
    SO <= SA when Comp = '1' else                       -- A > B  => Sign A
          SB_aux when Comp = '0' else                   -- B > A  => Sign B 
          '-';
    
    Aaux <= A when Comp = '1' else 
            B when Comp = '0' else 
            "----------------------------";
    Baux <= B when Comp = '1' else 
            A when Comp = '0' else
            "----------------------------";
            
    process(SA, SB_aux, A, B,Aaux,BAux)
    begin
        if (SA xor SB_aux) = '0' then                   -- if Sign A equals to Sign B
            Aa <= Aaux;
            Bb <= Baux;
            
        elsif (SA = '1'  and SB_aux = '0') then         -- if Sign A is negative and Sign B is positive
            Aa <= Baux;
            Bb <= Aaux;
            
        elsif (SA = '0' and SB_aux = '1') then          -- if Sign A is positive and Sign B is negative
            Aa <= Aaux;
            Bb <= Baux;
        
        else 
            Aa <= "----------------------------";
            Bb <= "----------------------------";
        end if;
    end process;
    
    AS <= '1' when SA /= SB_aux else                    -- when Signs are different, we substract (1) else add (0)
          '0';

end Behavioral;
