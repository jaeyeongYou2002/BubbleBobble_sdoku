module manu(input clk,rst,[9:0] x,y,[4:0] key,key_pulse, output [2:0] rgb, output reg [1:0] game);

// text on screen
parameter SCREEN_X = 640; // 화면 가로 640픽셀
parameter SCRREN_Y = 480; // 화면 세로 480픽셀
parameter GAMESTART_X = 280;
parameter GAMESTART_Y = 100;
parameter SDOKU_X = 240;
parameter SDOKU_Y = 340;
parameter BB_X = 360;
parameter BB_Y = 340;

wire [6:0] char_addr;
reg [6:0] char_addr_g, char_addr_s, char_addr_b;
wire [2:0] bit_addr;
reg [2:0] bit_addr_g, bit_addr_s, bit_addr_b;
wire [3:0] row_addr, row_addr_g, row_addr_s, row_addr_b; 
wire gamestart_on, sdoku_on, bb_on;
reg box, box_on;

wire font_bit;
wire [7:0] font_word;
wire [10:0] rom_addr;

font_rom_vhd font_rom_inst (clk, rom_addr, font_word);

assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[~bit_addr];  //화면 x좌표는 왼쪽이 작은데, rom의 bit는 오른쪽이 작으므로 reverse

assign char_addr = (gamestart_on)? char_addr_g : (sdoku_on)? char_addr_s : (bb_on)? char_addr_b : 0;
assign row_addr = (gamestart_on)? row_addr_g : (sdoku_on)? row_addr_s : (bb_on)? row_addr_b : 0; 
assign bit_addr = (gamestart_on)? bit_addr_g : (sdoku_on)? bit_addr_s : (bb_on)? bit_addr_b : 0; 

assign gamestart_on = (y>=GAMESTART_Y && y<GAMESTART_Y+16 && x>=GAMESTART_X && x<GAMESTART_X+8*10)? 1 : 0; // game start는 10글자라서 *10
assign sdoku_on = (y>=SDOKU_Y && y<SDOKU_Y+16 && x>=SDOKU_X && x<SDOKU_X+8*5)? 1 : 0; // sdoku는 5글자라서 *10
assign bb_on = (y>=BB_Y && y<BB_Y+16 && x>=BB_X && x<BB_X+8*13)? 1 : 0; // bubble bobble은 13글자라서 *13
assign row_addr_g = y-GAMESTART_Y;
assign row_addr_s = y-SDOKU_Y;
assign row_addr_b = y-BB_Y;

// game start
always @ (*) begin
    if (x>=GAMESTART_X+8*0 && x<GAMESTART_X+8*1) begin bit_addr_g = x-GAMESTART_X-8*0; char_addr_g = 7'b1000111; end // G x47 (3bit,4bit)   
    else if (x>=GAMESTART_X+8*1 && x<GAMESTART_X+8*2) begin bit_addr_g = x-GAMESTART_X-8*1; char_addr_g = 7'b1100001; end // a x61
    else if (x>=GAMESTART_X+8*2 && x<GAMESTART_X+8*3) begin bit_addr_g = x-GAMESTART_X-8*2; char_addr_g = 7'b1101101; end // m x6D
    else if (x>=GAMESTART_X+8*3 && x<GAMESTART_X+8*4) begin bit_addr_g = x-GAMESTART_X-8*3; char_addr_g = 7'b1100101; end // e x65
    else if (x>=GAMESTART_X+8*4 && x<GAMESTART_X+8*5) begin bit_addr_g = x-GAMESTART_X-8*4; char_addr_g = 7'b0000000; end //
    else if (x>=GAMESTART_X+8*5 && x<GAMESTART_X+8*6) begin bit_addr_g = x-GAMESTART_X-8*5; char_addr_g = 7'b1010011; end // S x53
    else if (x>=GAMESTART_X+8*6 && x<GAMESTART_X+8*7) begin bit_addr_g = x-GAMESTART_X-8*6; char_addr_g = 7'b1110100; end // t x74
    else if (x>=GAMESTART_X+8*7 && x<GAMESTART_X+8*8) begin bit_addr_g = x-GAMESTART_X-8*7; char_addr_g = 7'b1100001; end // a x61
    else if (x>=GAMESTART_X+8*8 && x<GAMESTART_X+8*9) begin bit_addr_g = x-GAMESTART_X-8*8; char_addr_g = 7'b1110010; end // r x72
    else if (x>=GAMESTART_X+8*9 && x<GAMESTART_X+8*10) begin bit_addr_g = x-GAMESTART_X-8*9; char_addr_g = 7'b1110100; end // t x74
    else begin bit_addr_g = 0; char_addr_g = 0; end                         
end

// sdoku
always @ (*) begin
    if (x>=SDOKU_X+8*0 && x<SDOKU_X+8*1) begin bit_addr_s = x-SDOKU_X-8*0; char_addr_s = 7'b1010011; end // S x53
    else if (x>=SDOKU_X+8*1 && x<SDOKU_X+8*2) begin bit_addr_s = x-SDOKU_X-8*1; char_addr_s = 7'b1100100; end // d x64
    else if (x>=SDOKU_X+8*2 && x<SDOKU_X+8*3) begin bit_addr_s = x-SDOKU_X-8*2; char_addr_s = 7'b1101111; end // o x6F
    else if (x>=SDOKU_X+8*3 && x<SDOKU_X+8*4) begin bit_addr_s = x-SDOKU_X-8*3; char_addr_s = 7'b1101011; end // k x6B
    else if (x>=SDOKU_X+8*4 && x<SDOKU_X+8*5) begin bit_addr_s = x-SDOKU_X-8*4; char_addr_s = 7'b1110101; end // u x75
    else begin bit_addr_s = 0; char_addr_s = 0; end                         
end

// bubble bobble
always @ (*) begin
    if (x>=BB_X+8*0 && x<BB_X+8*1) begin bit_addr_b = x-BB_X-8*0; char_addr_b = 7'b1000010; end // B x42  
    else if (x>=BB_X+8*1 && x<BB_X+8*2) begin bit_addr_b = x-BB_X-8*1; char_addr_b = 7'b1110101; end // u x75
    else if (x>=BB_X+8*2 && x<BB_X+8*3) begin bit_addr_b = x-BB_X-8*2; char_addr_b = 7'b1100010; end // b x62
    else if (x>=BB_X+8*3 && x<BB_X+8*4) begin bit_addr_b = x-BB_X-8*3; char_addr_b = 7'b1100010; end // b x62
    else if (x>=BB_X+8*4 && x<BB_X+8*5) begin bit_addr_b = x-BB_X-8*4; char_addr_b = 7'b1101100; end // l x6C
    else if (x>=BB_X+8*5 && x<BB_X+8*6) begin bit_addr_b = x-BB_X-8*5; char_addr_b = 7'b1100101; end // e x65
    else if (x>=BB_X+8*6 && x<BB_X+8*7) begin bit_addr_b = x-BB_X-8*6; char_addr_b = 7'b0000000; end //
    else if (x>=BB_X+8*7 && x<BB_X+8*8) begin bit_addr_b = x-BB_X-8*7; char_addr_b = 7'b1000010; end // B x42
    else if (x>=BB_X+8*8 && x<BB_X+8*9) begin bit_addr_b = x-BB_X-8*8; char_addr_b = 7'b1101111; end // o x6F
    else if (x>=BB_X+8*9 && x<BB_X+8*10) begin bit_addr_b = x-BB_X-8*9; char_addr_b = 7'b1100010; end // b x62
    else if (x>=BB_X+8*10 && x<BB_X+8*11) begin bit_addr_b = x-BB_X-8*10; char_addr_b = 7'b1100010; end // b x62
    else if (x>=BB_X+8*11 && x<BB_X+8*12) begin bit_addr_b = x-BB_X-8*11; char_addr_b = 7'b1101100; end // l x6C
    else if (x>=BB_X+8*12 && x<BB_X+8*13) begin bit_addr_b = x-BB_X-8*12; char_addr_b = 7'b1100101; end // e x65
    else begin bit_addr_b = 0; char_addr_b = 0; end                         
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
        0 : if ((x>=SDOKU_X-5 && x<=SDOKU_X+8*5+5 && ((y>=SDOKU_Y-7 && y<=SDOKU_Y-5) || (y>=SDOKU_Y+20 && y<=SDOKU_Y+22))) || 
                (((x>=SDOKU_X-7 && x<=SDOKU_X-5) || (x>=SDOKU_X+8*5+5 && x<=SDOKU_X+8*5+7)) && y>=SDOKU_Y-5 && y<=SDOKU_Y+16+5))
                box_on = 1;
            else box_on = 0;
        1 : if ((x>=BB_X-5 && x<=BB_X+8*13+5 && ((y>=BB_Y-7 && y<=BB_Y-5) || (y>=BB_Y+20 && y<=BB_Y+22))) || 
                (((x>=BB_X-7 && x<=BB_X-5) || (x>=BB_X+8*13+5 && x<=BB_X+8*13+7)) && y>=BB_Y-5 && y<=BB_Y+16+5))
                box_on = 1;
            else box_on = 0;
    endcase
end

// game select    
always @ (*) begin
    if (key_pulse==5'h1d && box==0) game = 2'b00;
    else if (key_pulse==5'h1d && box==1) game = 2'b01; 
    else game = 2'b11;
    
end

// color setting
assign rgb = (font_bit & gamestart_on)? 3'b001 : //blue text
             (font_bit & sdoku_on)? 3'b001 : //blue text
             (font_bit & bb_on)? 3'b001 : //blue text
             (box_on)? 3'b100 : //red box
             3'b111; //white background
             
endmodule
