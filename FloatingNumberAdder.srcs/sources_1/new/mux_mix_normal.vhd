----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 09:04:58 PM
-- Design Name: 
-- Module Name: mux_mix_normal - Behavioral
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

entity mux_mix_normal is
Port (     A_nor : in STD_LOGIC_VECTOR (36 downto 0);
           B_nor : in STD_LOGIC_VECTOR (36 downto 0);
           A_mix : in STD_LOGIC_VECTOR (36 downto 0);
           B_mix : in STD_LOGIC_VECTOR (36 downto 0);
           sel :   in STD_LOGIC_VECTOR(1 downto 0);
           NA :    out STD_LOGIC_VECTOR (36 downto 0);
           NB :    out STD_LOGIC_VECTOR (36 downto 0));
end mux_mix_normal;

architecture Behavioral of mux_mix_normal is

begin
    NA <= A_nor when sel = "01" else  -- Normal numbers
          A_mix when sel = "10" else  -- Mixed numbers
          "-------------------------------------";
    
    NB <= B_nor when sel = "01" else  -- Normal numbers
          B_mix when sel = "10" else  -- Mixed numbers
          "-------------------------------------"; 

end Behavioral;
