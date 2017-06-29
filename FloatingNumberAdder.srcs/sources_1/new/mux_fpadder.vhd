----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2017 01:36:27 PM
-- Design Name: 
-- Module Name: mux_fpadder - Behavioral
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

entity mux_fpadder is
    Port ( N1 : in STD_LOGIC_VECTOR (31 downto 0);
           N2 : in STD_LOGIC_VECTOR (31 downto 0);
           enable : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end mux_fpadder;

architecture Behavioral of mux_fpadder is

begin
    
    Result <= N1 when enable = '0' else 
              N2 when enable = '1' else 
              "--------------------------------";

end Behavioral;
