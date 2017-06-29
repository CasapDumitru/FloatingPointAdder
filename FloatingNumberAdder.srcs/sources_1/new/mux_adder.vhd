----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 09:17:49 PM
-- Design Name: 
-- Module Name: mux_adder - Behavioral
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

entity mux_adder is
Port (     SA_nor : in STD_LOGIC;
           SB_nor : in STD_LOGIC;
           Comp_nor : in STD_LOGIC;
           Exp_nor : in STD_LOGIC_VECTOR(7 downto 0);
           MA_nor : in STD_LOGIC_VECTOR(27 downto 0);
           MB_nor : in STD_LOGIC_VECTOR(27 downto 0);
           SA_sub : in STD_LOGIC;
           SB_sub : in STD_LOGIC;
           Comp_sub : in STD_LOGIC;
           Exp_sub : in STD_LOGIC_VECTOR(7 downto 0);
           MA_sub : in STD_LOGIC_VECTOR(27 downto 0);
           MB_sub : in STD_LOGIC_VECTOR(27 downto 0);
           sel : STD_LOGIC_VECTOR(1 downto 0);
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           C : out STD_LOGIC;
           E : out STD_LOGIC_VECTOR(7 downto 0);
           MA : out STD_LOGIC_VECTOR(27 downto 0);
           MB : out STD_LOGIC_VECTOR(27 downto 0));
end mux_adder;

architecture Behavioral of mux_adder is

begin

--sign A
SA <= SA_nor when sel = "01" or sel = "10" else
      SA_sub when sel = "00" else
      '-';
--sign B     
SB <= SB_nor when sel = "01" or sel = "10" else
      SB_sub when sel = "00" else
      '-';
--Mantissa A
MA <= MA_nor when sel = "01" or sel = "10" else
      MA_sub when sel = "00" else
      "----------------------------"; 
--Mantissa B
MB <= MB_nor when sel = "01" or sel = "10" else
      MB_sub when sel = "00" else
      "----------------------------";   
--Exponent      
E <=  Exp_nor when sel = "01" or sel = "10" else
      Exp_sub when sel = "00" else
      "--------";
--Compare A/B      
C <=  Comp_nor when sel = "01" or sel = "10" else
      Comp_sub when sel = "00" else
      '-';

end Behavioral;
