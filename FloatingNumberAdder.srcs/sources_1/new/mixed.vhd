----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 05:12:05 PM
-- Design Name: 
-- Module Name: mixed - Behavioral
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

entity mixed is
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           NormalA : out STD_LOGIC_VECTOR (36 downto 0);
           NormalB : out STD_LOGIC_VECTOR (36 downto 0));
end mixed;


architecture Behavioral of mixed is

component comp 
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           Normal : out STD_LOGIC_VECTOR (36 downto 0);
           Subnormal : out STD_LOGIC_VECTOR (36 downto 0));
end component;

component zero_counter
    Port ( M : in STD_LOGIC_VECTOR (27 downto 0);
           Zcount : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component shift_left
port (     T : in STD_LOGIC_VECTOR (27 downto 0);
           Shft : in STD_LOGIC_VECTOR (4 downto 0);
           S : out STD_LOGIC_VECTOR (27 downto 0));
end component;

signal numberOfZero : STD_LOGIC_VECTOR(4 downto 0);
signal subnormalNumber : STD_LOGIC_VECTOR(36 downto 0);
signal shiftedMantissa : STD_LOGIC_VECTOR(27 downto 0);
signal ExpSubnormalNumber : STD_LOGIC_VECTOR(7 downto 0);

begin

-- Detect Normal and Subnormal number
detect_subnormal_number : comp
        port map( NumberA => NumberA,NumberB => NumberB,Normal => NormalA,Subnormal =>subnormalNumber);

--number of zeros at the begining of Mantissa     
count_zeros : zero_counter
        port map ( M => subnormalNumber(27 downto 0), Zcount => numberOfZero);

--shift left mantissa with number of zeros        
shiftleft : shift_left
        port map ( T => subnormalNumber(27 downto 0), Shft => numberOfZero, S => shiftedMantissa);

       
process ( numberOfZero,subnormalNumber,shiftedMantissa)
begin
    if numberOfZero /= "------" then
        ExpSubnormalNumber <= "000" & numberOfZero;
        NormalB(27 downto 0) <= shiftedMantissa(27 downto 1) & '1';   -- Bit 0 --> Mark     
    else
        ExpSubnormalNumber <= "--------";
        NormalB(27 downto 0) <= shiftedMantissa;
    end if;
        
end process;
    
    NormalB(35 downto 28) <= ExpSubnormalNumber;
    NormalB(36) <= subnormalNumber(36);
    
end Behavioral;
