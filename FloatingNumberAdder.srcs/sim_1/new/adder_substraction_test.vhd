----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2017 10:55:04 PM
-- Design Name: 
-- Module Name: adder_substraction_test - Behavioral
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

entity adder_substraction_test is
--  Port ( );
end adder_substraction_test;

architecture Behavioral of adder_substraction_test is

component adder_substraction
    Port ( NumberA : in STD_LOGIC_VECTOR (31 downto 0);
           NumberB : in STD_LOGIC_VECTOR (31 downto 0);
           Operation : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal NumberA : STD_LOGIC_VECTOR(31 downto 0) := x"c1266666";
signal NumberB : STD_LOGIC_VECTOR(31 downto 0) := x"c1a33333";
signal Operation : STD_LOGIC := '1';

signal Result : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');



begin

test : adder_substraction
    port map( NumberA => NumberA, NumberB => NumberB, Operation => Operation, Result => Result);
    
    


end Behavioral;
