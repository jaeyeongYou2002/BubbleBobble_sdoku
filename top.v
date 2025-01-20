module top(
    input clk_board,
    input reset_poweron,
    input [1:0] btn, 
    inout [7:0] key_io,
    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue,
    output vsync,
    output hsync
    );
wire clk, rst, locked;  
wire [9:0] x, y; 
wire [2:0] rgb_boggle1;
wire [2:0] rgb_sdoku;
wire [2:0] rgb_manu;
wire [2:0] rgb_complete_sdoku;
wire [2:0] rgb_complete_boggle1;
wire [2:0] rgb_die_boggle1;
wire [2:0] rgb_complete_boggle2;
wire [2:0] rgb_die_boggle2;
wire [2:0] rgb_boggle2;

wire video_on; 
wire [4:0] key_tmp, key, key_pulse;
wire  [1:0] game;
wire [1:0] complete_sdoku;
wire [1:0] complete_boggle1;
wire [1:0] complete_boggle2;
wire [1:0] die_boggle1;
wire [1:0] die_boggle2;
reg [3:0] current_state;
reg [3:0] next_state;

wire boggle1_complete_on; //게임 내부에서 이 신호를 받음
wire boggle1_die_on; //게임 내부에서 이 신호를 받음
wire boggle2_complete_on;
wire boggle2_die_on;
wire [1:0] sdoku_complete_on;

/////////////////////////////////
clk_wiz_0 clk_inst (clk, reset_poweron, locked, clk_board); 
assign rst = reset_poweron | (~locked); 
keypad #(.CLK_KHZ(25175)) keypad_inst (clk, rst, key_io[7:4], key_io[3:0], key_tmp); 
debounce #(.SIZE(16), .BTN_WIDTH(5)) debounce_inst (clk, rst, key_tmp, key, key_pulse); 

// sync module
sync_mod sync_inst (rst, clk, x, y, video_on, vsync, hsync); 

// 모듈 호출
boggle_graph_mod1 b1(clk, restart_boggle1, x, y, key, key_pulse, rgb_boggle1,boggle1_complete_on,boggle1_die_on);
boggle_graph_mod2 b2 (clk, restart_boggle2, x, y, key, key_pulse, rgb_boggle2,boggle2_complete_on,boggle2_die_on);

sdoku_graph_mod s(clk, rstart_sdoku, x, y, key, key_pulse, rgb_sdoku , sdoku_complete_on);
manu m(clk, rst, x, y, key, key_pulse, rgb_manu, game);

sdoku_complete sdo(clk, rst, x, y, key, key_pulse, rgb_complete_sdoku, complete_sdoku);
boggle_complete_1stage c1(clk, rst, x, y, key, key_pulse, rgb_complete_boggle1, complete_boggle1);
boggle_complete_2stage c2(clk, rst, x, y, key, key_pulse, rgb_complete_boggle2, complete_boggle2);
boggle_die_1stage d1(clk, rst, x, y, key, key_pulse, rgb_die_boggle1, die_boggle1);
boggle_die_2stage d2(clk, rst, x, y, key, key_pulse, rgb_die_boggle2, die_boggle2);


wire restart_boggle1 = (current_state != BOGGLE1) || (key_pulse == 5'h1b) ? 1 : 0;
wire restart_boggle2 = (current_state != BOGGLE2) || (key_pulse == 5'h1b)? 1 : 0;
wire rstart_sdoku = (current_state != SDOKU) ? 1 : 0;


parameter MANU = 4'b0000;
parameter BOGGLE1 = 4'b0001;
parameter BOGGLE1_COMPLETE = 4'b0010;
parameter BOGGLE1_DIE = 4'b0011;
parameter BOGGLE2 = 4'b0100;
parameter BOGGLE2_COMPLETE = 4'b0101;
parameter BOGGLE2_DIE = 4'b0110;
parameter SDOKU = 4'b0111;
parameter SDOKU_COMPLETE = 4'b1000;

always@ (*) begin
case(current_state)
    MANU: begin
        if(game==2'b00) next_state = SDOKU;
        else if(game == 2'b01) next_state = BOGGLE1;
        else  next_state = current_state;  
        end
        
    BOGGLE1: begin
        if(boggle1_complete_on)  next_state = BOGGLE1_COMPLETE;
        else if(boggle1_die_on)  next_state = BOGGLE1_DIE;
        else next_state = current_state;
    end
    
    BOGGLE1_COMPLETE: begin
        if(complete_boggle1==2'b00) next_state = BOGGLE1;
        else if(complete_boggle1==2'b01) next_state = MANU;
        else if(complete_boggle1==2'b10) next_state = BOGGLE2;
        else next_state = current_state;
    end
    
    BOGGLE1_DIE: begin
        if(die_boggle1 == 2'b00) next_state = BOGGLE1;
        else if(die_boggle1 == 2'b01)next_state = MANU;
        else next_state = current_state;
    end
    
     BOGGLE2:begin
        if(boggle2_complete_on) next_state = BOGGLE2_COMPLETE;
        else if(boggle2_die_on) next_state = BOGGLE2_DIE;
        else next_state = current_state;
    end
    
    BOGGLE2_COMPLETE: begin
        if(complete_boggle2 == 2'b00) next_state = BOGGLE2;
        else if(complete_boggle2 == 2'b01) next_state = MANU;
        else if(complete_boggle2 == 2'b10) next_state = SDOKU; 
        else next_state = current_state;
    end
    
    BOGGLE2_DIE: begin
        if(die_boggle2==2'b00) next_state = BOGGLE2;
        else if(die_boggle2==2'b01) next_state = MANU;
        else next_state = current_state;
    end
    
    SDOKU: begin
        if(sdoku_complete_on==2'b01) next_state = SDOKU_COMPLETE;
        else if(sdoku_complete_on==2'b00) next_state = current_state;
        else next_state = current_state;
    end
    
    SDOKU_COMPLETE: begin
        if(complete_sdoku==2'b00) next_state = SDOKU;
        else if(complete_sdoku==2'b01) next_state = MANU;
        else if(complete_sdoku==2'b10) next_state = BOGGLE1;
        else next_state = current_state;
    end
  endcase
end

always@ (posedge clk or posedge rst) begin
    if(rst) current_state <= 0;
    else current_state <= next_state;
end



always@(*) begin
case(current_state)
MANU: begin 
    red = (video_on==1)? {4{rgb_manu[2]}} : 0;
    green= (video_on==1)? {4{rgb_manu[1]}} : 0;
    blue = (video_on==1)? {4{rgb_manu[0]}} : 0;
end

BOGGLE1 : begin
    red = (video_on==1)? {4{rgb_boggle1[2]}} : 0;
    green= (video_on==1)? {4{rgb_boggle1[1]}} : 0;
    blue = (video_on==1)? {4{rgb_boggle1[0]}} : 0;
end

BOGGLE1_COMPLETE: begin
    red = (video_on==1)? {4{rgb_complete_boggle1[2]}} : 0;
    green= (video_on==1)? {4{rgb_complete_boggle1[1]}} : 0;
    blue = (video_on==1)? {4{rgb_complete_boggle1[0]}} : 0;
end

BOGGLE1_DIE : begin
red = (video_on==1)? {4{rgb_die_boggle1[2]}} : 0;
    green= (video_on==1)? {4{rgb_die_boggle1[1]}} : 0;
    blue = (video_on==1)? {4{rgb_die_boggle1[0]}} : 0;
end

BOGGLE2_DIE : begin
    red = (video_on==1)? {4{rgb_die_boggle2[2]}} : 0;
    green= (video_on==1)? {4{rgb_die_boggle2[1]}} : 0;
    blue = (video_on==1)? {4{rgb_die_boggle2[0]}} : 0;    
end
BOGGLE2 : begin
    red = (video_on==1)? {4{rgb_boggle2[2]}} : 0;
    green= (video_on==1)? {4{rgb_boggle2[1]}} : 0;
    blue = (video_on==1)? {4{rgb_boggle2[0]}} : 0;  
end

BOGGLE2_COMPLETE : begin
    red = (video_on==1)? {4{rgb_complete_boggle2[2]}} : 0;
    green= (video_on==1)? {4{rgb_complete_boggle2[1]}} : 0;
    blue = (video_on==1)? {4{rgb_complete_boggle2[0]}} : 0;  
end

SDOKU : begin
    red = (video_on==1)? {4{rgb_sdoku[2]}} : 0;
    green= (video_on==1)? {4{rgb_sdoku[1]}} : 0;
    blue = (video_on==1)? {4{rgb_sdoku[0]}} : 0; 
end

SDOKU_COMPLETE : begin
    red = (video_on==1)? {4{rgb_complete_sdoku[2]}} : 0;
    green= (video_on==1)? {4{rgb_complete_sdoku[1]}} : 0;
    blue = (video_on==1)? {4{rgb_complete_sdoku[0]}} : 0; 
end
endcase
end





endmodule
