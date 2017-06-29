----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 08:33:33 PM
-- Design Name: 
-- Module Name: selector - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity selector is
    Port ( NumberA : in STD_LOGIC_VECTOR (31 downto 0);
           NumberB : in STD_LOGIC_VECTOR (31 downto 0);
           enable : in STD_LOGIC;
           NA : out STD_LOGIC_VECTOR (36 downto 0);
           NB : out STD_LOGIC_VECTOR (36 downto 0);
           sel : out STD_LOGIC_VECTOR(1 downto 0));
end selector;



architecture Behavioral of selector is

signal SA,SB : STD_LOGIC;
signal EA,EB : STD_LOGIC_VECTOR(7 downto 0);
signal MA,MB : STD_LOGIC_VECTOR(22 downto 0);

begin

SA <= NumberA(31);
SB <= NumberB(31);
EA <= NumberA(30 downto 23);
EB <= NumberB(30 downto 23);
MA <= NumberA(22 downto 0);
MB <= NumberB(22 downto 0);

    process(SA,SB,EA,EB,MA,MB,enable)    
    begin
    if enable = '1' then
       --Exponent and sign for A and B
        NA(36) <= SA;
        NA(35 downto 28) <= EA;
        NB(36) <= SB;
        NB(35 downto 28) <= EB;
        
        --Mantissa A
        if EA > X"00" then  -- normal number
            NA(27) <= '1' ; --implicit bit = 1
            NA(26 downto 4) <= MA; --Mantissa
            NA(3 downto 0) <= X"0"; --Guard bits
            
        elsif EA = X"00" then  -- subnormal number
            NA(27) <= '0' ; --implicit bit = 0
            NA(26 downto 4) <= MA; --Mantissa
            NA(3 downto 0) <= X"0"; --Guard bits
        else 
            NA <= "-------------------------------------";
        end if;
        
            --Mantissa B
        if EB > X"00" then  -- normal number
            NB(27) <= '1' ; --implicit bit = 1
            NB(26 downto 4) <= MB; --Mantissa
            NB(3 downto 0) <= X"0"; --Guard bits
            
        elsif EB = X"00" then  -- subnormal number
            NB(27) <= '0' ; --implicit bit = 0
            NB(26 downto 4) <= MB; --Mantissa
            NB(3 downto 0) <= X"0"; --Guard bits
        else 
            NB <= "-------------------------------------";
        end if;
    else  -- It is a special case, which will be resolved by another component
        NA <= "-------------------------------------";
        NB <= "-------------------------------------";
    end if;
    end process;
    
    sel <= "00" when EA = X"00" and EB = X"00" and enable = '1' else   --subnormals
           "01" when EA > X"00" and EB > X"00" and enable = '1' else   --normals
           "10" when (EA = X"00" or EB = X"00") and enable = '1' else  --combination
           "--";
     
end Behavioral;
