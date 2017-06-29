----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 06:07:32 PM
-- Design Name: 
-- Module Name: comp_exp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comp_exp is
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           EMax : out STD_LOGIC_VECTOR (7 downto 0);
           MMax : out STD_LOGIC_VECTOR (27 downto 0);
           MShft : out STD_LOGIC_VECTOR (27 downto 0);
           DExp : out STD_LOGIC_VECTOR (4 downto 0);
           Comp : out STD_LOGIC);
end comp_exp;

architecture Behavioral of comp_exp is

signal EA, EB : STD_LOGIC_VECTOR(7 downto 0);
signal MA,MB : STD_LOGIC_VECTOR(27 downto 0);

signal C : STD_LOGIC;
signal dif : STD_LOGIC_VECTOR(7 downto 0);


begin

--Sign A & B
SA <= NumberA(36);
SB <= NumberB(36);

--Exponent A & B
EA <= NumberA(35 downto 28);
EB <= NumberB(35 downto 28);

--Mantissa A & B
MA <= NumberA(27 downto 0);
MB <= NumberB(27 downto 0);

--Exponent Comparison
C <= '1' when (EA > EB) or (MB(0) = '1') else   -- Exponent A > Exponent B
     '0' when EA < EB else  -- Exponent B > Exponent A
     '1' when MA >= MB else -- EA == EB --> A > B
     '0' when MA < MB else  -- EA = EB --> B > A
     '-';
     
Comp <= C;

-- Largest exponent
Emax <= EA when C = '1' else 
        EB when C = '0' else
        "--------";
       
-- Difference between exponents
dif <= EA - EB when (C = '1') and (MB(0) = '0') else
       EB - EA when (C = '0') else
       EA + EB when (C = '1') and (MB(0) = '1') else 
       "--------";

--If diffrence <= 27 => use substraction
-- else => 28
process(dif)
    begin
        if dif <= X"1B" then 
            Dexp <= dif(4 downto 0);
        elsif dif> X"1B" then
            Dexp <= "11100";
        else 
            Dexp <= "-----";
        end if;
    end process;

--Mantissa    
Mshft <= MB when C = '1' else
         MA when C = '0' else
         "----------------------------";
         
Mmax <=  MA when C = '1' else
         MB when C = '0' else
         "----------------------------";

end Behavioral;
