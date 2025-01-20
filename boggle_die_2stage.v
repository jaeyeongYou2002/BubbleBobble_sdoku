module boggle_die_2stage(input clk,rst,[9:0] x,y,[4:0] key,key_pulse, output [2:0] rgb, output reg [1:0] die_boggle2);

// text on screen
parameter SCREEN_X = 640; // 화면 가로 640픽셀
parameter SCRREN_Y = 480; // 화면 세로 480픽셀
parameter SD2_X = 280;
parameter SD2_Y = 100;
parameter RE_X = 240;
parameter RE_Y = 340;
parameter MENU_X = 360;
parameter MENU_Y = 340;

wire [6:0] char_addr;
reg [6:0] char_addr_d, char_addr_r, char_addr_m;
wire [2:0] bit_addr;
reg [2:0] bit_addr_d, bit_addr_r, bit_addr_m;
wire [3:0] row_addr, row_addr_d, row_addr_r, row_addr_m; 
wire die2_on, re_on, menu_on;
reg box, box_on;

wire font_bit;
wire [7:0] font_word;
wire [10:0] rom_addr;

font_rom_vhd font_rom_inst (clk, rom_addr, font_word);

assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[~bit_addr];  //화면 x좌표는 왼쪽이 작은데, rom의 bit는 오른쪽이 작으므로 reverse

assign char_addr = (die2_on)? char_addr_d : (re_on)? char_addr_r : (menu_on)? char_addr_m : 0;
assign row_addr = (die2_on)? row_addr_d : (re_on)? row_addr_r : (menu_on)? row_addr_m : 0; 
assign bit_addr = (die2_on)? bit_addr_d : (re_on)? bit_addr_r : (menu_on)? bit_addr_m : 0; 

assign die2_on = (y>=SD2_Y && y<SD2_Y+16 && x>=SD2_X && x<SD2_X+8*11)? 1 : 0; // 2 stage die는 11글자라서 *11
assign re_on = (y>=RE_Y && y<RE_Y+16 && x>=RE_X && x<RE_X+8*7)? 1 : 0; // restart는 7글자라서 *7
assign menu_on = (y>=MENU_Y && y<MENU_Y+16 && x>=MENU_X && x<MENU_X+8*4)? 1 : 0; // menu은 4글자라서 *4
assign row_addr_d = y-SD2_Y;
assign row_addr_r = y-RE_Y;
assign row_addr_m = y-MENU_Y;

// 1 stage die
always @ (*) begin
    if (x>=SD2_X+8*0 && x<SD2_X+8*1) begin bit_addr_d = x-SD2_X-8*0; char_addr_d = 7'b0110010; end // 2 x32   
    else if (x>=SD2_X+8*1 && x<SD2_X+8*2) begin bit_addr_d = x-SD2_X-8*1; char_addr_d = 7'b0000000; end // 
    else if (x>=SD2_X+8*2 && x<SD2_X+8*3) begin bit_addr_d = x-SD2_X-8*2; char_addr_d = 7'b1010011; end // S x53
    else if (x>=SD2_X+8*3 && x<SD2_X+8*4) begin bit_addr_d = x-SD2_X-8*3; char_addr_d = 7'b1110100; end // t x74
    else if (x>=SD2_X+8*4 && x<SD2_X+8*5) begin bit_addr_d = x-SD2_X-8*4; char_addr_d = 7'b1100001; end // a x61
    else if (x>=SD2_X+8*5 && x<SD2_X+8*6) begin bit_addr_d = x-SD2_X-8*5; char_addr_d = 7'b1100111; end // g x67
    else if (x>=SD2_X+8*6 && x<SD2_X+8*7) begin bit_addr_d = x-SD2_X-8*6; char_addr_d = 7'b1100101; end // e x65
    else if (x>=SD2_X+8*7 && x<SD2_X+8*8) begin bit_addr_d = x-SD2_X-8*7; char_addr_d = 7'b0000000; end //
    else if (x>=SD2_X+8*8 && x<SD2_X+8*9) begin bit_addr_d = x-SD2_X-8*8; char_addr_d = 7'b1000100; end // D x44
    else if (x>=SD2_X+8*9 && x<SD2_X+8*10) begin bit_addr_d = x-SD2_X-8*9; char_addr_d = 7'b1101001; end // i x69
     else if (x>=SD2_X+8*10 && x<SD2_X+8*11) begin bit_addr_d = x-SD2_X-8*10; char_addr_d = 7'b1100101; end // e x65
    else begin bit_addr_d = 0; char_addr_d = 0; end                         
end

// restart
always @ (*) begin
    if (x>=RE_X+8*0 && x<RE_X+8*1) begin bit_addr_r = x-RE_X-8*0; char_addr_r = 7'b1010010; end // R x52
    else if (x>=RE_X+8*1 && x<RE_X+8*2) begin bit_addr_r = x-RE_X-8*1; char_addr_r = 7'b1100101; end // e x65
    else if (x>=RE_X+8*2 && x<RE_X+8*3) begin bit_addr_r = x-RE_X-8*2; char_addr_r = 7'b1110011; end // s x73
    else if (x>=RE_X+8*3 && x<RE_X+8*4) begin bit_addr_r = x-RE_X-8*3; char_addr_r = 7'b1110100; end // t x74
    else if (x>=RE_X+8*4 && x<RE_X+8*5) begin bit_addr_r = x-RE_X-8*4; char_addr_r = 7'b1100001; end // a x61
    else if (x>=RE_X+8*5 && x<RE_X+8*6) begin bit_addr_r = x-RE_X-8*5; char_addr_r = 7'b1110010; end // r x72
    else if (x>=RE_X+8*6 && x<RE_X+8*7) begin bit_addr_r = x-RE_X-8*6; char_addr_r = 7'b1110100; end // t x74
    else begin bit_addr_r = 0; char_addr_r = 0; end                         
end

// menu
always @ (*) begin
    if (x>=MENU_X+8*0 && x<MENU_X+8*1) begin bit_addr_m = x-MENU_X-8*0; char_addr_m = 7'b1001101; end // M x4D
    else if (x>=MENU_X+8*1 && x<MENU_X+8*2) begin bit_addr_m = x-MENU_X-8*1; char_addr_m = 7'b1100101; end // e x65
    else if (x>=MENU_X+8*2 && x<MENU_X+8*3) begin bit_addr_m = x-MENU_X-8*2; char_addr_m = 7'b1101110; end // n x6E
    else if (x>=MENU_X+8*3 && x<MENU_X+8*4) begin bit_addr_m = x-MENU_X-8*3; char_addr_m = 7'b1110101; end // u x75
    else begin bit_addr_m = 0; char_addr_m = 0; end                         
end

//box
always @(posedge clk or posedge rst) begin
    if (rst) box <= 1'b0;
    else if (key_pulse==5'h1e) begin
    if (box==1) box <= 1'b0;
    else box <= box + 1;
    end
end

// box_on
always @ (*) begin
    case (box)
        0 : if ((x>=RE_X-5 && x<=RE_X+8*7+5 && ((y>=RE_Y-7 && y<=RE_Y-5) || (y>=RE_Y+20 && y<=RE_Y+22))) || 
                (((x>=RE_X-7 && x<=RE_X-5) || (x>=RE_X+8*7+5 && x<=RE_X+8*7+7)) && y>=RE_Y-5 && y<=RE_Y+16+5))
                box_on = 1;
            else box_on = 0;
        1 : if ((x>=MENU_X-5 && x<=MENU_X+8*4+5 && ((y>=MENU_Y-7 && y<=MENU_Y-5) || (y>=MENU_Y+20 && y<=MENU_Y+22))) || 
                (((x>=MENU_X-7 && x<=MENU_X-5) || (x>=MENU_X+8*4+5 && x<=MENU_X+8*4+7)) && y>=MENU_Y-5 && y<=MENU_Y+16+5))
                box_on = 1;
            else box_on = 0;
    endcase
end

// die_boggle2 select    
always @ (*) begin
    if (key_pulse==5'h1d && box==0) die_boggle2 = 2'b00; // restart
    else if (key_pulse==5'h1d && box==1) die_boggle2 = 2'b01; // menu
    else die_boggle2 = 2'b11;
    
end

// color setting
assign rgb = (font_bit & die2_on)? 3'b001 : //blue text
             (font_bit & re_on)? 3'b001 : //blue text
             (font_bit & menu_on)? 3'b001 : //blue text
             (box_on)? 3'b100 : //red box
             3'b111; //white background
             
endmodule
