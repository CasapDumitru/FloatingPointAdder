----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2017 10:58:30 PM
-- Design Name: 
-- Module Name: normals - Behavioral
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

entity normals is
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           EO : out STD_LOGIC_VECTOR (7 downto 0);
           MA : out STD_LOGIC_VECTOR (27 downto 0);
           MB : out STD_LOGIC_VECTOR (27 downto 0);
           CompAB : out STD_LOGIC);
end normals;

architecture Behavioral of normals is

component comp_exp
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           EMax : out STD_LOGIC_VECTOR (7 downto 0);
           MMax : out STD_LOGIC_VECTOR (27 downto 0);
           MShft : out STD_LOGIC_VECTOR (27 downto 0);
           DExp : out STD_LOGIC_VECTOR (4 downto 0);
           Comp : out STD_LOGIC);
end component;

signal MShft_aux : STD_LOGIC_VECTOR(27 downto 0);
signal DExp_aux : STD_LOGIC_VECTOR(4 downto 0);

component shift_right
port (     T : in STD_LOGIC_VECTOR (27 downto 0);
           Shft : in STD_LOGIC_VECTOR (4 downto 0);
           S : out STD_LOGIC_VECTOR (27 downto 0));
end component;

begin

comparare_exponenti : comp_exp 
    port map(NumberA => NumberA, NumberB => NumberB,SA => SA, 
             SB=> SB, Emax => EO, Mmax => MA, Mshft => Mshft_aux, 
             Dexp => DExp_aux,Comp => CompAB);

aliniere_mantisa : shift_right
    port map ( T => Mshft_aux, shft => Dexp_aux, S => MB);
    

end Behavioral;
