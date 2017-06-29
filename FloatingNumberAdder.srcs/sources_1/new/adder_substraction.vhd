----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2017 08:12:10 PM
-- Design Name: 
-- Module Name: adder_substraction - Behavioral
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

entity adder_substraction is
    Port ( NumberA : in STD_LOGIC_VECTOR (31 downto 0);
           NumberB : in STD_LOGIC_VECTOR (31 downto 0);
           Operation : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end adder_substraction;

architecture Behavioral of adder_substraction is

component Special_cases
    Port ( numberA : in STD_LOGIC_VECTOR (31 downto 0);    
           numberB : in STD_LOGIC_VECTOR (31 downto 0);
           sign : in STD_LOGIC;
           resultS : out STD_LOGIC_VECTOR (31 downto 0);
           enable : out STD_LOGIC);                         --enable Pre-Adder Component
end component;

component preadder 
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

component Block_Adder
    Port ( SA : in STD_LOGIC;
           SB : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (27 downto 0);
           B : in STD_LOGIC_VECTOR (27 downto 0);
           A_S : in STD_LOGIC;
           Comp : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (27 downto 0);
           SO : out STD_LOGIC;
           CO : out STD_LOGIC);
end component;

component Block_norm
    Port ( MS : in STD_LOGIC_VECTOR (27 downto 0);
           ES : in STD_LOGIC_VECTOR (7 downto 0);
           CO : in STD_LOGIC;
           M : out STD_LOGIC_VECTOR (22 downto 0);
           E : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Vector is
    Port ( S : in STD_LOGIC;
           E : in STD_LOGIC_VECTOR (7 downto 0);
           M : in STD_LOGIC_VECTOR (22 downto 0);
           N : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal result_special_case : STD_LOGIC_VECTOR(31 downto 0);
signal enable : STD_LOGIC;
signal SA,SB,C : STD_LOGIC;
signal E : STD_LOGIC_VECTOR(7 downto 0);
signal MA,MB : STD_LOGIC_VECTOR(27 downto 0);
signal S : STD_LOGIC_VECTOR(27 downto 0);
signal SO,CO : STD_LOGIC;
signal MRes : STD_LOGIC_VECTOR(22 downto 0);
signal ERes : STD_LOGIC_VECTOR(7 downto 0 );
signal ResultSum : STD_LOGIC_VECTOR(31 downto 0);

begin

special_cases_component : Special_cases
    port map ( numberA => NumberA, numberB => NumberB, Sign => Operation,
               resultS => result_special_case, enable => enable);

preadder_component :  preadder 
    port map(NumberA => NumberA, NumberB => NumberB, enable => enable, SA => SA, SB => SB,
             C => C, E => E, MA => MA, MB => MB); 
                
adder_component : Block_Adder 
    port map (SA => SA, SB => SB, A => MA, B => MB, Comp => C, A_S => Operation, S => S, SO => SO, CO => CO);               
                
normalize_component : Block_norm
    port map ( MS => S,ES => E, CO => CO, M => MRes, E => ERes);
    
number_constructor : Vector
    port map ( M => MRes, E => ERes, S => SO, N => ResultSum);
    
Result <= ResultSum when enable = '1' else result_special_case;
    

end Behavioral;
