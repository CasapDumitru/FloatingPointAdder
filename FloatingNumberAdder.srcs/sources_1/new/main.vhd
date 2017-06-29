----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/08/2017 12:54:51 PM
-- Design Name: 
-- Module Name: main - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
Port (  Clk : in STD_LOGIC; -- system clock (50 MHz)
        bt_clr: in STD_LOGIC; -- calculator "clear" button
        bt_exec: in STD_LOGIC; -- execute operation
        select_number: in STD_LOGIC_VECTOR(1 downto 0); --first or second number
        operation : in STD_LOGIC; --'1'- plus  '0'- minus
        anode : out STD_LOGIC_VECTOR (7 downto 0); -- anodes of four 7-seg displays
        seg : out STD_LOGIC_VECTOR (7 downto 0); -- common segments of 7-seg displays    
        JA : inout  STD_LOGIC_VECTOR (7 downto 0); 
        vector : out STD_LOGIC_VECTOR(3 downto 0);
        hit : out STD_LOGIC);
end main;

architecture Behavioral of main is

component debounce
    Port ( Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           D_in : in STD_LOGIC;
           Q_out : out STD_LOGIC);
end component;

component adder_substraction
    Port ( NumberA : in STD_LOGIC_VECTOR (31 downto 0);
           NumberB : in STD_LOGIC_VECTOR (31 downto 0);
           Operation : in STD_LOGIC;
           Result : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component keypad
    Port (  samp_ck : in STD_LOGIC; -- clock to strobe columns
            col : out STD_LOGIC_VECTOR (3 downto 0); -- output column lines
            row : in STD_LOGIC_VECTOR (3 downto 0); -- input row lines
            value : out STD_LOGIC_VECTOR (3 downto 0); -- hex value of key depressed
            hit : out STD_LOGIC); -- indicates when a key has been pressed
end component;


component displ7seg
    Port ( Clk  : in  STD_LOGIC;
           Rst  : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);   -- datele pentru 8 cifre (cifra 1 din stanga: biti 31..28)
           An   : out STD_LOGIC_VECTOR (7 downto 0);    -- selectia anodului activ
           Seg  : out STD_LOGIC_VECTOR (7 downto 0));   -- selectia catozilor (segmentelor) cifrei active
end component;


signal KP_hit : STD_LOGIC;
signal KP_clk : STD_LOGIC;
signal cnt: std_logic_vector(15 downto 0) := (others =>'0'); 
signal digit_number : integer := 0;
signal numberA,numberB : STD_LOGIC_VECTOR(31 downto 0) := (others =>'0'); 
signal KP_value : STD_LOGIC_VECTOR(3 downto 0);
signal Result : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
signal Res : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal number_to_show : STD_LOGIC_VECTOR(31 downto 0);
signal execute : STD_LOGIC := '0';
signal digitIncrement : STD_LOGIC := '0';
signal hit_db : STD_LOGIC := '0';
signal curSw : STD_LOGIC_VECTOR := "00";
signal clear : STD_LOGIC := '0';
signal resetCounter : STD_LOGIC := '0';

begin


cnt_proc: process(Clk)
begin
    if rising_edge( Clk) then -- on rising edge of clock
        cnt <= cnt+1; -- increment counter
    end if;
end process;

Kp_clk <= cnt(15);

keypad_component : keypad 
    port map (samp_ck => Kp_clk, col => JA(3 downto 0),
row => JA(7 downto 4), value => KP_value, hit => KP_hit);


seven_segment : displ7seg 
    port map(Clk => Clk,Rst => '0', Data => number_to_show,An => Anode,Seg => Seg);
           
debounce_exec_btn : debounce
    port map( Clk => Clk, Rst => bt_clr, D_in => bt_exec, Q_out => execute);
    
debounce_clear : debounce
        port map( Clk => Clk, Rst => '0', D_in => bt_clr, Q_out => clear);
    
debounce_hit_btn : debounce
    port map( Clk => Clk, Rst => clear, D_in => KP_HIT, Q_out => hit_db);

adder_substraction_comp : adder_substraction 
    port map(NumberA => NumberA,NumberB => NumberB,Operation => operation,Result => Res);
    
process(execute)
begin
    if execute = '1' then
        Result <= Res;
    end if;
end process;


number_for_7segm : process(Clk,select_number, NumberA, NumberB, Result) 
begin
if rising_edge(Clk) then
    if(select_number = "00") then
        number_to_show <= NumberA;
    elsif(select_number = "10") then
        number_to_show <= NumberB;
    else
        number_to_show <= Result;
    end if;
end if;
end process;


--reset_digit_number : process (Clk,clear) 
--begin
    --if clear = '1' then
       -- NumberA <= (others => '0');
        --NumberB <= (others => '0');
       -- Result <= (others => '0');
        
--    elsif rising_edge(Clk) then
--        if select_number /= curSw then
--            resetCounter <= '1';
--            curSw <= select_number;
--        end if;
    --end if;
--end process;


hit_process : process (Clk,clear) 
begin
    if clear = '1' then
        NumberA <= (others => '0');
        NumberB <= (others => '0');
        --Result <= (others => '0');
        digit_number <= 0;
    elsif rising_edge(Clk) then
        if hit_db = '1' then
                if(select_number = "00") then
                    NumberA((31 - (digit_number*4)) downto (32 - ((digit_number+1) *4))) <= KP_value;   
                elsif(select_number = "10") then
                    NumberB((31 - (digit_number*4)) downto (32 - ((digit_number+1) *4))) <= KP_value;   
                end if;
                if digit_number = 7 then 
                      digit_number <= 0;
                else
                      digit_number <= digit_number + 1;
                end if;  
        end if;   
                       
    end if;
end process;



hit <= KP_HIT;

vector <= STD_LOGIC_VECTOR(to_unsigned(digit_number,4));

end Behavioral;
