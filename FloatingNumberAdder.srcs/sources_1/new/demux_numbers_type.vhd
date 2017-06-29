----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 08:57:50 PM
-- Design Name: 
-- Module Name: demux_numbers_type - Behavioral
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

entity demux_numbers_type is
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           A_sub : out STD_LOGIC_VECTOR (36 downto 0);
           B_sub : out STD_LOGIC_VECTOR (36 downto 0);
           A_nor : out STD_LOGIC_VECTOR (36 downto 0);
           B_nor : out STD_LOGIC_VECTOR (36 downto 0);
           A_mix : out STD_LOGIC_VECTOR (36 downto 0);
           B_mix : out STD_LOGIC_VECTOR (36 downto 0));
end demux_numbers_type;

architecture Behavioral of demux_numbers_type is

begin

    process(NumberA,NumberB,sel)
    begin
    
        case sel is
            --subnormals
            when "00" => A_sub <= NumberA;
                         B_sub <= NumberB;
                         A_nor <= "-------------------------------------";
                         B_nor <= "-------------------------------------";
                         A_mix <= "-------------------------------------";
                         B_mix <= "-------------------------------------";
            --normals
             when "01" => A_sub <= "-------------------------------------";
                          B_sub <= "-------------------------------------";
                          A_nor <= NumberA;
                          B_nor <= NumberB;
                          A_mix <= "-------------------------------------";
                          B_mix <= "-------------------------------------";
             --mixed
              when "10" => A_sub <= "-------------------------------------";
                           B_sub <= "-------------------------------------";
                           A_nor <= "-------------------------------------";
                           B_nor <= "-------------------------------------";
                           A_mix <= NumberA;
                           B_mix <= NumberB;
            --others
            when others => A_sub <= "-------------------------------------";
                          B_sub <= "-------------------------------------";
                          A_nor <= "-------------------------------------";
                          B_nor <= "-------------------------------------";
                          A_mix <= "-------------------------------------";
                          B_mix <= "-------------------------------------";
         end case;
     end process;
                           
end Behavioral;
