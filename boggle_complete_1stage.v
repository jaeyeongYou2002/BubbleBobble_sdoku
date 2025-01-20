module boggle_complete_1stage(input clk,rst,[9:0] x,y,[4:0] key,key_pulse, output [2:0] rgb, output reg [1:0] complete_boggle1);

// text on screen
parameter SCREEN_X = 640; // 화면 가로 640픽셀
parameter SCRREN_Y = 480; // 화면 세로 480픽셀
parameter SC_X = 260;
parameter SC_Y = 100;
parameter RE_X = 200;
parameter RE_Y = 340;
parameter MENU_X = 300;
parameter MENU_Y = 340;
parameter NEXT_X = 400;
parameter NEXT_Y = 340;

wire [6:0] char_addr;
reg [6:0] char_addr_c, char_addr_r, char_addr_m, char_addr_n;
wire [2:0] bit_addr;
reg [2:0] bit_addr_c, bit_addr_r, bit_addr_m, bit_addr_n;
wire [3:0] row_addr, row_addr_c, row_addr_r, row_addr_m, row_addr_n; 
wire complete_on, re_on, menu_on, next_on;
reg [1:0] box;
reg box_on;

wire font_bit;
wire [7:0] font_word;
wire [10:0] rom_addr;

font_rom_vhd font_rom_inst (clk, rom_addr, font_word);

assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[~bit_addr];  //화면 x좌표는 왼쪽이 작은데, rom의 bit는 오른쪽이 작으므로 reverse

assign char_addr = (complete_on)? char_addr_c : (re_on)? char_addr_r : (menu_on)? char_addr_m : (next_on)? char_addr_n : 0;
assign row_addr = (complete_on)? row_addr_c : (re_on)? row_addr_r : (menu_on)? row_addr_m : (next_on)? row_addr_n : 0; 
assign bit_addr = (complete_on)? bit_addr_c : (re_on)? bit_addr_r : (menu_on)? bit_addr_m : (next_on)? bit_addr_n : 0; 

assign complete_on = (y>=SC_Y && y<SC_Y+16 && x>=SC_X && x<SC_X+8*16)? 1 : 0; // 1 stage complete는 16글자라서 *16
assign re_on = (y>=RE_Y && y<RE_Y+16 && x>=RE_X && x<RE_X+8*7)? 1 : 0; // restart는 7글자라서 *7
assign menu_on = (y>=MENU_Y && y<MENU_Y+16 && x>=MENU_X && x<MENU_X+8*4)? 1 : 0; // menu는 4글자라서 *4
assign next_on = (y>=NEXT_Y && y<NEXT_Y+16 && x>=NEXT_X && x<NEXT_X+8*4)? 1 : 0; // next는 4글자라서 *4
assign row_addr_c = y-SC_Y;
assign row_addr_r = y-RE_Y;
assign row_addr_m = y-MENU_Y;
assign row_addr_n = y-NEXT_Y;

// 1 Stage Complete
always @ (*) begin
    if (x>=SC_X+8*0 && x<SC_X+8*1) begin bit_addr_c = x-SC_X-8*0; char_addr_c = 7'b0110001; end // 1 x31  
    else if (x>=SC_X+8*1 && x<SC_X+8*2) begin bit_addr_c = x-SC_X-8*1; char_addr_c = 7'b0000000; end // 
    else if (x>=SC_X+8*2 && x<SC_X+8*3) begin bit_addr_c = x-SC_X-8*2; char_addr_c = 7'b1010011; end // S x53
    else if (x>=SC_X+8*3 && x<SC_X+8*4) begin bit_addr_c = x-SC_X-8*3; char_addr_c = 7'b1110100; end // t x74
    else if (x>=SC_X+8*4 && x<SC_X+8*5) begin bit_addr_c = x-SC_X-8*4; char_addr_c = 7'b1100001; end // a x61
    else if (x>=SC_X+8*5 && x<SC_X+8*6) begin bit_addr_c = x-SC_X-8*5; char_addr_c = 7'b1100111; end // g x67
    else if (x>=SC_X+8*6 && x<SC_X+8*7) begin bit_addr_c = x-SC_X-8*6; char_addr_c = 7'b1100101; end // e x65
    else if (x>=SC_X+8*7 && x<SC_X+8*8) begin bit_addr_c = x-SC_X-8*7; char_addr_c = 7'b0000000; end //
    else if (x>=SC_X+8*8 && x<SC_X+8*9) begin bit_addr_c = x-SC_X-8*8; char_addr_c = 7'b1000011; end // C x43  
    else if (x>=SC_X+8*9 && x<SC_X+8*10) begin bit_addr_c = x-SC_X-8*9; char_addr_c = 7'b1101111; end // o x6F
    else if (x>=SC_X+8*10 && x<SC_X+8*11) begin bit_addr_c = x-SC_X-8*10; char_addr_c = 7'b1101101; end // m x6D
    else if (x>=SC_X+8*11 && x<SC_X+8*12) begin bit_addr_c = x-SC_X-8*11; char_addr_c = 7'b1110000; end // p x70
    else if (x>=SC_X+8*12 && x<SC_X+8*13) begin bit_addr_c = x-SC_X-8*12; char_addr_c = 7'b1101100; end // l x6C
    else if (x>=SC_X+8*13 && x<SC_X+8*14) begin bit_addr_c = x-SC_X-8*13; char_addr_c = 7'b1100101; end // e x65
    else if (x>=SC_X+8*14 && x<SC_X+8*15) begin bit_addr_c = x-SC_X-8*14; char_addr_c = 7'b1110100; end // t x74
    else if (x>=SC_X+8*15 && x<SC_X+8*16) begin bit_addr_c = x-SC_X-8*15; char_addr_c = 7'b1100101; end // e x65
    else begin bit_addr_c = 0; char_addr_c = 0; end                         
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

// Next
always @ (*) begin
    if (x>=NEXT_X+8*0 && x<NEXT_X+8*1) begin bit_addr_n = x-NEXT_X-8*0; char_addr_n = 7'b1001110; end // N x4E 
    else if (x>=NEXT_X+8*1 && x<NEXT_X+8*2) begin bit_addr_n = x-NEXT_X-8*1; char_addr_n = 7'b1100101; end // e x65
    else if (x>=NEXT_X+8*2 && x<NEXT_X+8*3) begin bit_addr_n = x-NEXT_X-8*2; char_addr_n = 7'b1111000; end // x x78
    else if (x>=NEXT_X+8*3 && x<NEXT_X+8*4) begin bit_addr_n = x-NEXT_X-8*3; char_addr_n = 7'b1110100; end // t x74
    else begin bit_addr_n = 0; char_addr_n = 0; end                         
end

//box
always @(posedge clk or posedge rst) begin
    if (rst) box <= 1'b0;
    else if (key_pulse==5'h1e) begin
    if (box==2) box <= 1'b0;
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
        2 : if ((x>=NEXT_X-5 && x<=NEXT_X+8*4+5 && ((y>=NEXT_Y-7 && y<=NEXT_Y-5) || (y>=NEXT_Y+20 && y<=NEXT_Y+22))) || 
                (((x>=NEXT_X-7 && x<=NEXT_X-5) || (x>=NEXT_X+8*4+5 && x<=NEXT_X+8*4+7)) && y>=NEXT_Y-5 && y<=NEXT_Y+16+5))
                box_on = 1;
            else box_on = 0;
    endcase
end

// complete_boggle1 select    
always @ (*) begin
    if (key_pulse==5'h1d && box==0) complete_boggle1 = 2'b00; // Restart
    else if (key_pulse==5'h1d && box==1) complete_boggle1 = 2'b01; // Menu
    else if (key_pulse==5'h1d && box==2) complete_boggle1 = 2'b10; // Next
    else complete_boggle1 = 2'b11;
    
end

// color setting
assign rgb = (font_bit & complete_on)? 3'b001 : //blue text
             (font_bit & re_on)? 3'b001 : //blue text
             (font_bit & menu_on)? 3'b001 : //blue text
             (font_bit & next_on)? 3'b001 : //blue text
             (box_on)? 3'b100 : //red box
             3'b111; //white background

endmodule
