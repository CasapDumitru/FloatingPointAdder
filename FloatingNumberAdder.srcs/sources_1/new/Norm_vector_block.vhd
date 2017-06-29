----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2017 01:31:08 PM
-- Design Name: 
-- Module Name: Norm_vector_block - Behavioral
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

entity Norm_vector_block is
    Port ( SS : in STD_LOGIC;
           MS : in STD_LOGIC_VECTOR (27 downto 0);
           ES : in STD_LOGIC_VECTOR (7 downto 0);
           CO : in STD_LOGIC;
           N : out STD_LOGIC_VECTOR (31 downto 0));
end Norm_vector_block;

architecture Behavioral of Norm_vector_block is

    component Block_norm Port ( MS : in STD_LOGIC_VECTOR (27 downto 0);
           ES : in STD_LOGIC_VECTOR (7 downto 0);
           CO : in STD_LOGIC;
           M : out STD_LOGIC_VECTOR (27 downto 0);
           E : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component Vector Port ( S : in STD_LOGIC;
               E : in STD_LOGIC_VECTOR (7 downto 0);
               M : in STD_LOGIC_VECTOR (22 downto 0);
               N : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal Maux : std_logic_vector(22 downto 0);
    signal Eaux : std_logic_vector(7 downto 0);

begin

    comp0: Block_norm port map (MS => MS, ES => ES, CO => CO, M => Maux, E => Eaux);
    comp1: Vector port map (S => SS, E => Eaux, M => Maux, N => N);

end Behavioral;
