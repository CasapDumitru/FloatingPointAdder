----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 07:00:42 PM
-- Design Name: 
-- Module Name: shift_right - Behavioral
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

entity shift_right is
port (     T : in STD_LOGIC_VECTOR (27 downto 0);
           Shft : in STD_LOGIC_VECTOR (4 downto 0);
           S : out STD_LOGIC_VECTOR (27 downto 0));
end shift_right;

architecture Behavioral of shift_right is

component MUX
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Sel : in STD_LOGIC;
           Z : out STD_LOGIC);
end component;

signal z1,z2,z3,z4,z5 : STD_LOGIC_VECTOR(27 downto 0);

begin

Comp1 : for i in 0 to 27 generate 

    shifter0_0: if (i=0) generate
                shifter0_0Mux : MUX port map( A => '0', B => T(27), Sel => Shft(0),Z => Z1(27-i));
                end generate;
    shifter0_i : if (i > 0) and (i < 28) generate
                 shifter0_iMux : MUX port map( A => T(27-(i-1)), B => T(27-i), Sel => Shft(0),Z => Z1(27-i));
                 end generate;
    
    shifter1_0: if( i>= 0) and (i < 2) generate
                shifter1_0Mux : MUX port map( A => '0', B => Z1(27-i), Sel => Shft(1),Z => Z2(27-i));
                end generate;
    shifter1_i: if( i> 1) and (i < 28) generate
                shifter1_iMux : MUX port map( A => z1(27-(i-2)), B => z1(27-i), Sel => Shft(1),Z => Z2(27-i));
                end generate;
    shifter2_0: if( i>= 0) and (i < 4) generate
                shifter2_0Mux : MUX port map( A => '0', B => Z2(27-i), Sel => Shft(2),Z => Z3(27-i));
                end generate;
    shifter2_i: if( i> 3) and (i < 28) generate
                shifter2_iMux : MUX port map( A => z2(27-(i-4)), B => z2(27-i), Sel => Shft(2),Z => Z3(27-i));
                end generate;
    shifter3_0: if( i>= 0) and (i < 8) generate
                shifter3_0Mux : MUX port map( A => '0', B => Z3(27-i), Sel => Shft(3),Z => Z4(27-i));
                end generate;
    shifter3_i: if( i> 7) and (i < 28) generate
                shifter3_iMux : MUX port map( A => z3(27-(i-8)), B => z3(27-i), Sel => Shft(3),Z => Z4(27-i));
                end generate;
    shifter4_0: if( i>= 0) and (i < 16) generate
                shifter4_0Mux : MUX port map( A => '0', B => Z4(27-i), Sel => Shft(4),Z => Z5(27-i));
                end generate;
    shifter4_i: if( i> 15) and (i < 28) generate
                shifter4_iMux : MUX port map( A => z4(27-(i-16)), B => z4(27-i), Sel => Shft(4),Z => Z5(27-i));
                end generate;
                
    end generate;
    
    S <= z5;


end Behavioral;
