----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2017 01:04:43 PM
-- Design Name: 
-- Module Name: Vector - Behavioral
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

entity Vector is
    Port ( S : in STD_LOGIC;
           E : in STD_LOGIC_VECTOR (7 downto 0);
           M : in STD_LOGIC_VECTOR (22 downto 0);
           N : out STD_LOGIC_VECTOR (31 downto 0));
end Vector;

architecture Behavioral of Vector is

begin
    
    N(31) <= S;
    N(30 downto 23) <= E;
    N(22 downto 0) <= M;

end Behavioral;
