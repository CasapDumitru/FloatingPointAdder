library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Special_cases is
    Port ( numberA : in STD_LOGIC_VECTOR (31 downto 0);    
           numberB : in STD_LOGIC_VECTOR (31 downto 0);
           sign : in STD_LOGIC;
           resultS : out STD_LOGIC_VECTOR (31 downto 0);
           enable : out STD_LOGIC);                         --enable Pre-Adder Component
end Special_cases;

architecture Behavioral of Special_cases is
    signal expA : STD_LOGIC_VECTOR (7 downto 0);
    signal expB : STD_LOGIC_VECTOR (7 downto 0);
    signal expS : STD_LOGIC_VECTOR (7 downto 0);
    signal mantA : STD_LOGIC_VECTOR (22 downto 0);
    signal mantB : STD_LOGIC_VECTOR (22 downto 0);
    signal mantS : STD_LOGIC_VECTOR (22 downto 0);
    signal SA : STD_LOGIC;
    signal SB : STD_LOGIC;
    signal SS : STD_LOGIC;
    signal outA : STD_LOGIC_VECTOR (2 downto 0);
    signal outB : STD_LOGIC_VECTOR (2 downto 0);
    signal zeroResult : STD_LOGIC := '0';
begin
    SA <= numberA(31);
    SB <= numberB(31);
    expA <= numberA(30 downto 23);
    expB <= numberB(30 downto 23);
    mantA <= numberA(22 downto 0);
    mantB <= numberB(22 downto 0);
    
    outA <= "000" when expA = X"00" and mantA = 0 else                      -- ZERO 
            "001" when expA = X"00" and mantA > 0 else                      -- Subnormal
            "011" when (expA > X"00" and expA < X"FF") and mantA >= 0 else   -- Normal
            "100" when expA = X"FF" and mantA = 0 else                      -- Infinity
            "110" when expA = X"FF" and mantA > 0 else                      -- NaN
            "000";
            
    outB <= "000" when expB = X"00" and mantB = 0 else                      -- ZERO 
            "001" when expB = X"00" and mantB > 0 else                      -- Subnormal
            "011" when (expB > X"00" and expB < X"FF") and mantB >= 0 else   -- Normal
            "100" when expB = X"FF" and mantB = 0 else                      -- Infinity
            "110" when expB = X"FF" and mantB > 0 else                      -- NaN
            "000";
            
    process(SA, SB, outA, outB,sign,expB,expA,mantA,mantB)
        begin
        --ZERO case
        if (outA = "000") then                  -- Zero +/- NumberB
            SS <= SB xor sign;
            expS <= expB;
            mantS <= mantB;
        elsif (outB = "000") then               -- NumberA +/- Zero
            SS <= SA xor sign;
            expS <= expA;
            mantS <= mantA;
        end if;
        
        --Infinite and Normal or Subnormal case
        if (outA(0) = '1' and outB = "100" ) then       -- Normal or Subnormal +/- Infinity
            SS <= SB xor sign;
            expS <= expB;
            mantS <= mantB;
        elsif (outB(0) = '1' and outA = "100") then     -- Infinity +/- Normal o Subnormal
            SS <= SA xor sign;
            expS <= expA;
            mantS <= mantA;
        end if;
        --Infinity for each number case
        if ((outA and outB) = "100" and SA = SB) then
            if (sign = '0') then 
                SS <= SA;
                expS <= expA;
                mantS <= mantA;
            else 
                SS <= '1';
                expS <= X"FF";
                mantS <= "00000000000000000000001";
            end if;
        elsif ((outA and outB) = "100" and SA /= SB) then
            if (SA = '0') then 
                if (sign = '1') then                -- +Inf - (-Inf)   => +Inf
                    SS <= SA;
                    expS <= expA;
                    mantS <= mantA;
                else                                -- +Inf + (-Inf)   => NaN
                    SS <= '1';
                    expS <= X"FF";
                    mantS <= "00000000000000000000001";
                end if;
            else 
                if (sign = '0') then                -- -Inf + (+Inf)   => NaN
                    SS <= '1';
                    expS <= X"FF";
                    mantS <= "00000000000000000000001";
                else                                --  -Inf - (+Inf)   => -Inf
                    SS <= SA;
                    expS <= expA;
                    mantS <= mantA;
                end if;
            end if;
        end if;
        
        --NaN case
        if (outA = "110" or outB = "110") then
            SS <= '1';
            expS <= X"FF";
            mantS <= "00000000000000000000001";
        end if;
        
        --Normal/Subnormal
        if ((outA(0) and outB(0)) = '1') then
            SS <= '-';
            expS <= "--------";
            mantS <= "-----------------------";
        end if;
        
        --result is zero
        if( ( NumberA(30 downto 0) = NumberB(30 downto 0) ) and (  (sign = '1' and ( (SA xor SB) = '0')) or (sign = '0' and ((SA xor SB) = '1') )) ) then
            SS<='0';
            expS <= x"00";
            mantS <= (others => '0');     
            zeroResult <= '1';       
        end if;
    end process;
    
    enable <= '1' when ((outA(0) and outB(0)) = '1' and zeroResult = '0') else '0';
    resultS(31) <= SS;
    resultS(30 downto 23) <= expS;
    resultS(22 downto 0) <= mantS;
    
end Behavioral;
