----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2017 11:13:02 PM
-- Design Name: 
-- Module Name: preadder_test - Behavioral
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

entity preadder_test is
--  Port ( );
end preadder_test;

architecture Behavioral of preadder_test is


component preadder is
    Port ( NumberA : in STD_LOGIC_VECTOR (31 downto 0);
           NumberB : in STD_LOGIC_VECTOR (31 downto 0);
           enable : in STD_LOGIC;
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           C : out STD_LOGIC;
           E : out STD_LOGIC_VECTOR (7 downto 0);
           MA : out STD_LOGIC_VECTOR (27 downto 0);
           MB : out STD_LOGIC_VECTOR (27 downto 0));
end component;


signal NumberA : STD_LOGIC_VECTOR(31 downto 0) := x"e0400000";
signal NumberB : STD_LOGIC_VECTOR(31 downto 0) := x"e0c00000";
signal enable : STD_LOGIC := '1';

signal SA,SB,C : STD_LOGIC;
signal E : STD_LOGIC_VECTOR(7 downto 0);
signal MA,MB : STD_LOGIC_VECTOR(27 downto 0);


begin


test_preadder : preadder 
    port map ( NumberA => NumberA, NumberB => NumberB, enable => enable,
               SA => SA, SB => SB, C => C, MA => MA, MB => MB,E => E);
               


end Behavioral;
