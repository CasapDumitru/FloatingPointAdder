----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 12:26:10 PM
-- Design Name: 
-- Module Name: zero_counter - Behavioral
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

entity zero_counter is
    Port ( M : in STD_LOGIC_VECTOR (27 downto 0);
           Zcount : out STD_LOGIC_VECTOR (4 downto 0));
end zero_counter;

architecture Behavioral of zero_counter is

signal Zero_vector : STD_LOGIC_VECTOR(27 downto 0) := "0000000000000000000000000000";

begin

Zcount <= "-----" when M(27 downto 27) = "-" else
           "11100" when M(27 downto 0) = Zero_vector(27 downto 0) else 
           "11011" when M(27 downto 1) = Zero_vector(27 downto 1) else 
           "11010" when M(27 downto 2) = Zero_vector(27 downto 2) else 
           "11001" when M(27 downto 3) = Zero_vector(27 downto 3) else 
           "11000" when M(27 downto 4) = Zero_vector(27 downto 4) else 
           "10111" when M(27 downto 5) = Zero_vector(27 downto 5) else 
           "10110" when M(27 downto 6) = Zero_vector(27 downto 6) else 
           "10101" when M(27 downto 7) = Zero_vector(27 downto 7) else 
           "10100" when M(27 downto 8) = Zero_vector(27 downto 8) else 
           "10011" when M(27 downto 9) = Zero_vector(27 downto 9) else 
           "10010" when M(27 downto 10) = Zero_vector(27 downto 10) else 
           "10001" when M(27 downto 11) = Zero_vector(27 downto 11) else 
           "10000" when M(27 downto 12) = Zero_vector(27 downto 12) else 
           "01111" when M(27 downto 13) = Zero_vector(27 downto 13) else 
           "01110" when M(27 downto 14) = Zero_vector(27 downto 14) else 
           "01101" when M(27 downto 15) = Zero_vector(27 downto 15) else 
           "01100" when M(27 downto 16) = Zero_vector(27 downto 16) else 
           "01011" when M(27 downto 17) = Zero_vector(27 downto 17) else 
           "01010" when M(27 downto 18) = Zero_vector(27 downto 18) else 
           "01001" when M(27 downto 19) = Zero_vector(27 downto 19) else 
           "01000" when M(27 downto 20) = Zero_vector(27 downto 20) else 
           "00111"when M(27 downto 21) = Zero_vector(27 downto 21) else 
           "00110" when M(27 downto 22) = Zero_vector(27 downto 22) else 
           "00101" when M(27 downto 23) = Zero_vector(27 downto 23) else 
           "00100" when M(27 downto 24) = Zero_vector(27 downto 24) else 
           "00011" when M(27 downto 25) = Zero_vector(27 downto 25) else 
           "00010" when M(27 downto 26) = Zero_vector(27 downto 26) else 
           "00001" when M(27 downto 27) = Zero_vector(27 downto 27) else 
           "00000";

end Behavioral;
