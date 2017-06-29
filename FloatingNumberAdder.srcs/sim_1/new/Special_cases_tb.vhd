----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2017 11:08:49 PM
-- Design Name: 
-- Module Name: Special_cases_tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Special_cases_tb is
--  Port ( );
end Special_cases_tb;

architecture Behavioral of Special_cases_tb is
    signal numberA, numberB: std_logic_vector (31 downto 0) := (others => '0');
    signal sign : std_logic := '0';
    signal resultS : std_logic_vector(31 downto 0);
    signal enable : std_logic;
    
    component Special_cases is
        Port ( numberA : in STD_LOGIC_VECTOR (31 downto 0);    
               numberB : in STD_LOGIC_VECTOR (31 downto 0);
               sign : in STD_LOGIC;
               resultS : out STD_LOGIC_VECTOR (31 downto 0);
               enable : out STD_LOGIC);                         --enable Pre-Adder Component
    end component;
    
begin
p1: Special_cases port map (numberA, numberB, sign, resultS, enable);
tb: process
begin
        numberA <= x"40200000";
        numberB <= x"40600000";
        sign <= '0';
        wait for 5ns;
        
        if (resultS = "--------------------------------" and enable = '1') then
            report ("CORECT doua numere pozitive adunate");
        else 
            report ("GRESIT doua numere pozitive adunate");
        end if;
        
        numberA <= x"7fffffff";
        numberB <= x"40200000";
        sign <= '0';
        wait for 5ns;
        
        if (resultS = x"ff800001" and enable = '0') then
            report ("CORECT add numA = NaN and numB = X and sign = 0");
        else
            report ("GRESIT add numA = NaN and numB = X and sign = 0");
        end if;
        
        numberA <= x"40200000";
        numberB <= x"7fffffff";
        sign <= '1';
        wait for 5ns;
        
        if (resultS = x"ff800001" and enable = '0') then
            report ("CORECT sub numA = X and numB = NaN and sign = 1");
        else
            report ("GRESIT sub numA = X and numB = NaN and sign = 1");
        end if;
        
        numberA <= x"00000000";
        numberB <= x"40200000";
        sign <= '0';
        wait for 5ns;
        
        if (resultS = x"40200000" and enable = '0') then
            report ("CORECT add numA = ZERO and numB = 2.5 and sign = 0");
        else
            report ("GRESIT add numA = ZERO and numB = 2.5 and sign = 0");
        end if;
                
        numberA <= x"00000000";
        numberB <= x"40200000";
        sign <= '1';
        wait for 5ns;
        
        if (resultS = x"c0200000" and enable = '0') then
            report ("CORECT sub numA = ZERO and numB = 2.5 and sign = 1");
        else
            report ("GRESIT sub numA = ZERO and numB = 2.5 and sign = 1");
        end if;
        
        numberA <= x"40200000";
        numberB <= x"00000000";
        sign <= '1';
        wait for 5ns;
        
        if (resultS = x"40200000" and enable = '0') then
            report ("CORECT sub numA = 2.5 and numB = ZERO and sign = 1");
        else
            report ("GRESIT sub numA = 2.5 and numB = ZERO and sign = 1");
        end if;
        
        wait for 20ns;
        
        wait;
end process tb;

end Behavioral;