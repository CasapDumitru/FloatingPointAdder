----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2017 10:06:00 PM
-- Design Name: 
-- Module Name: subnormals - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity subnormals is
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           CompAB : out STD_LOGIC;
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           Exp : out STD_LOGIC_VECTOR (7 downto 0);
           MA : out STD_LOGIC_VECTOR (27 downto 0);
           MB : out STD_LOGIC_VECTOR (27 downto 0));
end subnormals;

architecture Behavioral of subnormals is

signal C : STD_LOGIC;
signal ManA : STD_LOGIC_VECTOR(27 downto 0);
signal ManB : STD_LOGIC_VECTOR(27 downto 0);

begin

SA <= NumberA(36);
SB <= NumberB(36);

--Mantisa A & B
ManA <= NumberA(27 downto 0);
ManB <= NumberB(27 downto 0);

--Number Comparison
C <= '1' when ManA >= ManB else   -- A > B
     '0' when ManB > ManA else    -- B > A
     '-';
CompAB <= C;    
-- Output's Exponent
Exp <= NumberA(35 downto 28);

--Mantisa ( MA will be the greater Mantissa)

--Mantissa A & B
MA <= ManA when C = '1' else 
      ManB when C = '0' else
      "----------------------------";
      
MB <= ManB when C = '1' else 
      ManA when C = '0' else
      "----------------------------";

end Behavioral;
