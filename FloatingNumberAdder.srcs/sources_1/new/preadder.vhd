----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2017 10:02:58 PM
-- Design Name: 
-- Module Name: preadder - Behavioral
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

entity preadder is
    Port ( NumberA : in STD_LOGIC_VECTOR (31 downto 0);
           NumberB : in STD_LOGIC_VECTOR (31 downto 0);
           enable : in STD_LOGIC;
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           C : out STD_LOGIC;
           E : out STD_LOGIC_VECTOR (7 downto 0);
           MA : out STD_LOGIC_VECTOR (27 downto 0);
           MB : out STD_LOGIC_VECTOR (27 downto 0));
end preadder;

architecture Behavioral of preadder is

component selector 
    Port ( NumberA : in STD_LOGIC_VECTOR (31 downto 0);
           NumberB : in STD_LOGIC_VECTOR (31 downto 0);
           enable : in STD_LOGIC;
           NA : out STD_LOGIC_VECTOR (36 downto 0);
           NB : out STD_LOGIC_VECTOR (36 downto 0);
           sel : out STD_LOGIC_VECTOR(1 downto 0));
end component;

component demux_numbers_type
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           A_sub : out STD_LOGIC_VECTOR (36 downto 0);
           B_sub : out STD_LOGIC_VECTOR (36 downto 0);
           A_nor : out STD_LOGIC_VECTOR (36 downto 0);
           B_nor : out STD_LOGIC_VECTOR (36 downto 0);
           A_mix : out STD_LOGIC_VECTOR (36 downto 0);
           B_mix : out STD_LOGIC_VECTOR (36 downto 0));
end component;

component mux_mix_normal
Port (     A_nor : in STD_LOGIC_VECTOR (36 downto 0);
           B_nor : in STD_LOGIC_VECTOR (36 downto 0);
           A_mix : in STD_LOGIC_VECTOR (36 downto 0);
           B_mix : in STD_LOGIC_VECTOR (36 downto 0);
           sel :   in STD_LOGIC_VECTOR(1 downto 0);
           NA :    out STD_LOGIC_VECTOR (36 downto 0);
           NB :    out STD_LOGIC_VECTOR (36 downto 0));
end component;

component subnormals
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           CompAB : out STD_LOGIC;
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           Exp : out STD_LOGIC_VECTOR (7 downto 0);
           MA : out STD_LOGIC_VECTOR (27 downto 0);
           MB : out STD_LOGIC_VECTOR (27 downto 0));
end component;

component normals
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           SA : out STD_LOGIC;
           SB : out STD_LOGIC;
           EO : out STD_LOGIC_VECTOR (7 downto 0);
           MA : out STD_LOGIC_VECTOR (27 downto 0);
           MB : out STD_LOGIC_VECTOR (27 downto 0);
           CompAB : out STD_LOGIC);
end component;

component mixed is
    Port ( NumberA : in STD_LOGIC_VECTOR (36 downto 0);
           NumberB : in STD_LOGIC_VECTOR (36 downto 0);
           NormalA : out STD_LOGIC_VECTOR (36 downto 0);
           NormalB : out STD_LOGIC_VECTOR (36 downto 0));
end component;

component mux_adder
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
end component;

signal NA_sel,NB_sel : STD_LOGIC_VECTOR(36 downto 0);
signal sel : STD_LOGIC_VECTOR(1 downto 0);
signal A_sub,B_sub,A_nor,B_nor,A_mix,B_mix : STD_LOGIC_VECTOR(36 downto 0);
signal Mix_A,Mix_B : STD_LOGIC_VECTOR(36 downto 0);
signal A_Normal,B_Normal : STD_LOGIC_VECTOR(36 downto 0);
signal SA_sub, SB_sub,SA_nor,SB_nor : STD_LOGIC;
signal Exp_nor,Exp_sub : STD_LOGIC_VECTOR(7 downto 0);
signal MA_sub,MB_sub,MA_nor,MB_nor : STD_LOGIC_VECTOR(27 downto 0);
signal CompAB_sub,CompAB_nor : STD_LOGIC;

begin


selector_port : selector 
    port map(NumberA => NumberA, NumberB => NumberB, enable => enable, NA => NA_sel, NB => NB_sel, sel => sel);

number_types : demux_numbers_type
    port map ( NumberA => NA_sel,NumberB => NB_sel, sel => sel, A_sub => A_sub,B_Sub => B_Sub,
               A_nor => A_nor,B_nor => B_nor,A_mix => A_mix,B_mix => B_mix);

mixed_component : mixed
    port map ( NumberA => A_mix, NumberB => B_mix, NormalA => Mix_A, NormalB => Mix_B);

mix_or_normal : mux_mix_normal
    port map ( A_nor => A_nor, B_nor => B_nor, A_mix => Mix_A, B_mix => Mix_B,sel => sel, NA => A_Normal, NB => B_Normal);

subnormal_component : subnormals
    port map ( NumberA => A_sub, NumberB => B_sub, CompAB => CompAB_sub,SA => SA_sub, SB => SB_sub,
               Exp => Exp_sub, MA => MA_sub, MB => MB_sub);

normal_component : normals
    port map ( NumberA => A_Normal, NumberB => B_Normal, CompAB => CompAB_nor,SA => SA_nor, SB => SB_nor,
               EO => Exp_nor, MA => MA_nor, MB => MB_nor);

mux_normal_or_subnormal : mux_adder
    port map ( SA_nor =>SA_nor,SB_nor => SB_nor,Comp_nor => CompAB_nor,Exp_nor => Exp_nor, MA_nor => MA_nor,MB_nor => MB_nor,
               SA_sub =>SA_sub,SB_sub => SB_sub,Comp_sub => CompAB_sub,Exp_sub => Exp_sub, MA_sub => MA_sub,MB_sub => MB_sub,     
               sel => sel, SA => SA, SB => SB, C => C, E => E, MA => MA, MB => MB);         


end Behavioral;
