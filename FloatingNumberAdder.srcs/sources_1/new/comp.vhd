----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 12:18:29 PM
-- Design Name: 
-- Module Name: comp - Behavioral
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

entity comp is
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           Normal : out STD_LOGIC_VECTOR (36 downto 0);
           Subnormal : out STD_LOGIC_VECTOR (36 downto 0));
end comp;

architecture Behavioral of comp is

signal EA : STD_LOGIC_VECTOR(7 downto 0);
signal EB : STD_LOGIC_VECTOR(7 downto 0);

begin

process(NumberA, NumberB, EA, EB)
begin

EA <= NumberA(35 downto 28);
EB <= NumberB(35 downto 28);
--A is subnormal and B is Normal
if EA = X"00" then
    Subnormal <= NumberA;
    Normal <= NumberB;
--B is subnormal and A is Normal
elsif EB = X"00" then
    Subnormal <= NumberB;
    Normal <= NumberA;
else 
    Subnormal <= "-------------------------------------";
    Normal <=    "-------------------------------------";
end if;

end process; 

end Behavioral;
