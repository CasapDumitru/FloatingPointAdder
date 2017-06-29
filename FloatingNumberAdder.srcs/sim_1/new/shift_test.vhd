----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 04:28:02 PM
-- Design Name: 
-- Module Name: shift_test - Behavioral
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

entity shift_test is
--  Port ( );
end shift_test;

architecture Behavioral of shift_test is

signal T : STD_LOGIC_VECTOR(27 downto 0) :=  "0000000011111111111111111111";
signal T1 : STD_LOGIC_VECTOR(27 downto 0) := "0000000011111111111111111111";
signal Shft : STD_LOGIC_VECTOR(4 downto 0) := "01000";
signal S_Left : STD_LOGIC_VECTOR(27 downto 0) := "0000000000000000000000000000";
signal S_Right : STD_LOGIC_VECTOR(27 downto 0) := "0000000000000000000000000000";
begin

test_left : entity Work.shift_left
    port map (
        T => T,
        Shft => Shft,
        S => S_Left );
        
test_right : entity Work.shift_right
    port map (
        T => T1,
        Shft => Shft,
        S => S_Right);
        
end Behavioral;
