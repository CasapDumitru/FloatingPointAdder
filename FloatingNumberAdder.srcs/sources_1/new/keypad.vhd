----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2017 12:25:00 PM
-- Design Name: 
-- Module Name: keypad - Behavioral
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

entity keypad is
    Port (  samp_ck : in STD_LOGIC; -- clock to strobe columns
            col : out STD_LOGIC_VECTOR (4 downto 1); -- output column lines
            row : in STD_LOGIC_VECTOR (4 downto 1); -- input row lines
            value : out STD_LOGIC_VECTOR (3 downto 0); -- hex value of key depressed
            hit : out STD_LOGIC); -- indicates when a key has been pressed
end keypad;

architecture Behavioral of keypad is

    signal CV1, CV2, CV3, CV4: std_logic_vector (4 downto 1) := "1111"; -- column vector of each row
    signal curr_col: std_logic_vector (4 downto 1) := "1110"; -- current column code
begin
-- This process synchronously tests the state of the keypad buttons. On each edge of samp_ck,
-- this module outputs a column code to the keypad in which one column line is held low while the
-- other three column lines are held high. The row outputs of that column are then read
-- into the corresponding column vector. The current column is then updated ready for the next
-- clock edge. Remember that curr_col is not updated until the process suspends.
            
    
    strobe_proc: process
    begin
        wait until rising_edge(samp_ck);
            case curr_col is
                when "1110" =>
                    CV1 <= row; curr_col <= "1101";
                when "1101" =>
                    CV2 <= row; curr_col <= "1011";
                when "1011" =>
                    CV3 <= row; curr_col <= "0111";
                when "0111" =>
                    CV4 <= row; curr_col <= "1110";
                when others =>
                    curr_col <= "1110";
            end case;
    end process;

    out_proc: process (CV1, CV2, CV3, CV4)
    begin
        hit <= '1';
        if CV1(1) = '0' then value <= X"1";
        elsif CV1(2) = '0' then value <= X"4";
        elsif CV1(3) = '0' then value <= X"7";
        elsif CV1(4) = '0' then value <= X"0";
        elsif CV2(1) = '0' then value <= X"2";
        elsif CV2(2) = '0' then value <= X"5";
        elsif CV2(3) = '0' then value <= X"8";
        elsif CV2(4) = '0' then value <= X"F";
        elsif CV3(1) = '0' then value <= X"3";
        elsif CV3(2) = '0' then value <= X"6";
        elsif CV3(3) = '0' then value <= X"9";
        elsif CV3(4) = '0' then value <= X"E";
        elsif CV4(1) = '0' then value <= X"A";
        elsif CV4(2) = '0' then value <= X"B";
        elsif CV4(3) = '0' then value <= X"C";
        elsif CV4(4) = '0' then value <= X"D";
        else hit <= '0'; value <= X"0";
        end if;
    end process;
    col <= curr_col;
    
end Behavioral; 
