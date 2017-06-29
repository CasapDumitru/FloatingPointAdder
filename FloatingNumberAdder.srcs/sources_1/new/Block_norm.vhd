----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2017 01:06:49 PM
-- Design Name: 
-- Module Name: Block_norm - Behavioral
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

entity Block_norm is
    Port ( MS : in STD_LOGIC_VECTOR (27 downto 0);
           ES : in STD_LOGIC_VECTOR (7 downto 0);
           CO : in STD_LOGIC;
           M : out STD_LOGIC_VECTOR (22 downto 0);
           E : out STD_LOGIC_VECTOR (7 downto 0));
end Block_norm;

architecture Behavioral of Block_norm is

    component zero_counter Port ( M : in STD_LOGIC_VECTOR (27 downto 0);
                                    Zcount : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    
    component shift_left Port ( T : in STD_LOGIC_VECTOR (27 downto 0);
                                Shft : in STD_LOGIC_VECTOR (4 downto 0);
                                S : out STD_LOGIC_VECTOR (27 downto 0));
    end component;
    
    component Round Port ( Min : in STD_LOGIC_VECTOR (26 downto 0);
                            Mout : out STD_LOGIC_VECTOR (22 downto 0));
    end component;
    
    signal Zcount_aux, Shift : std_logic_vector(4 downto 0);
    signal Number : std_logic_vector(27 downto 0);
    signal E1 : STD_LOGIC_VECTOR (7 downto 0);
    
    signal Round1, Round2 : STD_LOGIC_VECTOR(22 downto 0) := (others => '0');
begin
    comp0 : zero_counter port map (M => MS, Zcount => Zcount_aux);
    comp1 : shift_left port map (T => MS, Shft => Shift, S => Number);
    comp2 : Round port map (Min => Number(26 downto 0), Mout => Round2);
    round1_comp: Round port map (Min => MS(27 downto 1), Mout => Round1);
    
    --M <= Number(27) & Round2(22 downto 1) when (CO = '1' or ES = x"00")  else Round2;     
          
    --E <= x"00" when  ES < ("000" & Zcount_aux)  else 
      --   ES + 1  when CO = '1' else 
       --  ES - Zcount_aux;
    
    process(MS, ES, Shift, Zcount_aux, CO)
    begin
        if Zcount_aux = "-----" then 
            Shift <= "-----";
            E1 <= "--------";
        elsif ES > Zcount_aux then                      -- if the number is normal
            Shift <= Zcount_aux;                        -- ... the number is shifted --> Output normal
            E1 <= ES - Shift;
        elsif ES < Zcount_aux then                      -- if the number is normal 
            Shift <= ES(4 downto 0);                    -- ... the numner is shiftet --> output subnormal
            E1 <= X"00";
        elsif ES = Zcount_aux then                      -- if N Zeros = Exponent
            Shift <= Zcount_aux;                        -- ... the mantissa is shifted and EO = 1
            E1 <= X"01";
        end if;
    end process;
    
    --round2_comp: Round port map (Min => MS(26 downto 0), Mout => Round2);
    M <= Round1 when Co = '1' else Round2;
    E <= ES + 1 when Co = '1' else E1;
    

end Behavioral;
