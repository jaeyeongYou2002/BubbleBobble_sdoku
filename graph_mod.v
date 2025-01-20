module boggle_graph_mod1 (clk, rst, x, y, key, key_pulse, rgb, complete_on, die_on);
// 화면 크기 설정
parameter MAX_X = 640; 
parameter MAX_Y = 480;  

//wall 의 좌표 설정
parameter WALL_X_L = 32; 
parameter WALL_X_R = 35;

//bar의 x 좌표
parameter BAR_X_L = 600; 
parameter BAR_X_R = 603;

//player의 x축 속도, 가로길이
parameter PLAYER_X_SIZE = 40; 
parameter PLAYER_X = 4; 


//player의 Y축 속도, 세로길이
parameter PLAYER_Y_SIZE = 20; 
parameter PLAYER_Y = 170; 

//ball 속도, ball size 
parameter BALL_SIZE = 8; 
parameter BALL_V = 4; 

// 바닥의 X, Y 좌표 범위
parameter BOTTOM_X_MIN = 19;
parameter BOTTOM_X_MAX = 619;
parameter BOTTOM_Y_MIN = 459;
parameter BOTTOM_Y_MAX = 479;

parameter TOP_X_MIN = 19;
parameter TOP_X_MAX = 619;
parameter TOP_Y_MIN = 0;
parameter TOP_Y_MAX = 19;

parameter RIGHT_X_MIN = 599;
parameter RIGHT_X_MAX = 619;
parameter RIGHT_Y_MIN = 19;
parameter RIGHT_Y_MAX = 479;

parameter LEFT_X_MIN = 19;
parameter LEFT_X_MAX = 39;
parameter LEFT_Y_MIN = 19;
parameter LEFT_Y_MAX = 479;

// 벽의 X, Y 좌표 범위
parameter WALL_1_X_MIN = 129;
parameter WALL_1_X_MAX = 549;
parameter WALL_1_Y_MIN = 359;
parameter WALL_1_Y_MAX = 379;

parameter WALL_2_X_MIN = 129;
parameter WALL_2_X_MAX = 549;
parameter WALL_2_Y_MIN = 259;
parameter WALL_2_Y_MAX = 279;

parameter WALL_3_X_MIN = 129;
parameter WALL_3_X_MAX = 549;
parameter WALL_3_Y_MIN = 159;
parameter WALL_3_Y_MAX = 179;

// 사다리의 X, Y 좌표 범위
parameter ladder_1_H_MIN = 319;
parameter ladder_1_H_MAX = 359;
parameter ladder_1_W_MIN = 399;
parameter ladder_1_W_MAX = 429;

parameter ladder_2_H_MIN = 419;
parameter ladder_2_H_MAX = 459;
parameter ladder_2_W_MIN = 299;
parameter ladder_2_W_MAX = 329;

parameter ladder_3_H_MIN = 219;
parameter ladder_3_H_MAX = 259;
parameter ladder_3_W_MIN = 199;
parameter ladder_3_W_MAX = 229;
   
input clk, rst;
input [9:0] x, y;
input [4:0] key, key_pulse; 
output [2:0] rgb; 
output complete_on, die_on;

reg [10:0] current_y;
reg [10:0] current_x;
reg [10:0] next_y;
reg [10:0] next_x;
wire [10:0] player_y_b;
wire [10:0] player_y_t;
wire [10:0] player_x_l;
wire [10:0] player_x_r;
wire player_left;
wire player_right;
wire player_up;


assign player_y_b = current_y; 
assign player_x_l = current_x;

assign player_x_r = player_x_l + PLAYER_X_SIZE; 
assign player_y_t = player_y_b - PLAYER_Y_SIZE; 

wire plyer_eyes_on_left =  (player_x_l + 10 <= x && x <= player_x_l + 13 && 
 player_y_b - 42 <= y && y <= player_y_b - 38) || (player_x_l + 17 <= x && x <= player_x_l + 20 && 
 player_y_b - 42 <= y && y <= player_y_b - 38);
 
wire plyer_eyes_on_right =  (player_x_l + 20 <= x && x <= player_x_l + 23 && 
 player_y_b - 42 <= y && y <= player_y_b - 38) || (player_x_l + 27 <= x && x <= player_x_l + 30 && 
 player_y_b - 42 <= y && y <= player_y_b - 38);
////////////////////////////캐릭터가 왼쪽 볼때//////////////////////
assign player_left_on = 
//닭벼슬
(player_x_l + 10 <= x && x <= player_x_l + 20 && 
 player_y_b - 50 <= y && y <= player_y_b - 45) ||

// 꼬리1
(player_x_l + 25 <= x && x <= player_x_l + 40 && 
 player_y_b - 7 <= y && y <= player_y_b - 5)

// ||

// 꼬리2
|| (player_x_l + 35 <= x && x <= player_x_l + 40 && 
     player_y_b - 13 <= y && y <= player_y_b - 7)

// ||

// 몸통
|| (player_x_l + 10 <= x && x <= player_x_l + 25 && 
     player_y_b - 15 <= y && y <= player_y_b - 5)

// ||

// 몸통 상단
|| (player_x_l + 10 <= x && x <= player_x_l + 25 && 
     player_y_b - 25 <= y && y <= player_y_b - 15)

// ||

// 머리
|| (player_x_l <= x && x <= player_x_l + 30 && 
     player_y_b - 45 <= y && y <= player_y_b - 35)

// ||

// 눈 (작은 점으로 추가)
|| (player_x_l + 3 <= x && x <= player_x_l + 5 && 
     player_y_b - 42 <= y && y <= player_y_b - 40)

// ||

// 입 중간
|| (player_x_l + 15 <= x && x <= player_x_l + 30 && 
     player_y_b - 35 <= y && y <= player_y_b - 25)

// ||

// 팔1
|| (player_x_l + 5 <= x && x <= player_x_l + 10 && 
     player_y_b - 25 <= y && y <= player_y_b - 22)

// ||

// 팔2
|| (player_x_l + 5 <= x && x <= player_x_l + 10 && 
     player_y_b - 20 <= y && y <= player_y_b - 17)

// ||

// 다리1
|| (player_x_l + 12 <= x && x <= player_x_l + 15 && 
     player_y_b - 5 <= y && y <= player_y_b)

// ||

// 다리2
|| (player_x_l + 20 <= x && x <= player_x_l + 23 && 
     player_y_b - 5 <= y && y <= player_y_b);

////////////////////////////////////////////////////////////////////////

///////////////////////////////캐릭터 오른쪽 볼때////////////////////////////
assign player_right_on = 
//닭벼슬
(player_x_l + 20 <= x && x <= player_x_l + 30 && 
 player_y_b - 50 <= y && y <= player_y_b - 45) ||
 
// 꼬리1
(player_x_l <= x && x <= player_x_l + 15 && 
 player_y_b - 7 <= y && y <= player_y_b - 5)

// ||

// 꼬리2
|| (player_x_l <= x && x <= player_x_l + 5 && 
     player_y_b - 13 <= y && y <= player_y_b - 7)

// ||

// 몸통
|| (player_x_l + 15 <= x && x <= player_x_l + 30 && 
     player_y_b - 15 <= y && y <= player_y_b - 5)

// ||

// 몸통 상단
|| (player_x_l + 15 <= x && x <= player_x_l + 30 && 
     player_y_b - 25 <= y && y <= player_y_b - 15)

// ||

// 머리
|| (player_x_l + 10 <= x && x <= player_x_l + 40 && 
     player_y_b - 45 <= y && y <= player_y_b - 35)

// ||

// 눈 (작은 점으로 추가)
|| (player_x_l + 35 <= x && x <= player_x_l + 37 && 
     player_y_b - 42 <= y && y <= player_y_b - 40)

// ||

// 입 중간
|| (player_x_l + 10 <= x && x <= player_x_l + 25 && 
     player_y_b - 35 <= y && y <= player_y_b - 25)

// ||

// 팔1
|| (player_x_l + 30 <= x && x <= player_x_l + 35 && 
     player_y_b - 25 <= y && y <= player_y_b - 22)

// ||

// 팔2
|| (player_x_l + 30 <= x && x <= player_x_l + 35 && 
     player_y_b - 20 <= y && y <= player_y_b - 17)

// ||

// 다리1
|| (player_x_l + 25 <= x && x <= player_x_l + 28 && 
     player_y_b - 5 <= y && y <= player_y_b)

// ||

// 다리2
|| (player_x_l + 17 <= x && x <= player_x_l + 20 && 
     player_y_b - 5 <= y && y <= player_y_b);

////////////////////////////////////////////////////////////////////////
assign bottom_on = (BOTTOM_X_MIN <= x && BOTTOM_X_MAX >= x && BOTTOM_Y_MIN <= y && BOTTOM_Y_MAX >= y ) ? 1 : 0;
assign top_on = (TOP_X_MIN <= x && TOP_X_MAX >= x && TOP_Y_MIN <= y && TOP_Y_MAX >= y ) ? 1 : 0;
assign right_on = (RIGHT_X_MIN <= x && RIGHT_X_MAX >= x && RIGHT_Y_MIN <= y && RIGHT_Y_MAX >= y ) ? 1 : 0;
assign left_on = (LEFT_X_MIN <= x && LEFT_X_MAX >= x && LEFT_Y_MIN <= y && LEFT_Y_MAX >= y ) ? 1 : 0;

assign wall_1_on =(WALL_1_X_MIN <= x && WALL_1_X_MAX >= x && WALL_1_Y_MIN <= y && WALL_1_Y_MAX >= y);
assign wall_2_on =(WALL_2_X_MIN <= x && WALL_2_X_MAX >= x && WALL_2_Y_MIN <= y && WALL_2_Y_MAX >= y);
assign wall_3_on =(WALL_3_X_MIN <= x && WALL_3_X_MAX >= x && WALL_3_Y_MIN <= y && WALL_3_Y_MAX >= y);
 
assign ladder_1_on = (x== ladder_1_H_MIN && y <= BOTTOM_Y_MIN && y>= WALL_1_Y_MAX) || (x== ladder_1_H_MAX && y <= BOTTOM_Y_MIN && y>= WALL_1_Y_MAX) || 
                    (y==ladder_1_W_MIN && x >=  ladder_1_H_MIN && x <= ladder_1_H_MAX) || (y==ladder_1_W_MAX && x >= ladder_1_H_MIN && x <= ladder_1_H_MAX);
                    
assign ladder_2_on = (x== ladder_2_H_MIN && y <= WALL_1_Y_MIN && y>= WALL_2_Y_MAX) || (x== ladder_2_H_MAX && y <= WALL_1_Y_MIN && y>= WALL_2_Y_MAX) || 
                    (y==ladder_2_W_MIN && x >= ladder_2_H_MIN && x <= ladder_2_H_MAX) || (y==ladder_2_W_MAX && x >= ladder_2_H_MIN && x <= ladder_2_H_MAX);
                    
assign ladder_3_on = (x== ladder_3_H_MIN && y <= WALL_2_Y_MIN && y>= WALL_3_Y_MAX) || (x== ladder_3_H_MAX && y <= WALL_2_Y_MIN && y>= WALL_3_Y_MAX) || 
                    (y==ladder_3_W_MIN && x >= ladder_3_H_MIN && x <= ladder_3_H_MAX) || (y==ladder_3_W_MAX && x >= ladder_3_H_MIN && x <= ladder_3_H_MAX);
                 
assign frame_tick = (y==MAX_Y-1 && x==MAX_X-1)? 1 : 0; 


///////left, right, climbing제어//

reg left,right,climbing;

always@ (posedge clk or posedge rst) begin 
if(rst) left <= 1; //처음에는 왼쪽을 보고 있음
else if(key==5'b10000) left <= 1;
else if(right==1) left <=0;
end

always@ (posedge clk or posedge rst) begin 
if(rst) right <= 0;
else if(key==5'h1f) right <= 1;
else if(left==1) right <=0;
end

always@ (posedge clk or posedge rst) begin 
if(rst) climbing <= 0;
else if(up1 || up2 || up3 || down1 || down2 || down3) climbing <= 1;

end
/////////////////////x좌표 제어/////////////////
always @* begin
    if (rst) next_x <= MAX_X/2;
    else if (frame_tick==1 && key==5'b10000 && player_x_l >=  LEFT_X_MAX + PLAYER_X) next_x = current_x - PLAYER_X;
    else if (frame_tick==1 && key==5'h1f && player_x_r <= RIGHT_X_MIN - PLAYER_X) next_x = current_x + PLAYER_X;
    else next_x = current_x; 
end



always @(posedge clk, posedge rst) begin
    if (rst) current_x <= MAX_X/2;
    else current_x <= next_x; 
end

/////////////////////////////////////y좌표 제어////////////////////////////////


wire clk_out;
clk_divider #(.DIVISOR(160000)) clk_d(clk, rst , clk_out);

//사다리 올라갈때 pulse신호
reg up1, up2, up3;
//사다리 내려갈때 pulse신호
reg down1, down2, down3;
//공중에서 착지시 pulse신호
reg fall;

wire land1 = (current_y == WALL_1_Y_MIN ) ? 1 : 0;
wire land2 = (current_y == WALL_2_Y_MIN ) ? 1 : 0;
wire land3 = (current_y == WALL_3_Y_MIN ) ? 1 : 0;

wire land_down1 = (current_y == BOTTOM_Y_MIN) ? 1 : 0;
wire land_down2 = (current_y == WALL_1_Y_MIN ) ? 1 : 0;
wire land_down3 = (current_y ==WALL_2_Y_MIN ) ? 1 : 0;

wire land_fail = (current_y == BOTTOM_Y_MIN || current_y == WALL_1_Y_MIN || current_y == WALL_2_Y_MIN || current_y == WALL_3_Y_MIN) ? 1 : 0;
//////////////fall 초기화/////////////////////
always@(posedge clk or posedge rst) begin
if(rst) fall <= 0;

else if((current_x + 20 < WALL_1_X_MIN || current_x+20 > WALL_1_X_MAX) && current_y != BOTTOM_Y_MIN) fall <= 1;

else if(land_fail == 1 ) fall <= 0;
end

//////////////down 초기화//////////////////
always@ (posedge clk or posedge rst) begin
if(rst) down1 <= 0;

else if(key_pulse==5'h1e && current_y == WALL_1_Y_MIN && ladder_1_H_MIN <=current_x+20 && ladder_1_H_MAX >=current_x+20) down1 <= 1;

else if(land_down1 == 1) down1 <= 0;
end

always@ (posedge clk or posedge rst) begin
if(rst) down2 <= 0;

else if(key_pulse==5'h1e && current_y == WALL_2_Y_MIN && ladder_2_H_MIN <=current_x+20 && ladder_2_H_MAX >=current_x+20)   down2 <= 1;


else if(land_down2 == 1) down2 <= 0;
end


always@ (posedge clk or posedge rst) begin
if(rst) down3 <= 0;

else if(key_pulse==5'h1e && current_y == WALL_3_Y_MIN && ladder_3_H_MIN <=current_x+20 && ladder_3_H_MAX >=current_x+20)  down3 <= 1;

else if(land_down3 == 1) down3 <= 0;
end

////////////////up 초기화/////////////
always@ (posedge clk or posedge rst) begin
if(rst) up1 <= 0;

else if(key_pulse==5'h1e && current_y == BOTTOM_Y_MIN && ladder_1_H_MIN <=current_x+20 && ladder_1_H_MAX >=current_x+20) up1 <= 1;

else if(land1 == 1) up1 <= 0;
end

always@ (posedge clk or posedge rst) begin
if(rst) up2 <= 0;

else if(key_pulse==5'h1e && current_y == WALL_1_Y_MIN && ladder_2_H_MIN <=current_x+20 && ladder_2_H_MAX >=current_x+20) up2 <= 1;

else if(land2 == 1) up2 <= 0;
end

always@ (posedge clk or posedge rst) begin
if(rst) up3 <= 0;

else if(key_pulse==5'h1e && current_y == WALL_2_Y_MIN && ladder_3_H_MIN <=current_x+20 && ladder_3_H_MAX >=current_x+20) up3 <= 1;

else if(land3 == 1) up3 <= 0;
end

//////////////current_y up/down카운터//////////////////

always@(posedge clk_out or posedge rst) begin
    if(rst) current_y <= 459;
    else if(up1 || up2 || up3) begin
        if(current_y == 0) current_y <= 479;
        else current_y <= current_y-1; 
    end
   else if(down1 || down2 || down3 || fall) begin
        if(current_y == 479) current_y <= 0;
        else current_y <= current_y+1;     
   end
end


///////////////////////랜덤 악당 형성/////////////////////////////////////

///////////////////악당의 시작 신호 생성//////////////////////////
reg bed_start;

always@(posedge clk or posedge rst) begin
    if(rst) bed_start <= 0;
    else if(key_pulse == 5'b10000 || key_pulse == 5'h1f) bed_start <= 1;
end

////////////////악당 1 생성////////////
reg [10:0] current_bed_x1;
reg [10:0] next_bed_x1;
reg [10:0] next_bed_x1_vx;
reg [10:0] current_bed_x1_vx;

reg [10:0] current_bed_y1;

wire [10:0] bed_x_l1;
wire [10:0] bed_y_b1;
wire [10:0] bed_x_r1;
wire [10:0] bed_y_t1;
reg bed_left1, bed_right1;

reg in_bubble1;

assign bed_x_l1 = current_bed_x1;
assign bed_y_b1 = current_bed_y1;

assign bed_x_r1 = bed_x_l1 + 30;
assign  bed_y_t1 = bed_y_b1 - 30;


wire  bed_on1_left = (in_bubble1==0) && ((bed_x_l1 <= x && x <= bed_x_l1 + 30 && bed_y_b1-13 <= y && y <= bed_y_b1) ||
                 (bed_x_l1 + 20 <= x && x <= bed_x_l1 + 30 && bed_y_b1-17 <= y && y <= bed_y_b1-13) ||
                  (bed_x_l1 <= x && x <= bed_x_l1 + 30 && bed_y_b1-30 <= y && y <= bed_y_b1-17)) ? 1 : 0;
                  
                  
wire  bed_on1_right = (in_bubble1==0) && ((bed_x_l1 <= x && x <= bed_x_l1 + 30 && bed_y_b1-13 <= y && y <= bed_y_b1) ||
                 (bed_x_l1 <= x && x <= bed_x_l1 + 10 && bed_y_b1-17 <= y && y <= bed_y_b1-13) ||
                  (bed_x_l1 <= x && x <= bed_x_l1 + 30 && bed_y_b1-30 <= y && y <= bed_y_b1-17)) ? 1 : 0;

wire bed_eyes_on_left1 = (in_bubble1==0) && ((bed_x_l1+5 <= x && x<= bed_x_l1+8 && bed_y_b1-25 <= y && y <= bed_y_b1-22) || 
                                    (bed_x_l1+12 <= x && x<= bed_x_l1+15 && bed_y_b1-25 <= y && y <= bed_y_b1-22)); 
                                                     
wire bed_eyes_on_right1 = (in_bubble1==0) && ((bed_x_l1+15 <= x && x<= bed_x_l1+18 && bed_y_b1-25 <= y && y <= bed_y_b1-22) || 
                                    (bed_x_l1+22 <= x && x<= bed_x_l1+25 && bed_y_b1-25 <= y && y <= bed_y_b1-22)); 
                  
                  
                  
////////////////in_bubble제어//////////////////////
always@(posedge clk or posedge rst) begin
    if(rst) in_bubble1 <= 0;
    ////////////그냥 넣기///////////////////////////////////////
    else if((bubble1_bed1_left== 1 || bubble1_bed1_right ==1 || bubble2_bed1_left== 1 || bubble2_bed1_right == 1
           || bubble3_bed1_left== 1 || bubble3_bed1_right ==1 || bubble4_bed1_left== 1 || bubble4_bed1_right ==1 || 
           bubble5_bed1_left== 1 || bubble5_bed1_right ==1 )&& current_y == WALL_2_Y_MIN) in_bubble1 <= 1;
end


////////////////bed_left, bed_right 제어///////////////                  
always@(posedge clk or posedge rst) begin
    if(rst) bed_left1 <= 1;
    else if(bed1_reach_right) bed_left1 <= 1;
    else if(bed1_reach_left)  bed_left1 <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) bed_right1 <= 0;
    else if(bed1_reach_left) bed_right1 <= 1;
    else if(bed1_reach_right)  bed_right1 <= 0;
end                 

////////////////bed1 y제어 - current_bed_y1///////////////////
 always@(posedge clk_out or posedge rst) begin
    if(rst) current_bed_y1<=TOP_Y_MAX+30;
    
    /////////////////괄호 유의///////////////////////////
    else if(bed_start && ((bubble1_bed1_left==0 &&   bubble1_bed1_right==0) && (bubble2_bed1_left==0 && bubble2_bed1_right==0) && 
    (bubble3_bed1_left==0 &&   bubble3_bed1_right==0) && (bubble4_bed1_left==0 &&   bubble4_bed1_right==0) && (bubble5_bed1_left==0 &&   bubble5_bed1_right==0))) begin
    if(current_bed_y1<WALL_3_Y_MIN) current_bed_y1 <= current_bed_y1 + 1;
    end
    //////그냥 넣기/////////
    else if(bubble2_bed1_left || bubble2_bed1_right || bubble1_bed1_left || bubble1_bed1_right
    || bubble3_bed1_left || bubble3_bed1_right || bubble4_bed1_left || bubble4_bed1_right|| bubble5_bed1_left || bubble5_bed1_right) current_bed_y1 <= 550; 
 end
 
////////////////bed1 x제어 - current_bed_x1///////////////////
wire bed1_reach_right = (bed_x_r1 >= WALL_3_X_MAX) ? 1 : 0;
wire bed1_reach_left = (bed_x_l1 <= WALL_3_X_MIN) ? 1 : 0;


//다음 변위 결정

always@* begin 
    if(rst) next_bed_x1_vx = -2;
    else if(bed1_reach_right) next_bed_x1_vx = -2;
    else if(bed1_reach_left) next_bed_x1_vx = 2;
    else next_bed_x1_vx = current_bed_x1_vx;
end

always@(posedge clk or posedge rst) begin
if(rst) current_bed_x1_vx <= -2;
else current_bed_x1_vx <= next_bed_x1_vx;
end

always@* begin
    if(rst) next_bed_x1 = MAX_X/2;
    else if(frame_tick) next_bed_x1 = current_bed_x1 + current_bed_x1_vx;
    else next_bed_x1 = current_bed_x1;
end

always@(posedge clk or posedge rst) begin
 if(rst) current_bed_x1<= MAX_X/2;
 else current_bed_x1 <= next_bed_x1;
end


/////////////////////////악당2생성////////////////////////////////////////
reg [10:0] current_bed_x2;
reg [10:0] next_bed_x2;
reg [10:0] next_bed_x2_vx;
reg [10:0] current_bed_x2_vx;

reg [10:0] current_bed_y2;

wire [10:0] bed_x_l2;
wire [10:0] bed_y_b2;
wire [10:0] bed_x_r2;
wire [10:0] bed_y_t2;
reg bed_left2, bed_right2;

reg in_bubble2;

assign bed_x_l2 = current_bed_x2;
assign bed_y_b2 = current_bed_y2;

assign bed_x_r2 = bed_x_l2 + 30;
assign bed_y_t2 = bed_y_b2 - 30;

wire bed_on2_left = (in_bubble2 == 0) && ((bed_x_l2 <= x && x <= bed_x_l2 + 30 && bed_y_b2 - 13 <= y && y <= bed_y_b2) ||
                 (bed_x_l2 + 20 <= x && x <= bed_x_l2 + 30 && bed_y_b2 - 17 <= y && y <= bed_y_b2 - 13) ||
                 (bed_x_l2 <= x && x <= bed_x_l2 + 30 && bed_y_b2 - 30 <= y && y <= bed_y_b2 - 17)) ? 1 : 0;

wire bed_on2_right = (in_bubble2 == 0) && ((bed_x_l2 <= x && x <= bed_x_l2 + 30 && bed_y_b2 - 13 <= y && y <= bed_y_b2) ||
                 (bed_x_l2 <= x && x <= bed_x_l2 + 10 && bed_y_b2 - 17 <= y && y <= bed_y_b2 - 13) ||
                 (bed_x_l2 <= x && x <= bed_x_l2 + 30 && bed_y_b2 - 30 <= y && y <= bed_y_b2 - 17)) ? 1 : 0;

wire bed_eyes_on_left2 = (in_bubble2 == 0) && ((bed_x_l2 + 5 <= x && x <= bed_x_l2 + 8 && bed_y_b2 - 25 <= y && y <= bed_y_b2 - 22) || 
                                    (bed_x_l2 + 12 <= x && x <= bed_x_l2 + 15 && bed_y_b2 - 25 <= y && y <= bed_y_b2 - 22)); 
                                                     
wire bed_eyes_on_right2 = (in_bubble2 == 0) && ((bed_x_l2 + 15 <= x && x <= bed_x_l2 + 18 && bed_y_b2 - 25 <= y && y <= bed_y_b2 - 22) || 
                                    (bed_x_l2 + 22 <= x && x <= bed_x_l2 + 25 && bed_y_b2 - 25 <= y && y <= bed_y_b2 - 22)); 
                  
////////////////in_bubble제어//////////////////////
always@(posedge clk or posedge rst) begin
    if(rst) in_bubble2 <= 0;
    else if((bubble1_bed2_left == 1 || bubble1_bed2_right == 1 || bubble2_bed2_left == 1 || bubble2_bed2_right == 1
    || bubble3_bed2_left == 1 || bubble3_bed2_right == 1|| bubble4_bed2_left == 1 || bubble4_bed2_right == 1 || bubble5_bed2_left == 1 || bubble5_bed2_right == 1) 
    &&  (current_y == WALL_2_Y_MIN)) in_bubble2 <= 1;
end

////////////////bed_left, bed_right 제어///////////////                  
always@(posedge clk or posedge rst) begin
    if(rst) bed_left2 <= 0;
    else if(bed2_reach_right) bed_left2 <= 1;
    else if(bed2_reach_left)  bed_left2 <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) bed_right2 <= 1;
    else if(bed2_reach_left) bed_right2 <= 1;
    else if(bed2_reach_right)  bed_right2 <= 0;
end                 

////////////////bed2 y제어 - current_bed_y2///////////////////
 always@(posedge clk_out or posedge rst) begin
    if(rst) current_bed_y2 <= TOP_Y_MAX + 30;
    
    //////////괄호 유의//////////////////////////
    else if(bed_start && (bubble1_bed2_left == 0 && bubble1_bed2_right == 0 && bubble2_bed2_left == 0 && bubble2_bed2_right == 0 && 
    bubble3_bed2_left == 0 && bubble3_bed2_right == 0 && bubble4_bed2_left == 0 && bubble4_bed2_right == 0 && bubble5_bed2_left == 0 && bubble5_bed2_right == 0)) begin
    
    if(current_bed_y2 < WALL_2_Y_MIN) current_bed_y2 <= current_bed_y2 + 1;
    end
    ///////////그냥 넣기///////////////////
    else if(bubble1_bed2_left || bubble1_bed2_right || bubble2_bed2_left || bubble2_bed2_right || 
    bubble3_bed2_left || bubble3_bed2_right || bubble4_bed2_left || bubble4_bed2_right|| bubble5_bed2_left || bubble5_bed2_right) current_bed_y2 <= 550; 
 end
 
////////////////bed2 x제어 - current_bed_x2///////////////////
wire bed2_reach_right = (bed_x_r2 >= WALL_3_X_MAX) ? 1 : 0;
wire bed2_reach_left = (bed_x_l2 <= WALL_3_X_MIN) ? 1 : 0;

//다음 변위 결정
always@* begin 
    if(rst) next_bed_x2_vx = 1;
    else if(bed2_reach_right) next_bed_x2_vx = -1;
    else if(bed2_reach_left) next_bed_x2_vx = 1;
    else next_bed_x2_vx = current_bed_x2_vx;
end

always@(posedge clk or posedge rst) begin
if(rst) current_bed_x2_vx <= 1;
else current_bed_x2_vx <= next_bed_x2_vx;
end

always@* begin
    if(rst) next_bed_x2 = MAX_X / 2 + 30;
    else if(frame_tick) next_bed_x2 = current_bed_x2 + current_bed_x2_vx;
    else next_bed_x2 = current_bed_x2;
end

always@(posedge clk or posedge rst) begin
 if(rst) current_bed_x2 <= MAX_X / 2;
 else current_bed_x2 <= next_bed_x2;
end
////////////////////////////악당3 생성////////////////////////////////////////
reg [10:0] current_bed_x3;
reg [10:0] next_bed_x3;
reg [10:0] next_bed_x3_vx;
reg [10:0] current_bed_x3_vx;

reg [10:0] current_bed_y3;

wire [10:0] bed_x_l3;
wire [10:0] bed_y_b3;
wire [10:0] bed_x_r3;
wire [10:0] bed_y_t3;
reg bed_left3, bed_right3;

reg in_bubble3;

assign bed_x_l3 = current_bed_x3;
assign bed_y_b3 = current_bed_y3;

assign bed_x_r3 = bed_x_l3 + 30;
assign  bed_y_t3 = bed_y_b3 - 30;


wire  bed_on3_left = (in_bubble3==0) && ((bed_x_l3 <= x && x <= bed_x_l3 + 30 && bed_y_b3-13 <= y && y <= bed_y_b3) ||
                 (bed_x_l3 + 20 <= x && x <= bed_x_l3 + 30 && bed_y_b3-17 <= y && y <= bed_y_b3-13) ||
                  (bed_x_l3 <= x && x <= bed_x_l3 + 30 && bed_y_b3-30 <= y && y <= bed_y_b3-17)) ? 1 : 0;
                  
                  
wire  bed_on3_right = (in_bubble3==0) && ((bed_x_l3 <= x && x <= bed_x_l3 + 30 && bed_y_b3-13 <= y && y <= bed_y_b3) ||
                 (bed_x_l3 <= x && x <= bed_x_l3 + 10 && bed_y_b3-17 <= y && y <= bed_y_b3-13) ||
                  (bed_x_l3 <= x && x <= bed_x_l3 + 30 && bed_y_b3-30 <= y && y <= bed_y_b3-17)) ? 1 : 0;

wire bed_eyes_on_left3 = (in_bubble3==0) && ((bed_x_l3+5 <= x && x<= bed_x_l3+8 && bed_y_b3-25 <= y && y <= bed_y_b3-22) || 
                                    (bed_x_l3+12 <= x && x<= bed_x_l3+15 && bed_y_b3-25 <= y && y <= bed_y_b3-22)); 
                                                     
wire bed_eyes_on_right3 = (in_bubble3==0) && ((bed_x_l3+15 <= x && x<= bed_x_l3+18 && bed_y_b3-25 <= y && y <= bed_y_b3-22) || 
                                    (bed_x_l3+22 <= x && x<= bed_x_l3+25 && bed_y_b3-25 <= y && y <= bed_y_b3-22)); 
                  
                  
                  

always@(posedge clk or posedge rst) begin
    if(rst) in_bubble3 <= 0;
    else if(bubble1_bed3_left== 1 || bubble1_bed3_right ==1 || bubble2_bed3_left== 1 || bubble2_bed3_right == 1
           || bubble3_bed3_left== 1 || bubble3_bed3_right ==1 || bubble4_bed3_left== 1 || bubble4_bed3_right ==1 || 
           bubble5_bed3_left== 1 || bubble5_bed3_right ==1) in_bubble3 <= 1;
end

                  
always@(posedge clk or posedge rst) begin
    if(rst) bed_left3 <= 1;
    else if(bed3_reach_right) bed_left3 <= 1;
    else if(bed3_reach_left)  bed_left3 <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) bed_right3 <= 0;
    else if(bed3_reach_left) bed_right3 <= 1;
    else if(bed3_reach_right)  bed_right3 <= 0;
end                 


 always@(posedge clk_out or posedge rst) begin
    if(rst) current_bed_y3<=TOP_Y_MAX+30;
    
    else if(bed_start && (bubble1_bed3_left == 0 && bubble1_bed3_right == 0 && bubble2_bed3_left == 0 && bubble2_bed3_right == 0 && 
    bubble3_bed3_left == 0 && bubble3_bed3_right == 0 && bubble4_bed3_left == 0 && bubble4_bed3_right == 0 && bubble5_bed3_left == 0 && bubble5_bed3_right == 0)) begin
    if(current_bed_y3<WALL_1_Y_MIN) current_bed_y3 <= current_bed_y3 + 1;
    end
    
    else if(bubble1_bed3_left== 1 || bubble1_bed3_right ==1 || bubble2_bed3_left== 1 || bubble2_bed3_right == 1
           || bubble3_bed3_left== 1 || bubble3_bed3_right ==1 || bubble4_bed3_left== 1 || bubble4_bed3_right ==1 || 
           bubble5_bed3_left== 1 || bubble5_bed3_right ==1) current_bed_y3 <= 550; 
 end
 

wire bed3_reach_right = (bed_x_r3 >= WALL_3_X_MAX) ? 1 : 0;
wire bed3_reach_left = (bed_x_l3 <= WALL_3_X_MIN) ? 1 : 0;


//다음 변위 결정

always@* begin 
    if(rst) next_bed_x3_vx = 2;
    else if(bed3_reach_right) next_bed_x3_vx = -2;
    else if(bed3_reach_left) next_bed_x3_vx = 2;
    else next_bed_x3_vx = current_bed_x3_vx;
end

always@(posedge clk or posedge rst) begin
if(rst) current_bed_x3_vx <= 2;
else current_bed_x3_vx <= next_bed_x3_vx;
end

always@* begin
    if(rst) next_bed_x3 = MAX_X/2 + 60;
    else if(frame_tick) next_bed_x3 = current_bed_x3 + current_bed_x3_vx;
    else next_bed_x3 = current_bed_x3;
end

always@(posedge clk or posedge rst) begin
 if(rst) current_bed_x3<= MAX_X/2 + 60;
 else current_bed_x3 <= next_bed_x3;
end


//////////////////////공격제어 - bubble//////////////////////////////////////////

localparam integer BUBBLE_RADIUS_X = 25; // 가로 반지름
localparam integer BUBBLE_RADIUS_Y = 30; // 세로 반지름
parameter BUBBLE_SIZE = 20;
parameter BULLE_V = 2;


wire [10:0] bubble_x_l;
wire [10:0] bubble_x_r;
wire [10:0] bubble_y_t;
wire [10:0] bubble_y_b;
reg [3:0] bubble_count;
reg bubble_cor1;
reg bubble_cor2;
reg bubble_cor3;

always@(posedge clk or posedge rst) begin 
    if(rst) bubble_count <= 0;
    else if(key_pulse == 5'h1d) begin
        if(bubble_count == 10) bubble_count <= 0;
        else bubble_count <= bubble_count + 1;
    end
end

always@(*) begin
    if(rst) bubble_cor1 = 0;
    else if(bubble_count == 1 || bubble_count == 4 || bubble_count == 7 || bubble_count == 10) bubble_cor1 = 1;
    else bubble_cor1 = 0;
end


always@(*) begin
    if(rst) bubble_cor2 = 0;
    else if(bubble_count == 2 || bubble_count == 5 || bubble_count == 8) bubble_cor2 = 1;
    else bubble_cor2 = 0;
end


always@(*) begin
    if(rst) bubble_cor3 = 0;
    else if(bubble_count == 3 || bubble_count == 6 || bubble_count == 9) bubble_cor3 = 1;
    else bubble_cor3 = 0;
end

///////////////////////////공격1/////////////////
wire [10:0] bubble_x_l1;
wire [10:0] bubble_x_r1;
wire [10:0] bubble_y_t1;
wire [10:0] bubble_y_b1;

reg [10:0] current_bubble_x1;
reg [10:0] current_bubble_y1;
reg [10:0] next_bubble_x1;
reg [10:0] next_bubble_y1;

reg [10:0] current_bubble_vx1;
reg [10:0] current_bubble_vy1;
reg [10:0] next_bubble_vx1;
reg [10:0] next_bubble_vy1;
reg [6:0] bubble_speed1;
wire [10:0] bubble_left1;
wire [10:0] bubble_right1;
wire [10:0] bubble_top1;
wire [10:0] bubble_bottom1;
reg speed_en1;
reg bubble_on1;


assign bubble_x_l1 = current_bubble_x1;
assign bubble_y_b1 = current_bubble_y1;

assign bubble_left1 = bubble_cx1 - BUBBLE_RADIUS_X;
assign bubble_right1 = bubble_cx1 + BUBBLE_RADIUS_X;
assign bubble_top1 = bubble_cy1 - BUBBLE_RADIUS_Y;
assign bubble_bottom1 = bubble_cy1 + BUBBLE_RADIUS_Y;
  

    // 타원의 중심 좌표 및 반지름
wire [9:0] bubble_cx1 = bubble_x_l1 + BUBBLE_RADIUS_X; // 중심 x좌표 (왼쪽 아래 기준으로 +24)
wire [9:0] bubble_cy1 = bubble_y_b1 - BUBBLE_RADIUS_Y; // 중심 y좌표 (왼쪽 아래 기준으로 -16)
    
localparam integer BUBBLE_RADIUS_X_SQ = BUBBLE_RADIUS_X * BUBBLE_RADIUS_X; // X반지름의 제곱
localparam integer BUBBLE_RADIUS_Y_SQ = BUBBLE_RADIUS_Y * BUBBLE_RADIUS_Y; // Y반지름의 제곱
/////////////////////////왼쪽, 오른쪽 1차 충돌시 reg////////////////////
reg bubble1_bed1_left_reg;
reg bubble1_bed1_right_reg;

always@(posedge rst or posedge clk) begin
    if(rst) bubble1_bed1_left_reg<=0;
    else if(bubble1_bed1_left) bubble1_bed1_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble1_bed1_right_reg<=0;
    else if(bubble1_bed1_right) bubble1_bed1_right_reg<=1;
end

reg bubble1_bed2_left_reg;
reg bubble1_bed2_right_reg;

always@(posedge rst or posedge clk) begin
    if(rst) bubble1_bed2_left_reg<=0;
    else if(bubble1_bed2_left) bubble1_bed2_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble1_bed2_right_reg<=0;
    else if(bubble1_bed2_right) bubble1_bed2_right_reg<=1;
end



reg bubble1_bed3_left_reg;
reg bubble1_bed3_right_reg;

always@(posedge rst or posedge clk) begin
    if(rst) bubble1_bed3_left_reg<=0;
    else if(bubble1_bed3_left) bubble1_bed3_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble1_bed3_right_reg<=0;
    else if(bubble1_bed3_right) bubble1_bed3_right_reg<=1;
end

    always @(*) begin
        // 타원의 방정식: ((x - cx)^2 / A^2) + ((y - cy)^2 / B^2) <= 1
        if ((((x - bubble_cx1) * (x - bubble_cx1) * BUBBLE_RADIUS_Y_SQ) + 
            ((y - bubble_cy1) * (y - bubble_cy1) * BUBBLE_RADIUS_X_SQ) <= 
            BUBBLE_RADIUS_X_SQ * BUBBLE_RADIUS_Y_SQ) && (bubble1_bed1_left_reg==0 && bubble1_bed1_right_reg==0 && bubble1_bed2_left_reg==0 && bubble1_bed2_right_reg==0
            && bubble1_bed3_left_reg==0 && bubble1_bed3_right_reg==0))
            
            bubble_on1 = 1; 
            
        else
            bubble_on1 = 0; 
    end


assign bubble_reach_left1 = (bubble_left1 <= LEFT_X_MAX) ? 1 : 0;
assign bubble_reach_right1 = (bubble_right1 >= RIGHT_X_MIN && bubble_right1 <= 640) ? 1 : 0;
assign bubble_reach_top1 = (bubble_top1 <= TOP_Y_MAX) ? 1 : 0;

    
//assign bubble_reach_left1 = (bubble_x_l1 <= LEFT_X_MAX) ? 1 : 0;
//assign bubble_reach_right1 = (bubble_x_r1 >= RIGHT_X_MIN && bubble_x_r1 <= 640) ? 1 : 0;
//assign bubble_reach_top1 = (bubble_y_t1 <= TOP_Y_MAX) ? 1 : 0;

assign bubble_move1 = (key_pulse == 5'h1d && bubble_count == 0);


////////////////////speed_en1제어/////////////////////
always@(posedge clk or posedge rst) begin
if(rst) speed_en1 <= 0;
else if(bubble_move1==1) speed_en1<=1; 
else if(bubble_speed1 == 100) speed_en1<=0;
end 
////////////////////speed counter1제어//////////////




always@(posedge clk or posedge rst) begin
    if(rst) bubble_speed1<=0;
    else if(speed_en1) begin
        if(bubble_speed1== 100) bubble_speed1 <= 0;
        else bubble_speed1 <= bubble_speed1 + 1;
    end
end

////////////////////////////변위 제어 vy, vx////////////////////////


always @* begin
    if (rst) next_bubble_vy1 = 0; 
    
    else if ((!bubble_reach_top1 && bubble_reach_left1 == 1) || (!bubble_reach_top1 && bubble1_back1_left) 
    || (!bubble_reach_top1&&bubble1_back2_left) || (!bubble_reach_top1 && bubble1_back3_left)) next_bubble_vy1 = -1 * BULLE_V;
    
    else if (!bubble_reach_top1 && bubble_reach_right1 == 1  || (!bubble_reach_top1&&bubble1_back1_right)
    || (!bubble_reach_top1&&bubble1_back3_right) || (!bubble_reach_top1&&bubble1_back3_right)) next_bubble_vy1 = -1 * BULLE_V;
    
    else if(bubble_reach_top1 == 1) next_bubble_vy1 = 0;
    else next_bubble_vy1 = current_bubble_vy1; 
end

always@(posedge clk or posedge rst) begin
    if(rst) 
        next_bubble_vx1 <= 0;
    else begin
        if(key_pulse == 5'h1d && bubble_count == 0)  begin
            if(left == 1) next_bubble_vx1 <= -1 * BULLE_V;
            else if(right == 1) next_bubble_vx1 <= 1 * BULLE_V; 
        end
        
        else if(speed_en1 && bubble_move1==0) begin
            if(left == 1) next_bubble_vx1 <= -3 * BULLE_V;
            else if(right == 1) next_bubble_vx1 <= 3 * BULLE_V; 
        end
        
        else if(bubble_reach_top1 && bubble_reach_left1 == 1) 
            next_bubble_vx1 <= BULLE_V;
            
        else if(bubble_reach_top1 && bubble_reach_right1 == 1) 
            next_bubble_vx1 <= -BULLE_V;
            
        else if((!bubble_reach_top1 && bubble_reach_left1 == 1) || (!bubble_reach_top1 && bubble_reach_right1 == 1) 
        || (!bubble_reach_top1 && bubble1_back1_left == 1) ||  (!bubble_reach_top1 && bubble1_back1_right == 1)||
         (!bubble_reach_top1 && bubble1_back2_left == 1) ||  (!bubble_reach_top1 && bubble1_back2_right == 1) ||
         (!bubble_reach_top1 && bubble1_back3_left == 1) ||  (!bubble_reach_top1 && bubble1_back3_right == 1) )
            next_bubble_vx1 <= 0;    
            
        else if(bubble1_backn_reg && bubble_reach_top1)   
        next_bubble_vx1 <= 1 * BULLE_V;    
    end
end
reg bubble1_backn_reg;
always@(posedge clk or posedge rst) begin
    if(rst) bubble1_backn_reg <= 0;
    else if(bubble1_back1_left || bubble1_back1_right || bubble1_back2_left || bubble1_back2_right || bubble1_back3_left || bubble1_back3_right) begin
        bubble1_backn_reg <= 1;
    end
    else if(bubble_reach_right1)
        bubble1_backn_reg <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) begin 
        current_bubble_vx1 <= 0; 
        current_bubble_vy1 <= 0;                
    end
    else begin
        current_bubble_vx1 <= next_bubble_vx1;
        current_bubble_vy1 <= next_bubble_vy1; 
    end
end

////////////////////////////위치 제어 x,y////////////////////////////////

always @(posedge clk or posedge rst) begin
    if (rst) begin 
        current_bubble_x1 <= 650;
        current_bubble_y1 <= 550; 
    end
    else if(bubble_move1 && !frame_tick) begin
        if(left) begin 
            current_bubble_x1 <= current_x - 40; 
            current_bubble_y1 <= current_y; 
        end
        else if(right) begin
            current_bubble_x1 <= current_x + 40; 
            current_bubble_y1 <= current_y; 
        end
        /////////////////얘는 그대로 두기///////////////////
        else if(bubble1_bed1_left || bubble1_bed1_right || bubble1_bed2_left || bubble1_bed2_right || bubble1_bed3_left || bubble1_bed3_right) begin
            current_bubble_x1 <= 650;
            current_bubble_y1 <= 550;
        end
    end
    else if (frame_tick) begin
        current_bubble_x1 <= current_bubble_x1 + current_bubble_vx1;
        current_bubble_y1 <= current_bubble_y1 + current_bubble_vy1; 
    end
end

///////////////////////////////////공격2//////////////////////////////////////
wire [10:0] bubble_x_l2;
wire [10:0] bubble_x_r2;
wire [10:0] bubble_y_t2;
wire [10:0] bubble_y_b2;

reg [10:0] current_bubble_x2;
reg [10:0] current_bubble_y2;
reg [10:0] next_bubble_x2;
reg [10:0] next_bubble_y2;

reg [10:0] current_bubble_vx2;
reg [10:0] current_bubble_vy2;
reg [10:0] next_bubble_vx2;
reg [10:0] next_bubble_vy2;
reg [6:0] bubble_speed2;
wire [10:0] bubble_left2;
wire [10:0] bubble_right2;
wire [10:0] bubble_top2;
wire [10:0] bubble_bottom2;
reg speed_en2;
reg bubble_on2;


assign bubble_x_l2 = current_bubble_x2;
assign bubble_y_b2 = current_bubble_y2;

assign bubble_left2 = bubble_cx2 - BUBBLE_RADIUS_X;
assign bubble_right2 = bubble_cx2 + BUBBLE_RADIUS_X;
assign bubble_top2 = bubble_cy2 - BUBBLE_RADIUS_Y;
assign bubble_bottom2 = bubble_cy2 + BUBBLE_RADIUS_Y;
  
  
 ///////////////////////왼쪽, 오른쪽 1차 충돌시의 reg/////////////////////
reg bubble2_bed1_left_reg; //////////공격2의 영역
reg bubble2_bed1_right_reg;
  
  always@(posedge rst or posedge clk) begin
    if(rst) bubble2_bed1_left_reg<=0;
    else if(bubble2_bed1_left) bubble2_bed1_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble2_bed1_right_reg<=0;
    else if(bubble2_bed1_right) bubble2_bed1_right_reg<=1;
end

reg bubble2_bed2_left_reg; //////////공격2의 영역
reg bubble2_bed2_right_reg;
  
  always@(posedge rst or posedge clk) begin
    if(rst) bubble2_bed2_left_reg<=0;
    else if(bubble2_bed2_left) bubble2_bed2_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble2_bed2_right_reg<=0;
    else if(bubble2_bed2_right) bubble2_bed2_right_reg<=1;
end  

reg bubble2_bed3_left_reg;
reg bubble2_bed3_right_reg;

always@(posedge rst or posedge clk) begin
    if(rst) bubble2_bed3_left_reg<=0;
    else if(bubble2_bed3_left) bubble2_bed3_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble2_bed3_right_reg<=0;
    else if(bubble2_bed3_right) bubble2_bed3_right_reg<=1;
end

    // 타원의 중심 좌표 멤 단지르미
wire [9:0] bubble_cx2 = bubble_x_l2 + BUBBLE_RADIUS_X; // 중심 x좌표 (왼쪽 아래 기준으로 +24)
wire [9:0] bubble_cy2 = bubble_y_b2 - BUBBLE_RADIUS_Y; // 중심 y좌표 (왼쪽 아래 기준으로 -16)
    

    always @(*) begin
        // 타원의 방정식: ((x - cx)^2 / A^2) + ((y - cy)^2 / B^2) <= 1
        if ((((x - bubble_cx2) * (x - bubble_cx2) * BUBBLE_RADIUS_Y_SQ) + 
            ((y - bubble_cy2) * (y - bubble_cy2) * BUBBLE_RADIUS_X_SQ) <= 
            BUBBLE_RADIUS_X_SQ * BUBBLE_RADIUS_Y_SQ) && (bubble2_bed1_left_reg==0 && bubble2_bed1_right_reg==0 && bubble2_bed2_left_reg==0 && bubble2_bed2_right_reg==0
            && bubble2_bed3_left_reg==0 && bubble2_bed3_right_reg==0))
            
            bubble_on2 = 1; 
            
        else
            bubble_on2 = 0; 
    end


assign bubble_reach_left2 = (bubble_left2 <= LEFT_X_MAX) ? 1 : 0;
assign bubble_reach_right2 = (bubble_right2 >= RIGHT_X_MIN && bubble_right2 <= 640) ? 1 : 0;
assign bubble_reach_top2 = (bubble_top2 <= TOP_Y_MAX) ? 1 : 0;

    
assign bubble_move2 = (key_pulse == 5'h1d && bubble_count == 1);


////////////////////speed_en2제어/////////////////////
always@(posedge clk or posedge rst) begin
if(rst) speed_en2 <= 0;
else if(bubble_move2==1) speed_en2<=1; 
else if(bubble_speed2 == 100) speed_en2<=0;
end 
////////////////////speed counter2제어//////////////




always@(posedge clk or posedge rst) begin
    if(rst) bubble_speed2<=0;
    else if(speed_en2) begin
        if(bubble_speed2==100) bubble_speed2 <= 0;
        else bubble_speed2 <= bubble_speed2 + 1;
    end
end

////////////////////////////변위 제어 vy, vx////////////////////////


always @* begin
    if (rst) next_bubble_vy2 = 0; 
    else if ((!bubble_reach_top2 && bubble_reach_left2 == 1) || (!bubble_reach_top2 && bubble2_back1_left)
    || (!bubble_reach_top2 && bubble2_back3_left) || (!bubble_reach_top2 && bubble2_back3_left)) next_bubble_vy2 = -1 * BULLE_V;
    
    else if ((!bubble_reach_top2 && bubble_reach_right2 == 1)  || (!bubble_reach_top2 && bubble2_back1_right)
    || (!bubble_reach_top2 && bubble2_back2_right) || (!bubble_reach_top2 && bubble2_back3_right)) next_bubble_vy2 = -1 * BULLE_V;
    
    else if(bubble_reach_top2 == 1) next_bubble_vy2 = 0;
    else next_bubble_vy2 = current_bubble_vy2; 
end

always@(posedge clk or posedge rst) begin
    if(rst) 
        next_bubble_vx2 <= 0;
    else begin
        if(key_pulse == 5'h1d && bubble_count == 1)  begin
            if(left == 1) next_bubble_vx2 <= -1 * BULLE_V;
            else if(right == 1) next_bubble_vx2 <= 1 * BULLE_V; 
        end
        
        else if(speed_en2 && bubble_move2==0) begin
            if(left == 1) next_bubble_vx2 <= -3 * BULLE_V;
            else if(right == 1) next_bubble_vx2 <= 3 * BULLE_V; 
        end
        
        else if(bubble_reach_top2 && bubble_reach_left2 == 1) 
            next_bubble_vx2 <= BULLE_V;
        else if(bubble_reach_top2 && bubble_reach_right2 == 1) 
            next_bubble_vx2 <= -BULLE_V;
            
        else if(
        (!bubble_reach_top2 && bubble_reach_left2 == 1) || 
        (!bubble_reach_top2 && bubble_reach_right2 == 1) || 
        (!bubble_reach_top2 && bubble2_back1_left) || 
        (!bubble_reach_top2 && bubble2_back1_right) || 
        (!bubble_reach_top2 && bubble2_back2_left) || 
        (!bubble_reach_top2 && bubble2_back2_right) || 
        (!bubble_reach_top2 && bubble2_back3_left) || 
        (!bubble_reach_top2 && bubble2_back3_right))

               
            next_bubble_vx2 <= 0;    
    
    
    else if(bubble_reach_top2 && bubble2_backn_reg) next_bubble_vx2 <= 1;    
    end
end

reg bubble2_backn_reg;
always@(posedge clk or posedge rst) begin
    if(rst) bubble2_backn_reg <= 0;
    else if(bubble2_back1_left || bubble2_back1_right || bubble2_back2_left || bubble2_back2_right || bubble2_back3_left || bubble2_back3_right) begin
        bubble2_backn_reg <= 1;
    end
    else if(bubble_reach_right2)
        bubble2_backn_reg <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) begin 
        current_bubble_vx2 <= 0; 
        current_bubble_vy2 <= 0;                
    end
    else begin
        current_bubble_vx2 <= next_bubble_vx2;
        current_bubble_vy2 <= next_bubble_vy2; 
    end
end

////////////////////////////위치 제어 x,y////////////////////////////////

always @(posedge clk or posedge rst) begin
    if (rst) begin 
        current_bubble_x2 <= 650;
        current_bubble_y2 <= 550; 
    end
    else if(bubble_move2 && !frame_tick) begin
        if(left) begin 
            current_bubble_x2 <= current_x - 40; 
            current_bubble_y2 <= current_y; 
        end
        else if(right) begin
            current_bubble_x2 <= current_x + 40; 
            current_bubble_y2 <= current_y; 
        end
        
        else if(bubble2_bed1_left || bubble2_bed1_right || bubble2_bed2_left || bubble2_bed2_right || bubble2_bed3_left || bubble2_bed3_right) begin
            current_bubble_x2 <= 650;
            current_bubble_y2 <= 550;
        end
    end
    else if (frame_tick) begin
        current_bubble_x2 <= current_bubble_x2 + current_bubble_vx2;
        current_bubble_y2 <= current_bubble_y2 + current_bubble_vy2; 
    end
end

//////////////////////공격3////////////////////////////
wire [10:0] bubble_x_l3;
wire [10:0] bubble_x_r3;
wire [10:0] bubble_y_t3;
wire [10:0] bubble_y_b3;

reg [10:0] current_bubble_x3;
reg [10:0] current_bubble_y3;
reg [10:0] next_bubble_x3;
reg [10:0] next_bubble_y3;

reg [10:0] current_bubble_vx3;
reg [10:0] current_bubble_vy3;
reg [10:0] next_bubble_vx3;
reg [10:0] next_bubble_vy3;
reg [6:0] bubble_speed3;
wire [10:0] bubble_left3;
wire [10:0] bubble_right3;
wire [10:0] bubble_top3;
wire [10:0] bubble_bottom3;
reg speed_en3;
reg bubble_on3;


assign bubble_x_l3 = current_bubble_x3;
assign bubble_y_b3 = current_bubble_y3;

assign bubble_left3 = bubble_cx3 - BUBBLE_RADIUS_X;
assign bubble_right3 = bubble_cx3 + BUBBLE_RADIUS_X;
assign bubble_top3 = bubble_cy3 - BUBBLE_RADIUS_Y;
assign bubble_bottom3 = bubble_cy3 + BUBBLE_RADIUS_Y;
  
  
 ///////////////////////왼쪽, 오른쪽 1차 충돌시의 reg/////////////////////
reg bubble3_bed1_left_reg;
reg bubble3_bed1_right_reg;
  
  always@(posedge rst or posedge clk) begin
    if(rst) bubble3_bed1_left_reg<=0;
    else if(bubble3_bed1_left) bubble3_bed1_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble3_bed1_right_reg<=0;
    else if(bubble3_bed1_right) bubble3_bed1_right_reg<=1;
end

reg bubble3_bed2_left_reg;
reg bubble3_bed2_right_reg;
  
  always@(posedge rst or posedge clk) begin
    if(rst) bubble3_bed2_left_reg<=0;
    else if(bubble3_bed2_left) bubble3_bed2_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble3_bed2_right_reg<=0;
    else if(bubble3_bed2_right) bubble3_bed2_right_reg<=1;
end

reg bubble3_bed3_left_reg;
reg bubble3_bed3_right_reg;

always@(posedge rst or posedge clk) begin
    if(rst) bubble3_bed3_left_reg<=0;
    else if(bubble3_bed3_left) bubble3_bed3_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble3_bed3_right_reg<=0;
    else if(bubble3_bed3_right) bubble3_bed3_right_reg<=1;
end
  

    // 타원의 중심 좌표 멤 단지르미
wire [9:0] bubble_cx3 = bubble_x_l3 + BUBBLE_RADIUS_X; // 중심 x좌표 (왼쪽 아래 기준으로 +24)
wire [9:0] bubble_cy3 = bubble_y_b3 - BUBBLE_RADIUS_Y; // 중심 y좌표 (왼쪽 아래 기준으로 -16)
    

    always @(*) begin
        // 타원의 방정식: ((x - cx)^2 / A^2) + ((y - cy)^2 / B^2) <= 1
        if ((((x - bubble_cx3) * (x - bubble_cx3) * BUBBLE_RADIUS_Y_SQ) + 
            ((y - bubble_cy3) * (y - bubble_cy3) * BUBBLE_RADIUS_X_SQ) <= 
            BUBBLE_RADIUS_X_SQ * BUBBLE_RADIUS_Y_SQ) && (bubble3_bed1_left_reg==0 && bubble3_bed1_right_reg==0 && bubble3_bed2_right_reg==0 && bubble3_bed2_left_reg==0
            && bubble3_bed3_right_reg==0 && bubble3_bed3_left_reg==0))
            
            bubble_on3 = 1; 
            
        else
            bubble_on3 = 0; 
    end


assign bubble_reach_left3 = (bubble_left3 <= LEFT_X_MAX) ? 1 : 0;
assign bubble_reach_right3 = (bubble_right3 >= RIGHT_X_MIN && bubble_right3 <= 640) ? 1 : 0;
assign bubble_reach_top3 = (bubble_top3 <= TOP_Y_MAX) ? 1 : 0;

    
assign bubble_move3 = (key_pulse == 5'h1d && bubble_count == 2);


////////////////////speed_en3제어/////////////////////
always@(posedge clk or posedge rst) begin
if(rst) speed_en3 <= 0;
else if(bubble_move3==1) speed_en3<=1; 
else if(bubble_speed3 == 100) speed_en3<=0;
end 
////////////////////speed counter3제어//////////////

always@(posedge clk or posedge rst) begin
    if(rst) bubble_speed3<=0;
    else if(speed_en3) begin
        if(bubble_speed3==100) bubble_speed3 <= 0;
        else bubble_speed3 <= bubble_speed3 + 1;
    end
end

////////////////////////////변위 제어 vy, vx////////////////////////


always @* begin
    if (rst) next_bubble_vy3 = 0; 
    else if ((!bubble_reach_top3 && bubble_reach_left3 == 1) || (!bubble_reach_top3 && bubble3_back1_left == 1)
    || (!bubble_reach_top3 && bubble3_back2_left == 1) || (!bubble_reach_top3 && bubble3_back3_left == 1))
     next_bubble_vy3 = -1 * BULLE_V;
     
    else if ((!bubble_reach_top3 && bubble_reach_right3 == 1) || (!bubble_reach_top3 && bubble3_back1_right == 1)
    || (!bubble_reach_top3 && bubble3_back2_right == 1)|| (!bubble_reach_top3 && bubble3_back3_right == 1)) 
    next_bubble_vy3 = -1 * BULLE_V;
    
    
    else if(bubble_reach_top3 == 1) next_bubble_vy3 = 0;
    else next_bubble_vy3 = current_bubble_vy3; 
end

always@(posedge clk or posedge rst) begin
    if(rst) 
        next_bubble_vx3 <= 0;
    else begin
        if(key_pulse == 5'h1d && bubble_count == 2)  begin
            if(left == 1) next_bubble_vx3 <= -1 * BULLE_V;
            else if(right == 1) next_bubble_vx3 <= 1 * BULLE_V; 
        end
        
        else if(speed_en3 && bubble_move3==0) begin
            if(left == 1) next_bubble_vx3 <= -3 * BULLE_V;
            else if(right == 1) next_bubble_vx3 <= 3 * BULLE_V; 
        end
        
        else if(bubble_reach_top3 && bubble_reach_left3 == 1) 
            next_bubble_vx3 <= BULLE_V;
        else if(bubble_reach_top3 && bubble_reach_right3 == 1) 
            next_bubble_vx3 <= -BULLE_V;
        else if((!bubble_reach_top3 && bubble_reach_left3 == 1) || (!bubble_reach_top3 && bubble_reach_right3 == 1)
        
         || (!bubble_reach_top3 && bubble3_back1_left == 1) ||  (!bubble_reach_top3 && bubble3_back1_right == 1)||
         (!bubble_reach_top3 && bubble3_back2_left == 1) ||  (!bubble_reach_top3 && bubble3_back2_right == 1) ||
         (!bubble_reach_top3 && bubble3_back3_left == 1) ||  (!bubble_reach_top3 && bubble3_back3_right == 1) )
        
            next_bubble_vx3 <= 0;  
            
            else if(bubble3_backn_reg && bubble_reach_top3)   
        next_bubble_vx3 <= 1 * BULLE_V;      
    end
end

reg bubble3_backn_reg;
always@(posedge clk or posedge rst) begin
    if(rst) bubble3_backn_reg <= 0;
    else if(bubble3_back1_left || bubble3_back1_right || bubble3_back2_left || bubble3_back2_right || bubble3_back3_left || bubble3_back3_right) begin
        bubble3_backn_reg <= 1;
    end
    else if(bubble_reach_right3)
        bubble3_backn_reg <= 0;
end


always@(posedge clk or posedge rst) begin
    if(rst) begin 
        current_bubble_vx3 <= 0; 
        current_bubble_vy3 <= 0;                
    end
    else begin
        current_bubble_vx3 <= next_bubble_vx3;
        current_bubble_vy3 <= next_bubble_vy3; 
    end
end

////////////////////////////위치 제어 x,y////////////////////////////////

always @(posedge clk or posedge rst) begin
    if (rst) begin 
        current_bubble_x3 <= 650;
        current_bubble_y3 <= 550; 
    end
    else if(bubble_move3 && !frame_tick) begin
        if(left) begin 
            current_bubble_x3 <= current_x - 40; 
            current_bubble_y3 <= current_y; 
        end
        else if(right) begin
            current_bubble_x3 <= current_x + 40; 
            current_bubble_y3 <= current_y; 
        end
        
        else if(bubble3_bed1_left || bubble3_bed1_right || bubble3_bed2_left || bubble3_bed2_right || bubble3_bed3_left || bubble3_bed3_right) begin
            current_bubble_x3 <= 650;
            current_bubble_y3 <= 550;
        end
    end
    else if (frame_tick) begin
        current_bubble_x3 <= current_bubble_x3 + current_bubble_vx3;
        current_bubble_y3 <= current_bubble_y3 + current_bubble_vy3; 
    end
end
/////////////////////////공격4//////////////////////////////////////////////////////////////
wire [10:0] bubble_x_l4;
wire [10:0] bubble_x_r4;
wire [10:0] bubble_y_t4;
wire [10:0] bubble_y_b4;

reg [10:0] current_bubble_x4;
reg [10:0] current_bubble_y4;
reg [10:0] next_bubble_x4;
reg [10:0] next_bubble_y4;

reg [10:0] current_bubble_vx4;
reg [10:0] current_bubble_vy4;
reg [10:0] next_bubble_vx4;
reg [10:0] next_bubble_vy4;
reg [6:0] bubble_speed4;
wire [10:0] bubble_left4;
wire [10:0] bubble_right4;
wire [10:0] bubble_top4;
wire [10:0] bubble_bottom4;
reg speed_en4;
reg bubble_on4;


assign bubble_x_l4 = current_bubble_x4;
assign bubble_y_b4 = current_bubble_y4;

assign bubble_left4 = bubble_cx4 - BUBBLE_RADIUS_X;
assign bubble_right4 = bubble_cx4 + BUBBLE_RADIUS_X;
assign bubble_top4 = bubble_cy4 - BUBBLE_RADIUS_Y;
assign bubble_bottom4 = bubble_cy4 + BUBBLE_RADIUS_Y;
  
 ///////////////////////왼쪽, 오른쪽 1차 충돌시의 reg/////////////////////
reg bubble4_bed1_left_reg;
reg bubble4_bed1_right_reg;
  
always@(posedge rst or posedge clk) begin
    if(rst) bubble4_bed1_left_reg<=0;
    else if(bubble4_bed1_left) bubble4_bed1_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble4_bed1_right_reg<=0;
    else if(bubble4_bed1_right) bubble4_bed1_right_reg<=1;
end

reg bubble4_bed2_left_reg;
reg bubble4_bed2_right_reg;
  
always@(posedge rst or posedge clk) begin
    if(rst) bubble4_bed2_left_reg<=0;
    else if(bubble4_bed2_left) bubble4_bed2_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble4_bed2_right_reg<=0;
    else if(bubble4_bed2_right) bubble4_bed2_right_reg<=1;
end

reg bubble4_bed3_left_reg;
reg bubble4_bed3_right_reg;
  
always@(posedge rst or posedge clk) begin
    if(rst) bubble4_bed3_left_reg<=0;
    else if(bubble4_bed3_left) bubble4_bed3_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble4_bed3_right_reg<=0;
    else if(bubble4_bed3_right) bubble4_bed3_right_reg<=1;
end


    // 타원의 중심 좌표 멤 단지르미
wire [9:0] bubble_cx4 = bubble_x_l4 + BUBBLE_RADIUS_X; // 중심 x좌표 (왼쪽 아래 기준으로 +24)
wire [9:0] bubble_cy4 = bubble_y_b4 - BUBBLE_RADIUS_Y; // 중심 y좌표 (왼쪽 아래 기준으로 -16)
    

always @(*) begin
        // 타원의 방정식: ((x - cx)^2 / A^2) + ((y - cy)^2 / B^2) <= 1
        if ((((x - bubble_cx4) * (x - bubble_cx4) * BUBBLE_RADIUS_Y_SQ) + 
            ((y - bubble_cy4) * (y - bubble_cy4) * BUBBLE_RADIUS_X_SQ) <= 
            BUBBLE_RADIUS_X_SQ * BUBBLE_RADIUS_Y_SQ) && (bubble4_bed1_left_reg==0 && bubble4_bed1_right_reg==0 && bubble4_bed2_right_reg==0 && bubble4_bed2_left_reg==0
           && bubble4_bed3_right_reg==0 && bubble4_bed3_left_reg==0))
            
            bubble_on4 = 1; 
            
        else
            bubble_on4 = 0; 
end


assign bubble_reach_left4 = (bubble_left4 <= LEFT_X_MAX) ? 1 : 0;
assign bubble_reach_right4 = (bubble_right4 >= RIGHT_X_MIN && bubble_right4 <= 640) ? 1 : 0;
assign bubble_reach_top4 = (bubble_top4 <= TOP_Y_MAX) ? 1 : 0;

    
assign bubble_move4 = (key_pulse == 5'h1d && bubble_count == 3);


////////////////////speed_en4제어/////////////////////
always@(posedge clk or posedge rst) begin
if(rst) speed_en4 <= 0;
else if(bubble_move4==1) speed_en4<=1; 
else if(bubble_speed4 == 100) speed_en4<=0;
end 
////////////////////speed counter4제어//////////////

always@(posedge clk or posedge rst) begin
    if(rst) bubble_speed4<=0;
    else if(speed_en4) begin
        if(bubble_speed4==100) bubble_speed4 <= 0;
        else bubble_speed4 <= bubble_speed4 + 1;
    end
end

////////////////////////////변위 제어 vy, vx////////////////////////


always @* begin
    if (rst) next_bubble_vy4 = 0; 
    else if ((!bubble_reach_top4 && bubble_reach_left4 == 1) || (!bubble_reach_top4 && bubble4_back1_left == 1)
    || (!bubble_reach_top4 && bubble4_back2_left == 1) || (!bubble_reach_top4 && bubble4_back3_left == 1))
        next_bubble_vy4 = -1 * BULLE_V;
     
    else if ((!bubble_reach_top4 && bubble_reach_right4 == 1) || (!bubble_reach_top4 && bubble4_back1_right == 1)
    || (!bubble_reach_top4 && bubble4_back2_right == 1) || (!bubble_reach_top4 && bubble4_back3_right == 1)) 
        next_bubble_vy4 = -1 * BULLE_V;
        
    else if(bubble_reach_top4 == 1) next_bubble_vy4 = 0;
    else next_bubble_vy4 = current_bubble_vy4; 
end

always@(posedge clk or posedge rst) begin
    if(rst) 
        next_bubble_vx4 <= 0;
    else begin
        if(key_pulse == 5'h1d && bubble_count == 3)  begin
            if(left == 1) next_bubble_vx4 <= -1 * BULLE_V;
            else if(right == 1) next_bubble_vx4 <= 1 * BULLE_V; 
        end
        
        else if(speed_en4 && bubble_move4==0) begin
            if(left == 1) next_bubble_vx4 <= -3 * BULLE_V;
            else if(right == 1) next_bubble_vx4 <= 3 * BULLE_V; 
        end
        
        else if(bubble_reach_top4 && bubble_reach_left4 == 1) 
            next_bubble_vx4 <= BULLE_V;
        else if(bubble_reach_top4 && bubble_reach_right4 == 1) 
            next_bubble_vx4 <= -BULLE_V;
        else if((!bubble_reach_top4 && bubble_reach_left4 == 1) || (!bubble_reach_top4 && bubble_reach_right4 == 1)
                || (!bubble_reach_top4 && bubble4_back1_left == 1) ||  (!bubble_reach_top4 && bubble4_back1_right == 1)||
         (!bubble_reach_top4 && bubble4_back2_left == 1) ||  (!bubble_reach_top4 && bubble4_back2_right == 1) ||
         (!bubble_reach_top4 && bubble4_back3_left == 1) ||  (!bubble_reach_top4 && bubble4_back3_right == 1))
         
            next_bubble_vx4 <= 0;    
            
            else if(bubble4_backn_reg && bubble_reach_top4)   
        next_bubble_vx4 <= 1 * BULLE_V;    
    end
end

reg bubble4_backn_reg;
always@(posedge clk or posedge rst) begin
    if(rst) bubble4_backn_reg <= 0;
    else if(bubble4_back1_left || bubble4_back1_right || bubble4_back2_left || bubble4_back2_right || bubble4_back3_left || bubble4_back3_right) begin
        bubble4_backn_reg <= 1;
    end
    else if(bubble_reach_right4)
        bubble4_backn_reg <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) begin 
        current_bubble_vx4 <= 0; 
        current_bubble_vy4 <= 0;                
    end
    else begin
        current_bubble_vx4 <= next_bubble_vx4;
        current_bubble_vy4 <= next_bubble_vy4; 
    end
end

////////////////////////////위치 제어 x,y////////////////////////////////

always @(posedge clk or posedge rst) begin
    if (rst) begin 
        current_bubble_x4 <= 650;
        current_bubble_y4 <= 550; 
    end
    else if(bubble_move4 && !frame_tick) begin
        if(left) begin 
            current_bubble_x4 <= current_x - 40; 
            current_bubble_y4 <= current_y; 
        end
        else if(right) begin
            current_bubble_x4 <= current_x + 40; 
            current_bubble_y4 <= current_y; 
        end
        
        else if(bubble4_bed1_left || bubble4_bed1_right || bubble4_bed2_left || bubble4_bed2_right || bubble4_bed3_left || bubble4_bed3_right) begin
            current_bubble_x4 <= 650;
            current_bubble_y4 <= 550;
        end
    end
    else if (frame_tick) begin
        current_bubble_x4 <= current_bubble_x4 + current_bubble_vx4;
        current_bubble_y4 <= current_bubble_y4 + current_bubble_vy4; 
    end
end

/////////////////////////공격5//////////////////////////////////////////////////////////////
wire [10:0] bubble_x_l5;
wire [10:0] bubble_x_r5;
wire [10:0] bubble_y_t5;
wire [10:0] bubble_y_b5;

reg [10:0] current_bubble_x5;
reg [10:0] current_bubble_y5;
reg [10:0] next_bubble_x5;
reg [10:0] next_bubble_y5;

reg [10:0] current_bubble_vx5;
reg [10:0] current_bubble_vy5;
reg [10:0] next_bubble_vx5;
reg [10:0] next_bubble_vy5;
reg [6:0] bubble_speed5;
wire [10:0] bubble_left5;
wire [10:0] bubble_right5;
wire [10:0] bubble_top5;
wire [10:0] bubble_bottom5;
reg speed_en5;
reg bubble_on5;


assign bubble_x_l5 = current_bubble_x5;
assign bubble_y_b5 = current_bubble_y5;

assign bubble_left5 = bubble_cx5 - BUBBLE_RADIUS_X;
assign bubble_right5 = bubble_cx5 + BUBBLE_RADIUS_X;
assign bubble_top5 = bubble_cy5 - BUBBLE_RADIUS_Y;
assign bubble_bottom5 = bubble_cy5 + BUBBLE_RADIUS_Y;
  
 ///////////////////////왼쪽, 오른쪽 1차 충돌시의 reg/////////////////////
reg bubble5_bed1_left_reg;
reg bubble5_bed1_right_reg;
  
always@(posedge rst or posedge clk) begin
    if(rst) bubble5_bed1_left_reg<=0;
    else if(bubble5_bed1_left) bubble5_bed1_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble5_bed1_right_reg<=0;
    else if(bubble5_bed1_right) bubble5_bed1_right_reg<=1;
end

reg bubble5_bed2_left_reg;
reg bubble5_bed2_right_reg;
  
always@(posedge rst or posedge clk) begin
    if(rst) bubble5_bed2_left_reg<=0;
    else if(bubble5_bed2_left) bubble5_bed2_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble5_bed2_right_reg<=0;
    else if(bubble5_bed2_right) bubble5_bed2_right_reg<=1;
end

reg bubble5_bed3_left_reg;
reg bubble5_bed3_right_reg;
  
always@(posedge rst or posedge clk) begin
    if(rst) bubble5_bed3_left_reg<=0;
    else if(bubble5_bed3_left) bubble5_bed3_left_reg<=1;
end

always@(posedge rst or posedge clk) begin
    if(rst) bubble5_bed3_right_reg<=0;
    else if(bubble5_bed3_right) bubble5_bed3_right_reg<=1;
end
    // 타원의 중심 좌표 멤 단지르미
wire [9:0] bubble_cx5 = bubble_x_l5 + BUBBLE_RADIUS_X; // 중심 x좌표 (왼쪽 아래 기준으로 +24)
wire [9:0] bubble_cy5 = bubble_y_b5 - BUBBLE_RADIUS_Y; // 중심 y좌표 (왼쪽 아래 기준으로 -16)
    

always @(*) begin
        // 타원의 방정식: ((x - cx)^2 / A^2) + ((y - cy)^2 / B^2) <= 1
        if ((((x - bubble_cx5) * (x - bubble_cx5) * BUBBLE_RADIUS_Y_SQ) + 
            ((y - bubble_cy5) * (y - bubble_cy5) * BUBBLE_RADIUS_X_SQ) <= 
            BUBBLE_RADIUS_X_SQ * BUBBLE_RADIUS_Y_SQ) && (bubble5_bed1_left_reg==0 && bubble5_bed1_right_reg==0 && bubble5_bed2_right_reg==0 && bubble5_bed2_left_reg==0
            && bubble5_bed3_right_reg==0 && bubble5_bed3_left_reg==0))
            
            bubble_on5 = 1; 
            
        else
            bubble_on5 = 0; 
end


assign bubble_reach_left5 = (bubble_left5 <= LEFT_X_MAX) ? 1 : 0;
assign bubble_reach_right5 = (bubble_right5 >= RIGHT_X_MIN && bubble_right5 <= 640) ? 1 : 0;
assign bubble_reach_top5 = (bubble_top5 <= TOP_Y_MAX) ? 1 : 0;

    
assign bubble_move5 = (key_pulse == 5'h1d && bubble_count == 4);


////////////////////speed_en5제어/////////////////////
always@(posedge clk or posedge rst) begin
if(rst) speed_en5 <= 0;
else if(bubble_move5==1) speed_en5<=1; 
else if(bubble_speed5 == 100) speed_en5<=0;
end 
////////////////////speed counter5제어//////////////

always@(posedge clk or posedge rst) begin
    if(rst) bubble_speed5<=0;
    else if(speed_en5) begin
        if(bubble_speed5==100) bubble_speed5 <= 0;
        else bubble_speed5 <= bubble_speed5 + 1;
    end
end

////////////////////////////변위 제어 vy, vx////////////////////////


always @* begin
    if (rst) next_bubble_vy5 = 0; 
    else if ((!bubble_reach_top5 && bubble_reach_left5 == 1) || (!bubble_reach_top5 && bubble5_back1_left == 1)
    || (!bubble_reach_top5 && bubble5_back2_left == 1) || (!bubble_reach_top5 && bubble5_back3_left == 1)) next_bubble_vy5 = -1 * BULLE_V;
    
    else if ((!bubble_reach_top5 && bubble_reach_right5 == 1) || (!bubble_reach_top5 && bubble5_back1_right == 1)
    || (!bubble_reach_top5 && bubble5_back2_right == 1) || (!bubble_reach_top5 && bubble5_back3_right == 1)) next_bubble_vy5 = -1 * BULLE_V;
    
    else if(bubble_reach_top5 == 1) next_bubble_vy5 = 0;
    else next_bubble_vy5 = current_bubble_vy5; 
end

always@(posedge clk or posedge rst) begin
    if(rst) 
        next_bubble_vx5 <= 0;
    else begin
        if(key_pulse == 5'h1d && bubble_count == 4)  begin
            if(left == 1) next_bubble_vx5 <= -1 * BULLE_V;
            else if(right == 1) next_bubble_vx5 <= 1 * BULLE_V; 
        end
        
        else if(speed_en5 && bubble_move5==0) begin
            if(left == 1) next_bubble_vx5 <= -3 * BULLE_V;
            else if(right == 1) next_bubble_vx5 <= 3 * BULLE_V; 
        end
        
        else if(bubble_reach_top5 && bubble_reach_left5 == 1) 
            next_bubble_vx5 <= BULLE_V;
        else if(bubble_reach_top5 && bubble_reach_right5 == 1) 
            next_bubble_vx5 <= -BULLE_V;
        else if((!bubble_reach_top5 && bubble_reach_left5 == 1) || (!bubble_reach_top5 && bubble_reach_right5 == 1)
        || (!bubble_reach_top5 && bubble5_back1_left == 1) ||  (!bubble_reach_top5 && bubble5_back1_right == 1)||
         (!bubble_reach_top5 && bubble5_back2_left == 1) ||  (!bubble_reach_top5 && bubble5_back2_right == 1) ||
         (!bubble_reach_top5 && bubble5_back3_left == 1) ||  (!bubble_reach_top5 && bubble5_back3_right == 1) )
            
            next_bubble_vx5 <= 0;
            
        else if(bubble5_backn_reg && bubble_reach_top5)   
        next_bubble_vx5 <= 1 * BULLE_V;     
    end
    
end
reg bubble5_backn_reg;
always@(posedge clk or posedge rst) begin
    if(rst) bubble5_backn_reg <= 0;
    else if(bubble5_back1_left || bubble5_back1_right || bubble5_back2_left || bubble5_back2_right || bubble5_back3_left || bubble5_back3_right) begin
        bubble5_backn_reg <= 1;
    end
    else if(bubble_reach_right5)
        bubble5_backn_reg <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) begin 
        current_bubble_vx5 <= 0; 
        current_bubble_vy5 <= 0;                
    end
    else begin
        current_bubble_vx5 <= next_bubble_vx5;
        current_bubble_vy5 <= next_bubble_vy5; 
    end
end

////////////////////////////위치 제어 x,y////////////////////////////////

always @(posedge clk or posedge rst) begin
    if (rst) begin 
        current_bubble_x5 <= 650;
        current_bubble_y5 <= 550; 
    end
    else if(bubble_move5 && !frame_tick) begin
        if(left) begin 
            current_bubble_x5 <= current_x - 40; 
            current_bubble_y5 <= current_y; 
        end
        else if(right) begin
            current_bubble_x5 <= current_x + 40; 
            current_bubble_y5 <= current_y; 
        end
        
        else if(bubble5_bed1_left || bubble5_bed1_right || bubble5_bed2_left || bubble5_bed2_right || bubble5_bed3_left || bubble5_bed3_right) begin
            current_bubble_x5 <= 650;
            current_bubble_y5 <= 550;
        end
    end
    else if (frame_tick) begin
        current_bubble_x5 <= current_bubble_x5 + current_bubble_vx5;
        current_bubble_y5 <= current_bubble_y5 + current_bubble_vy5; 
    end
end  


/////////////////////////////////////악당, 버블 충돌 제어///////////////////////////////////////////////
/////////////////악당1과의 충돌////////////////////////////////////////////////////////
reg[10:0] current_bubble_bed1_vx;
reg[10:0] current_bubble_bed1_vy;
reg[10:0] next_bubble_bed1_vx;
reg[10:0] next_bubble_bed1_vy;

reg[10:0] current_bubble_bed1_x;
reg[10:0] current_bubble_bed1_y;

reg in_bubble_left1;
reg in_bubble_right1;

wire [10:0] bubble_bed1_xl = current_bubble_bed1_x;
wire [10:0] bubble_bed1_xr = bubble_bed1_xl+BUBBLE_SIZE;
wire [10:0] bubble_bed1_yt = bubble_bed1_yb-BUBBLE_SIZE;
wire [10:0] bubble_bed1_yb = current_bubble_bed1_y;



//////////////왼쪽을 보고 있음/////////////
wire bubble_bed1_on_left =  (in_bubble_left1 && !collision_left_reg1 && !collision_right_reg1)
                             && ((bubble_bed1_xl + 10 <= x && x <= bubble_bed1_xl + 40 && current_bubble_bed1_y-28 <= y && y <= current_bubble_bed1_y-15) ||
                             (bubble_bed1_xl + 30 <= x && x <= bubble_bed1_xl + 40 && current_bubble_bed1_y-32 <= y && y <= current_bubble_bed1_y-28) ||
                             (bubble_bed1_xl + 10<= x && x <= bubble_bed1_xl + 40 && current_bubble_bed1_y-45 <= y && y <= current_bubble_bed1_y-32)) ? 1 : 0;
                  
//////////오른쪽을  보고 있음////////////                  
wire bubble_bed1_on_right = (in_bubble_right1 && !collision_left_reg1 && !collision_right_reg1) 
                            && ((bubble_bed1_xl + 10 <= x && x <= bubble_bed1_xl + 40 && current_bubble_bed1_y-28 <= y && y <= current_bubble_bed1_y-15) ||
                            (bubble_bed1_xl + 10 <= x && x <= bubble_bed1_xl + 20 && current_bubble_bed1_y-32 <= y && y <= current_bubble_bed1_y-28) ||
                             (bubble_bed1_xl  + 10 <= x && x <= bubble_bed1_xl + 40 && current_bubble_bed1_y-45 <= y && y <= current_bubble_bed1_y-32)) ? 1 : 0;
                             
                             
wire bubble_bed_eyes_on_left1 = (in_bubble_left1 && !collision_left_reg1 && !collision_right_reg1) 
                                    && ((bubble_bed1_xl+15 <= x && x<= bubble_bed1_xl+18 && current_bubble_bed1_y-40 <= y && y <= current_bubble_bed1_y-37) || 
                                    (bubble_bed1_xl+22 <= x && x<= bubble_bed1_xl+25 && current_bubble_bed1_y-40 <= y && y <= current_bubble_bed1_y-37));  
                                     
wire bubble_bed_eyes_on_right1 = (in_bubble_right1 && !collision_left_reg1 && !collision_right_reg1)
                                     && ((bubble_bed1_xl+25 <= x && x<= bubble_bed1_xl+28 && current_bubble_bed1_y-40 <= y && y <= current_bubble_bed1_y-37) || 
                                    (bubble_bed1_xl+32 <= x && x<= bubble_bed1_xl+35 && current_bubble_bed1_y-40 <= y && y <= current_bubble_bed1_y-37));                               
                            
reg bubble_bed1_on_back;
wire [9:0] bubble_bed_cx1 =  bubble_bed1_xl + BUBBLE_RADIUS_X; 
wire [9:0] bubble_bed_cy1 = bubble_bed1_yb - BUBBLE_RADIUS_Y; 

wire [10:0] bubble_circle_bed_left1; 
wire [10:0] bubble_circle_bed_right1;
 wire [10:0] bubble_circle_bed_top1;
 wire [10:0] bubble_circle_bed_bottom1;   
 //부딪히는 순간의 버블의 색을 기억함
 reg [2:0] back_cor_reg;
 always@(posedge rst or posedge clk) begin
    if(rst) back_cor_reg<=0;
    /////그냥 넣기///////////////
    else if(bubble1_bed1_left || bubble1_bed1_right || bubble2_bed1_right || bubble2_bed1_left || bubble3_bed1_right || bubble3_bed1_left
        || bubble4_bed1_right || bubble4_bed1_left || bubble5_bed1_right || bubble5_bed1_left)
    back_cor_reg <= {bubble_cor1,bubble_cor2,bubble_cor3};
 end
 
 
 assign bubble_circle_bed_left1= bubble_bed_cx1 -  BUBBLE_RADIUS_X;  
 assign bubble_circle_bed_right1= bubble_bed_cx1 +  BUBBLE_RADIUS_X;
 assign bubble_circle_bed_top1 = bubble_bed_cy1 - BUBBLE_RADIUS_Y;
 assign bubble_circle_bed_bottom1 = bubble_bed_cy1 + BUBBLE_RADIUS_Y;
  
always @(*) begin
        // 타원의 방정식: ((x - cx)^2 / A^2) + ((y - cy)^2 / B^2) <= 1
        if (((x - bubble_bed_cx1) * (x - bubble_bed_cx1) * BUBBLE_RADIUS_Y_SQ) + 
            ((y - bubble_bed_cy1) * (y - bubble_bed_cy1) * BUBBLE_RADIUS_X_SQ) <= 
            BUBBLE_RADIUS_X_SQ * BUBBLE_RADIUS_Y_SQ)
            
            bubble_bed1_on_back = 1; // 타원 내부에 있으면 활성화
        else
            bubble_bed1_on_back = 0; // 타원 외부이면 비활성화
    end                            
                  
                  
///////bubble이 왼쪽에서 충돌하는 경우 -> 오른쪽으로 가야함/////////////
wire bubble1_bed1_left = (bubble_bottom1 == bed_y_b1 && bubble_right1 >= bed_x_l1 
&& bubble_right1 <= bed_x_r1) && (current_y == WALL_3_Y_MIN) ? 1 : 0;

///////bubble이 오른쪽에서에서 충돌하는 경우 -> 왼쪽으로 가야함/////////////
wire bubble1_bed1_right = ( bubble_bottom1 == bed_y_b1 && bubble_left1 >= bed_x_l1 
&& bubble_left1 <= bed_x_r1) && (current_y == WALL_3_Y_MIN) ? 1 : 0;

//////////////버블 2 와의 충돌/////////////////////
wire bubble2_bed1_left = (bubble_bottom2 == bed_y_b1 && bubble_right2 >= bed_x_l1 
&& bubble_right2 <= bed_x_r1) && (current_y == WALL_3_Y_MIN) ? 1 : 0;

wire bubble2_bed1_right = (bubble_bottom2 == bed_y_b1 && bubble_left2 >= bed_x_l1 
&& bubble_left2 <= bed_x_r1) && (current_y == WALL_3_Y_MIN)? 1 : 0;

////////////버블3과의 충돌////////////////////
wire bubble3_bed1_left = (bubble_bottom3 == bed_y_b1 && bubble_right3 >= bed_x_l1 
&& bubble_right3 <= bed_x_r1) && (current_y == WALL_3_Y_MIN)? 1 : 0;

wire bubble3_bed1_right = (bubble_bottom3 == bed_y_b1 && bubble_left3 >= bed_x_l1 
&& bubble_left3 <= bed_x_r1) && (current_y == WALL_3_Y_MIN)? 1 : 0;

////////////버블 4와의 충돌//////////////////
wire bubble4_bed1_left = (bubble_bottom4 == bed_y_b1 && bubble_right4 >= bed_x_l1 
&& bubble_right4 <= bed_x_r1) && (current_y == WALL_3_Y_MIN)? 1 : 0;

wire bubble4_bed1_right = (bubble_bottom4 == bed_y_b1 && bubble_left4 >= bed_x_l1 
&& bubble_left4 <= bed_x_r1) && (current_y == WALL_3_Y_MIN)? 1 : 0;

////////////버블 5와의 충돌/////////////
wire bubble5_bed1_left = (bubble_bottom5 == bed_y_b1 && bubble_right5 >= bed_x_l1 
&& bubble_right5 <= bed_x_r1) && (current_y == WALL_3_Y_MIN)? 1 : 0;

wire bubble5_bed1_right = (bubble_bottom5 == bed_y_b1 && bubble_left5 >= bed_x_l1 
&& bubble_left5 <= bed_x_r1) && (current_y == WALL_3_Y_MIN)? 1 : 0;


assign bubble_bed_reach_left1 = ( bubble_circle_bed_right1 <= WALL_3_X_MIN) ? 1 : 0;
assign bubble_bed_reach_right1 = (bubble_circle_bed_left1 >= WALL_3_X_MAX && bubble_circle_bed_right1 <= 640) ? 1 : 0;
assign bubble_bed_reach_bottom1 = (bubble_circle_bed_bottom1 >= BOTTOM_Y_MIN) ? 1 : 0;

////////////////갇혔을때의 방향 정의////////////
always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_left1 <= 0;
                            //////////////괄호 유의//////////////////
    else if(current_y == WALL_3_Y_MIN && bed_left1 && ((bubble1_bed1_left == 1 || bubble1_bed1_right==1) || (bubble2_bed1_left == 1 || bubble2_bed1_right==1) || 
    (bubble3_bed1_left == 1 || bubble3_bed1_right==1) || (bubble4_bed1_left == 1 || bubble4_bed1_right==1) || (bubble5_bed1_left == 1 || bubble5_bed1_right==1)))
        in_bubble_left1 <= 1;
end

always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_right1 <= 0;
                            //////////////괄호 유의//////////////////
    else if(current_y == WALL_3_Y_MIN && bed_right1 && ((bubble1_bed1_left == 1 || bubble1_bed1_right==1) || (bubble2_bed1_left == 1 || bubble2_bed1_right==1) ||
    (bubble3_bed1_left == 1 || bubble3_bed1_right==1) || (bubble4_bed1_left == 1 || bubble4_bed1_right==1)|| (bubble5_bed1_left == 1 || bubble5_bed1_right==1)))
         in_bubble_right1 <= 1;
end
////////////////////////////////////////////////반띵///////////////////////////////////////////////////////
/////////////변위 제어/////////////
always@(*) begin
    if(rst) next_bubble_bed1_vy = 0;
    else if((bubble_bed_reach_left1 || bubble_bed_reach_right1) && !bubble_bed_reach_bottom1) next_bubble_bed1_vy = 1 * BULLE_V;
    else if(bubble_bed_reach_bottom1) next_bubble_bed1_vy = 0;
    else next_bubble_bed1_vy = current_bubble_bed1_vy; 
end

always@(posedge clk or posedge rst) begin
    if(rst) next_bubble_bed1_vx <= 0;
    ///////////////그냥 넣기//////////////////
    else if(bubble1_bed1_left || bubble2_bed1_left || bubble3_bed1_left || bubble4_bed1_left || bubble5_bed1_left
            || bubble1_back1_left || bubble2_back1_left || bubble3_back1_left || bubble4_back1_left || bubble5_back1_left) 
            next_bubble_bed1_vx <= 1 * BULLE_V;
    
    else if(bubble1_bed1_right || bubble2_bed1_right || bubble3_bed1_right || bubble4_bed1_right || bubble5_bed1_right
    || bubble1_back1_right || bubble2_back1_right || bubble3_back1_right || bubble4_back1_right || bubble5_back1_right)  
    next_bubble_bed1_vx <= -1 * BULLE_V;
    
    else if(bubble_bed_reach_bottom1 && bubble_bed_reach_left1) next_bubble_bed1_vx <= 1 * BULLE_V;
     else if(bubble_bed_reach_bottom1 && bubble_bed_reach_right1) next_bubble_bed1_vx <= -1 * BULLE_V;
    else if(bubble_bed_reach_left1 || bubble_bed_reach_right1) next_bubble_bed1_vx <= 0; 
end

always@(posedge clk or posedge rst) begin
    if(rst) begin
        current_bubble_bed1_vx <= 0;
        current_bubble_bed1_vy <= 0;
    end
    
    else begin
    current_bubble_bed1_vx <= next_bubble_bed1_vx;
    current_bubble_bed1_vy <= next_bubble_bed1_vy;
    end
end

always@(posedge clk or posedge rst) begin
if(rst) begin
    current_bubble_bed1_x <= 650;
    current_bubble_bed1_y <= 0;
end

/////////////////그냥 넣기////////////////
else if((bubble1_bed1_left || bubble1_bed1_right || bubble2_bed1_right || bubble2_bed1_left ||
 bubble3_bed1_left || bubble3_bed1_right || bubble4_bed1_left || bubble4_bed1_right || bubble5_bed1_left || bubble5_bed1_right) && current_y == WALL_3_Y_MIN) begin
 
    current_bubble_bed1_x <= current_bed_x1;
    current_bubble_bed1_y <= current_bed_y1;
end

else if(collision_left_reg1 || collision_left_reg1) begin
    current_bubble_bed1_x <= 650;
    current_bubble_bed1_y <= 0;
end

else if(frame_tick) begin
    current_bubble_bed1_x <= current_bubble_bed1_x + next_bubble_bed1_vx;
    current_bubble_bed1_y <= current_bubble_bed1_y + next_bubble_bed1_vy;
end
end

////////////////////////두번째 충돌의 경우 - 물방울이 깨짐//////////////////
reg collision_left_reg1;
reg collision_right_reg1;

wire collision_left1 = ((current_y == current_bubble_bed1_y) && current_bubble_bed1_x <= current_x+45 && 
                        current_x+45 <= current_bubble_bed1_x + BUBBLE_SIZE) ? 1 : 0;
                        
wire collision_right1 = ((current_y == current_bubble_bed1_y) && current_bubble_bed1_x <= current_x && 
                        current_x <= current_bubble_bed1_x + BUBBLE_SIZE) ? 1 : 0;
                        
always@(posedge clk or posedge rst) begin
    if(rst) collision_left_reg1<=0;
    else if(collision_left1) collision_left_reg1 <= 1;
end            

         
always@(posedge clk or posedge rst) begin
    if(rst) collision_right_reg1<=0;
    else if(collision_left1) collision_right_reg1 <= 1;
end            
                   
                   
/////////////////악당2와의 충돌//////////////////////

reg[10:0] current_bubble_bed2_vx;
reg[10:0] current_bubble_bed2_vy;
reg[10:0] next_bubble_bed2_vx;
reg[10:0] next_bubble_bed2_vy;

reg[10:0] current_bubble_bed2_x;
reg[10:0] current_bubble_bed2_y;

reg in_bubble_left2;
reg in_bubble_right2;

wire [10:0] bubble_bed2_xl = current_bubble_bed2_x;
wire [10:0] bubble_bed2_xr = bubble_bed2_xl+BUBBLE_SIZE;
wire [10:0] bubble_bed2_yt = bubble_bed2_yb-BUBBLE_SIZE;
wire [10:0] bubble_bed2_yb = current_bubble_bed2_y;

//////////////왼쪽을 보고 있음/////////////
wire bubble_bed2_on_left =  (in_bubble_left2 && !collision_left_reg2 && !collision_right_reg2)
                             && ((bubble_bed2_xl + 10 <= x && x <= bubble_bed2_xl + 40 && current_bubble_bed2_y-28 <= y && y <= current_bubble_bed2_y-15) ||
                             (bubble_bed2_xl + 30 <= x && x <= bubble_bed2_xl + 40 && current_bubble_bed2_y-32 <= y && y <= current_bubble_bed2_y-28) ||
                             (bubble_bed2_xl + 10<= x && x <= bubble_bed2_xl + 40 && current_bubble_bed2_y-45 <= y && y <= current_bubble_bed2_y-32)) ? 1 : 0;
                  
//////////오른쪽을  보고 있음////////////                  
wire bubble_bed2_on_right = (in_bubble_right2 && !collision_left_reg2 && !collision_right_reg2) 
                            && ((bubble_bed2_xl + 10 <= x && x <= bubble_bed2_xl + 40 && current_bubble_bed2_y-28 <= y && y <= current_bubble_bed2_y-15) ||
                            (bubble_bed2_xl + 10 <= x && x <= bubble_bed2_xl + 20 && current_bubble_bed2_y-32 <= y && y <= current_bubble_bed2_y-28) ||
                             (bubble_bed2_xl  + 10 <= x && x <= bubble_bed2_xl + 40 && current_bubble_bed2_y-45 <= y && y <= current_bubble_bed2_y-32)) ? 1 : 0;
                             
                             
wire bubble_bed_eyes_on_left2 = (in_bubble_left2 && !collision_left_reg2 && !collision_right_reg2) 
                                    && ((bubble_bed2_xl+15 <= x && x<= bubble_bed2_xl+18 && current_bubble_bed2_y-40 <= y && y <= current_bubble_bed2_y-37) || 
                                    (bubble_bed2_xl+22 <= x && x<= bubble_bed2_xl+25 && current_bubble_bed2_y-40 <= y && y <= current_bubble_bed2_y-37));  
                                     
wire bubble_bed_eyes_on_right2 = (in_bubble_right2 && !collision_left_reg2 && !collision_right_reg2)
                                     && ((bubble_bed2_xl+25 <= x && x<= bubble_bed2_xl+28 && current_bubble_bed2_y-40 <= y && y <= current_bubble_bed2_y-37) || 
                                    (bubble_bed2_xl+32 <= x && x<= bubble_bed2_xl+35 && current_bubble_bed2_y-40 <= y && y <= current_bubble_bed2_y-37));                               
                            
                            
                            
reg bubble_bed2_on_back;
wire [9:0] bubble_bed_cx2 =  bubble_bed2_xl+ BUBBLE_RADIUS_X; 
wire [9:0] bubble_bed_cy2 = bubble_bed2_yb - BUBBLE_RADIUS_Y; 
wire [10:0] bubble_circle_bed_left2; 
wire [10:0] bubble_circle_bed_right2;
 wire [10:0] bubble_circle_bed_top2;
 wire [10:0] bubble_circle_bed_bottom2;   
 //부딪히는 순간의 버블의 색을 기억함
 reg [2:0] back_cor_reg2;
 always@(posedge rst or posedge clk) begin
    if(rst) back_cor_reg2<=0;
    else if(bubble1_bed2_left || bubble1_bed2_right || bubble2_bed2_right || bubble2_bed2_left || bubble3_bed2_right || bubble3_bed2_left
    || bubble4_bed2_right || bubble4_bed2_left || bubble5_bed2_right || bubble5_bed2_left)
    back_cor_reg2 <= {bubble_cor1,bubble_cor2,bubble_cor3};
 end
 
 
 assign bubble_circle_bed_left2= bubble_bed_cx2 -  BUBBLE_RADIUS_X;  
 assign bubble_circle_bed_right2= bubble_bed_cx2 +  BUBBLE_RADIUS_X;
 assign bubble_circle_bed_top2 = bubble_bed_cy2 - BUBBLE_RADIUS_Y;
 assign bubble_circle_bed_bottom2 = bubble_bed_cy2 + BUBBLE_RADIUS_Y;
  
always @(*) begin
        // 타원의 방정식: ((x - cx)^2 / A^2) + ((y - cy)^2 / B^2) <= 1
        if (((x - bubble_bed_cx2) * (x - bubble_bed_cx2) * BUBBLE_RADIUS_Y_SQ) + 
            ((y - bubble_bed_cy2) * (y - bubble_bed_cy2) * BUBBLE_RADIUS_X_SQ) <= 
            BUBBLE_RADIUS_X_SQ * BUBBLE_RADIUS_Y_SQ)
            
            bubble_bed2_on_back = 1; // 타원 내부에 있으면 활성화
        else
            bubble_bed2_on_back = 0; // 타원 외부이면 비활성화
    end                            
                  
/////////bubble 1과의 충돌///////////////////////////////////////               
///////bubble이 왼쪽에서 충돌하는 경우 -> 오른쪽으로 가야함/////////////
wire bubble1_bed2_left = (bubble_bottom1 == bed_y_b2 && bubble_right1 >= bed_x_l2 
&& bubble_right1 <= bed_x_r2) && (current_y == WALL_2_Y_MIN) ? 1 : 0;

///////bubble이 오른쪽에서에서 충돌하는 경우 -> 왼쪽으로 가야함/////////////
wire bubble1_bed2_right = (bubble_bottom1 == bed_y_b2 && bubble_left1 >= bed_x_l2 
&& bubble_left1 <= bed_x_r2) && (current_y == WALL_2_Y_MIN)? 1 : 0;

//////////////버블 2 와의 충돌/////////////////////
wire bubble2_bed2_left = (bubble_bottom2 == bed_y_b2 && bubble_right2 >= bed_x_l2 
&& bubble_right2 <= bed_x_r2) && (current_y == WALL_2_Y_MIN) ? 1 : 0;

wire bubble2_bed2_right = (bubble_bottom2 == bed_y_b2 && bubble_left2 >= bed_x_l2 
&& bubble_left2 <= bed_x_r2) && (current_y == WALL_2_Y_MIN)? 1 : 0;

////////////버블3과의 충돌////////////////////
wire bubble3_bed2_left = (bubble_bottom3 == bed_y_b2 && bubble_right3 >= bed_x_l2 
&& bubble_right3 <= bed_x_r2) && (current_y == WALL_2_Y_MIN)? 1 : 0;

wire bubble3_bed2_right = ( bubble_bottom3 == bed_y_b2 && bubble_left3 >= bed_x_l2 
&& bubble_left3 <= bed_x_r2) && (current_y == WALL_2_Y_MIN)? 1 : 0;

/////////////버블 4와의 충돌//////////
wire bubble4_bed2_left = (bubble_bottom4 == bed_y_b2 && bubble_right4 >= bed_x_l2 
&& bubble_right4 <= bed_x_r2) && (current_y == WALL_2_Y_MIN)? 1 : 0;

wire bubble4_bed2_right = (bubble_bottom4 == bed_y_b2 && bubble_left4 >= bed_x_l2 
&& bubble_left4 <= bed_x_r2)&& (current_y == WALL_2_Y_MIN) ? 1 : 0;

/////////////버블 5와의 충돌//////////
wire bubble5_bed2_left = (bubble_bottom5 == bed_y_b2 && bubble_right5 >= bed_x_l2 
&& bubble_right5 <= bed_x_r2) && (current_y == WALL_2_Y_MIN)? 1 : 0;

wire bubble5_bed2_right = (bubble_bottom5 == bed_y_b2 && bubble_left5 >= bed_x_l2 
&& bubble_left5 <= bed_x_r2) && (current_y == WALL_2_Y_MIN) ? 1 : 0;

assign bubble_bed_reach_left2 = ( bubble_circle_bed_right2<= WALL_3_X_MIN) ? 1 : 0;
assign bubble_bed_reach_right2 = (bubble_circle_bed_left2 >= WALL_3_X_MAX && bubble_circle_bed_right2 <= 640) ? 1 : 0;
assign bubble_bed_reach_bottom2 = (bubble_circle_bed_bottom2 >= BOTTOM_Y_MIN) ? 1 : 0;

////////////////갇혔을때의 방향 정의////////////
always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_left2 <= 0;
                            //////////////괄호 유의//////////////////
    else if(current_y == WALL_2_Y_MIN && bed_left2 && ((bubble1_bed2_left == 1 || bubble1_bed2_right==1) || (bubble2_bed2_left == 1 || bubble2_bed2_right==1) || 
    (bubble3_bed2_left == 1 || bubble3_bed2_right==1) || (bubble4_bed2_left == 1 || bubble4_bed2_right==1) || (bubble5_bed2_left == 1 || bubble5_bed2_right==1)))
        in_bubble_left2 <= 1;
end

always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_right2 <= 0;
                            //////////////괄호 유의//////////////////
    else if(current_y == WALL_2_Y_MIN && bed_right2 && ((bubble1_bed2_left == 1 || bubble1_bed2_right==1) || (bubble2_bed2_left == 1 || bubble2_bed2_right==1) || 
    (bubble3_bed2_left == 1 || bubble3_bed2_right==1) || (bubble4_bed2_left == 1 || bubble4_bed2_right==1) || (bubble5_bed2_left == 1 || bubble5_bed2_right==1)))
        in_bubble_right2 <= 1;
end
                
always@(*) begin
    if(rst) next_bubble_bed2_vy = 0;
    else if((bubble_bed_reach_left2 || bubble_bed_reach_right2) && !bubble_bed_reach_bottom2) next_bubble_bed2_vy = 1 * BULLE_V;
    else if(bubble_bed_reach_bottom2) next_bubble_bed2_vy = 0;
    else next_bubble_bed2_vy = current_bubble_bed2_vy; 
end

always@(posedge clk or posedge rst) begin
    if(rst) next_bubble_bed2_vx <= 0;
    ///////////////그냥 넣기//////////////////
    else if(bubble1_bed2_left || bubble2_bed2_left || bubble3_bed2_left || bubble4_bed2_left || bubble5_bed2_left 
        || bubble1_back2_left || bubble2_back2_left || bubble3_back2_left || bubble4_back2_left || bubble5_back2_left) 
        next_bubble_bed2_vx <= 1 * BULLE_V;
    
    else if(bubble1_bed2_right || bubble2_bed2_right || bubble3_bed2_right || bubble4_bed2_right|| bubble5_bed2_right
     || bubble1_back1_right || bubble2_back2_right || bubble3_back2_right || bubble4_back2_right || bubble5_back2_right) 
     next_bubble_bed2_vx <= -1 * BULLE_V;
    
    else if(bubble_bed_reach_bottom2 && bubble_bed_reach_left2) next_bubble_bed2_vx <= 1 * BULLE_V;
    else if(bubble_bed_reach_bottom2 && bubble_bed_reach_right2) next_bubble_bed2_vx <= -1 * BULLE_V;
    else if(bubble_bed_reach_left2 || bubble_bed_reach_right2) next_bubble_bed2_vx <= 0; 
end

always@(posedge clk or posedge rst) begin
    if(rst) begin
        current_bubble_bed2_vx <= 0;
        current_bubble_bed2_vy <= 0;
    end
    
    else begin
        current_bubble_bed2_vx <= next_bubble_bed2_vx;
        current_bubble_bed2_vy <= next_bubble_bed2_vy;
    end
end

always@(posedge clk or posedge rst) begin
    if(rst) begin
        current_bubble_bed2_x <= 650;
        current_bubble_bed2_y <= 0;
    end

/////////////////그냥 넣기////////////////
else if((bubble1_bed2_left || bubble1_bed2_right || bubble2_bed2_right || bubble2_bed2_left ||
 bubble3_bed2_left || bubble3_bed2_right || bubble4_bed2_left || bubble4_bed2_right || bubble5_bed2_left || bubble5_bed2_right) && current_y == WALL_2_Y_MIN) begin
 
    current_bubble_bed2_x <= current_bed_x2;
    current_bubble_bed2_y <= current_bed_y2;
end

else if(collision_left_reg2 || collision_left_reg2) begin
    current_bubble_bed2_x <= 650;
    current_bubble_bed2_y <= 0;
end

else if(frame_tick) begin
    current_bubble_bed2_x <= current_bubble_bed2_x + next_bubble_bed2_vx;
    current_bubble_bed2_y <= current_bubble_bed2_y + next_bubble_bed2_vy;
end
end

////////////////////////두번째 충돌의 경우 - 물방울이 깨짐//////////////////
reg collision_left_reg2;
reg collision_right_reg2;

wire collision_left2 = ((current_y == current_bubble_bed2_y) && current_bubble_bed2_x <= current_x+45 && 
                        current_x+45 <= current_bubble_bed2_x + BUBBLE_SIZE) ? 1 : 0;
                        
wire collision_right2 = ((current_y == current_bubble_bed2_y) && current_bubble_bed2_x <= current_x && 
                        current_x <= current_bubble_bed2_x + BUBBLE_SIZE) ? 1 : 0;
                        
always@(posedge clk or posedge rst) begin
    if(rst) collision_left_reg2 <= 0;
    else if(collision_left2) collision_left_reg2 <= 1;
end            

always@(posedge clk or posedge rst) begin
    if(rst) collision_right_reg2 <= 0;
    else if(collision_left2) collision_right_reg2 <= 1;
end            
                
                   
///////////////악당3과의 충돌///////// 
 reg bubble_bed_left3;
 reg bubble_bed_right3;    
 
 reg[10:0] current_bubble_bed3_vx;
reg[10:0] current_bubble_bed3_vy;
reg[10:0] next_bubble_bed3_vx;
reg[10:0] next_bubble_bed3_vy;

reg[10:0] current_bubble_bed3_x;
reg[10:0] current_bubble_bed3_y;

reg in_bubble_left3;
reg in_bubble_right3;

wire [10:0] bubble_bed3_xl = current_bubble_bed3_x;
wire [10:0] bubble_bed3_xr = bubble_bed3_xl + BUBBLE_SIZE;
wire [10:0] bubble_bed3_yt = bubble_bed3_yb - BUBBLE_SIZE;
wire [10:0] bubble_bed3_yb = current_bubble_bed3_y;

//////////////왼쪽을 보고 있음/////////////
wire bubble_bed3_on_left = (in_bubble_left3 && !collision_left_reg3 && !collision_right_reg3)
                             && ((bubble_bed3_xl + 10 <= x && x <= bubble_bed3_xl + 40 && current_bubble_bed3_y - 28 <= y && y <= current_bubble_bed3_y - 15) ||
                             (bubble_bed3_xl + 30 <= x && x <= bubble_bed3_xl + 40 && current_bubble_bed3_y - 32 <= y && y <= current_bubble_bed3_y - 28) ||
                             (bubble_bed3_xl + 10 <= x && x <= bubble_bed3_xl + 40 && current_bubble_bed3_y - 45 <= y && y <= current_bubble_bed3_y - 32)) ? 1 : 0;
                  
//////////오른쪽을 보고 있음////////////                   
wire bubble_bed3_on_right = (in_bubble_right3 && !collision_left_reg3 && !collision_right_reg3) 
                            && ((bubble_bed3_xl + 10 <= x && x <= bubble_bed3_xl + 40 && current_bubble_bed3_y - 28 <= y && y <= current_bubble_bed3_y - 15) ||
                            (bubble_bed3_xl + 10 <= x && x <= bubble_bed3_xl + 20 && current_bubble_bed3_y - 32 <= y && y <= current_bubble_bed3_y - 28) ||
                             (bubble_bed3_xl + 10 <= x && x <= bubble_bed3_xl + 40 && current_bubble_bed3_y - 45 <= y && y <= current_bubble_bed3_y - 32)) ? 1 : 0;
                             
                             
wire bubble_bed_eyes_on_left3 = (in_bubble_left3 && !collision_left_reg3 && !collision_right_reg3) 
                                    && ((bubble_bed3_xl + 15 <= x && x <= bubble_bed3_xl + 18 && current_bubble_bed3_y - 40 <= y && y <= current_bubble_bed3_y - 37) || 
                                    (bubble_bed3_xl + 22 <= x && x <= bubble_bed3_xl + 25 && current_bubble_bed3_y - 40 <= y && y <= current_bubble_bed3_y - 37));  
                                     
wire bubble_bed_eyes_on_right3 = (in_bubble_right3 && !collision_left_reg3 && !collision_right_reg3)
                                     && ((bubble_bed3_xl + 25 <= x && x <= bubble_bed3_xl + 28 && current_bubble_bed3_y - 40 <= y && y <= current_bubble_bed3_y - 37) || 
                                    (bubble_bed3_xl + 32 <= x && x <= bubble_bed3_xl + 35 && current_bubble_bed3_y - 40 <= y && y <= current_bubble_bed3_y - 37));                               
                            
                            

reg bubble_bed3_on_back;
wire [9:0] bubble_bed_cx3 =  bubble_bed3_xl + BUBBLE_RADIUS_X; 
wire [9:0] bubble_bed_cy3 = bubble_bed3_yb - BUBBLE_RADIUS_Y; 
wire [10:0] bubble_circle_bed_left3; 
wire [10:0] bubble_circle_bed_right3;
 wire [10:0] bubble_circle_bed_top3;
 wire [10:0] bubble_circle_bed_bottom3;   
 //부딪히는 순간의 버블의 색을 기억함
 reg [2:0] back_cor_reg3;
 always@(posedge rst or posedge clk) begin
    if(rst) back_cor_reg3 <= 0;
    else if(bubble1_bed3_left || bubble1_bed3_right || bubble2_bed3_right || bubble2_bed3_left || bubble3_bed3_right || bubble3_bed3_left
    || bubble4_bed3_right || bubble4_bed3_left || bubble5_bed3_right || bubble5_bed3_left)
    back_cor_reg3 <= {bubble_cor1, bubble_cor2, bubble_cor3};
 end
 
 
 assign bubble_circle_bed_left3 = bubble_bed_cx3 -  BUBBLE_RADIUS_X;  
 assign bubble_circle_bed_right3 = bubble_bed_cx3 +  BUBBLE_RADIUS_X;
 assign bubble_circle_bed_top3 = bubble_bed_cy3 - BUBBLE_RADIUS_Y;
 assign bubble_circle_bed_bottom3 = bubble_bed_cy3 + BUBBLE_RADIUS_Y;
  
always @(*) begin
        // 타원의 방정식: ((x - cx)^2 / A^2) + ((y - cy)^2 / B^2) <= 1
        if (((x - bubble_bed_cx3) * (x - bubble_bed_cx3) * BUBBLE_RADIUS_Y_SQ) + 
            ((y - bubble_bed_cy3) * (y - bubble_bed_cy3) * BUBBLE_RADIUS_X_SQ) <= 
            BUBBLE_RADIUS_X_SQ * BUBBLE_RADIUS_Y_SQ)
            
            bubble_bed3_on_back = 1; // 타원 내부에 있으면 활성화
        else
            bubble_bed3_on_back = 0; // 타원 외부이면 비활성화
    end                            

/////////bubble 1과의 충돌///////////////////////////////////////               
///////bubble이 왼쪽에서 충돌하는 경우 -> 오른쪽으로 가야함/////////////
wire bubble1_bed3_left = (bubble_bottom1 == bed_y_b3 && bubble_right1 >= bed_x_l3 
&& bubble_right1 <= bed_x_r3) && (current_y == WALL_1_Y_MIN)? 1 : 0;

///////bubble이 오른쪽에서에서 충돌하는 경우 -> 왼쪽으로 가야함/////////////
wire bubble1_bed3_right = (bubble_bottom1 == bed_y_b3 && bubble_left1 >= bed_x_l3 
&& bubble_left1 <= bed_x_r3) ? 1 : 0;

//////////////버블 2 와의 충돌/////////////////////
wire bubble2_bed3_left = ( bubble_bottom2 == bed_y_b3 && bubble_right2 >= bed_x_l3 
&& bubble_right2 <= bed_x_r3) ? 1 : 0;

wire bubble2_bed3_right = ( bubble_bottom2 == bed_y_b3 && bubble_left2 >= bed_x_l3 
&& bubble_left2 <= bed_x_r3) ? 1 : 0;

////////////버블3과의 충돌////////////////////
wire bubble3_bed3_left = ( bubble_bottom3 == bed_y_b3 && bubble_right3 >= bed_x_l3 
&& bubble_right3 <= bed_x_r3) ? 1 : 0;

wire bubble3_bed3_right = (bubble_bottom3 == bed_y_b3 && bubble_left3 >= bed_x_l3 
&& bubble_left3 <= bed_x_r3) ? 1 : 0;

/////////////버블 4와의 충돌//////////
wire bubble4_bed3_left = (bubble_bottom4 == bed_y_b3 && bubble_right4 >= bed_x_l3 
&& bubble_right4 <= bed_x_r3) ? 1 : 0;

wire bubble4_bed3_right = ( bubble_bottom4 == bed_y_b3 && bubble_left4 >= bed_x_l3 
&& bubble_left4 <= bed_x_r3) ? 1 : 0;

/////////////버블 5와의 충돌//////////
wire bubble5_bed3_left = (bubble_bottom5 == bed_y_b3 && bubble_right5 >= bed_x_l3 
&& bubble_right5 <= bed_x_r3) ? 1 : 0;

wire bubble5_bed3_right = (bubble_bottom5 == bed_y_b3 && bubble_left5 >= bed_x_l3 
&& bubble_left5 <= bed_x_r3) ? 1 : 0;



assign bubble_bed_reach_left3 = (bubble_circle_bed_right3 <= WALL_3_X_MIN) ? 1 : 0;
assign bubble_bed_reach_right3 = (bubble_circle_bed_left3 >= WALL_3_X_MAX && bubble_circle_bed_right3 <= 640) ? 1 : 0;
assign bubble_bed_reach_bottom3 = (bubble_circle_bed_bottom3 >= BOTTOM_Y_MIN) ? 1 : 0;

////////////////갇혔을때의 방향 정의////////////
always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_left3 <= 0;
                            //////////////괄호 유의//////////////////
    else if(current_y == WALL_1_Y_MIN && bed_left3 && ((bubble1_bed3_left == 1 || bubble1_bed3_right == 1) || (bubble2_bed3_left == 1 || bubble2_bed3_right == 1) || 
    (bubble3_bed3_left == 1 || bubble3_bed3_right == 1) || (bubble4_bed3_left == 1 || bubble4_bed3_right == 1) || (bubble5_bed3_left == 1 || bubble5_bed3_right == 1)))
        in_bubble_left3 <= 1;
end

always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_right3 <= 0;
                            //////////////괄호 유의//////////////////
    else if(current_y == WALL_1_Y_MIN && bed_right3 && ((bubble1_bed3_left == 1 || bubble1_bed3_right == 1) || (bubble2_bed3_left == 1 || bubble2_bed3_right == 1) || 
    (bubble3_bed3_left == 1 || bubble3_bed3_right == 1) || (bubble4_bed3_left == 1 || bubble4_bed3_right == 1) || (bubble5_bed3_left == 1 || bubble5_bed3_right == 1)))
        in_bubble_right3 <= 1;
end
                
always@(*) begin
    if(rst) next_bubble_bed3_vy = 0;
    else if((bubble_bed_reach_left3 || bubble_bed_reach_right3) && !bubble_bed_reach_bottom3) next_bubble_bed3_vy = 1 * BULLE_V;
    else if(bubble_bed_reach_bottom3) next_bubble_bed3_vy = 0;
    else next_bubble_bed3_vy = current_bubble_bed3_vy; 
end

always@(posedge clk or posedge rst) begin
    if(rst) next_bubble_bed3_vx <= 0;
    ///////////////그냥 넣기//////////////////
    else if(bubble1_bed3_left || bubble2_bed3_left || bubble3_bed3_left || bubble4_bed3_left || bubble5_bed3_left || 
    bubble1_back3_left || bubble2_back3_left || bubble3_back3_left || bubble4_back3_left || bubble5_back3_left) next_bubble_bed3_vx <= 1 * BULLE_V;
    
    else if(bubble1_bed3_right || bubble2_bed3_right || bubble3_bed3_right || bubble4_bed3_right || bubble5_bed3_right
    || bubble1_back3_right || bubble2_back3_right || bubble3_back3_right || bubble4_back3_right || bubble5_back3_right) next_bubble_bed3_vx <= -1 * BULLE_V;
    
    else if(bubble_bed_reach_bottom3 && bubble_bed_reach_left3) next_bubble_bed3_vx <= 1 * BULLE_V;
    else if(bubble_bed_reach_bottom3 && bubble_bed_reach_right3) next_bubble_bed3_vx <= -1 * BULLE_V;
    else if(bubble_bed_reach_left3 || bubble_bed_reach_right3) next_bubble_bed3_vx <= 0; 
end

always@(posedge clk or posedge rst) begin
    if(rst) current_bubble_bed3_vy <= 0;
    else current_bubble_bed3_vy <= next_bubble_bed3_vy;
end

always@(posedge clk or posedge rst) begin
    if(rst) current_bubble_bed3_vx <= 0;
    else current_bubble_bed3_vx <= next_bubble_bed3_vx;
end



always@(posedge clk or posedge rst) begin
    if(rst) begin
        current_bubble_bed3_x <= 650;
        current_bubble_bed3_y <= 0;
    end
    
    

/////////////////그냥 넣기////////////////
else if(bubble1_bed3_left || bubble1_bed3_right || bubble2_bed3_right || bubble2_bed3_left ||
 bubble3_bed3_left || bubble3_bed3_right || bubble4_bed3_left || bubble4_bed3_right || bubble5_bed3_left || bubble5_bed3_right) begin
 
    current_bubble_bed3_x <= current_bed_x3;
    current_bubble_bed3_y <= current_bed_y3;
end

else if(collision_left_reg3 || collision_left_reg3 ) begin
    current_bubble_bed3_x <= 650;
    current_bubble_bed3_y <= 0;
end

else if(frame_tick) begin
    current_bubble_bed3_x <= current_bubble_bed3_x + next_bubble_bed3_vx;
    current_bubble_bed3_y <= current_bubble_bed3_y + next_bubble_bed3_vy;
end
end


reg collision_left_reg3;
reg collision_right_reg3;

wire collision_left3 = ((current_y == current_bubble_bed3_y) && current_bubble_bed3_x <= current_x+45 && 
                        current_x+45 <= current_bubble_bed3_x + BUBBLE_SIZE) ? 1 : 0;
                        
wire collision_right3 = ((current_y == current_bubble_bed3_y) && current_bubble_bed3_x <= current_x && 
                        current_x <= current_bubble_bed3_x + BUBBLE_SIZE) ? 1 : 0;
                        
always@(posedge clk or posedge rst) begin
    if(rst) collision_left_reg3 <= 0;
    else if(collision_left3) collision_left_reg3 <= 1;
end            

always@(posedge clk or posedge rst) begin
    if(rst) collision_right_reg3 <= 0;
    else if(collision_left3) collision_right_reg3 <= 1;
end
////////////bubble, back 충돌 제어/////////////////////////////////


////////////////bubble_1의 충돌//////////////

wire bubble1_back1_left = (bubble_bottom1 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_right1 
&& bubble_right1 <=  bubble_circle_bed_right1 ? 1 : 0;

wire bubble1_back1_right = (bubble_bottom1 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left1 
&& bubble_left1 <=  bubble_circle_bed_right1 ? 1 : 0;   

wire bubble1_back2_left = (bubble_bottom1 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_right1 
&& bubble_right1 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble1_back2_right = (bubble_bottom1 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_left1 
&& bubble_left1 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble1_back3_left = (bubble_bottom1 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3<= bubble_right1 
&& bubble_right1 <=  bubble_circle_bed_right3 ? 1 : 0;

wire bubble1_back3_right = (bubble_bottom1 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3 <= bubble_left1 
&& bubble_left1 <=  bubble_circle_bed_right3 ? 1 : 0;      


////////////////bubble_2의 충돌//////////////////
wire bubble2_back1_left = (bubble_bottom2 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_right2 
&& bubble_right2 <=  bubble_circle_bed_right1 ? 1 : 0;

wire bubble2_back1_right = (bubble_bottom2 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left2 
&& bubble_left2 <=  bubble_circle_bed_right1 ? 1 : 0;   

wire bubble2_back2_left = (bubble_bottom2 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_right2 
&& bubble_right2 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble2_back2_right = (bubble_bottom2 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_left2 
&& bubble_left2 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble2_back3_left = (bubble_bottom2 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3<= bubble_right2
&& bubble_right2 <=  bubble_circle_bed_right3 ? 1 : 0;

wire bubble2_back3_right = (bubble_bottom2 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3 <= bubble_left2 
&& bubble_left2 <=  bubble_circle_bed_right3 ? 1 : 0;      

/////////////bubble_3과의 충돌/////////////////////////

wire bubble3_back1_left = (bubble_bottom3 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_right3 
&& bubble_right3 <=  bubble_circle_bed_right1 ? 1 : 0;

wire bubble3_back1_right = (bubble_bottom3 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left3 
&& bubble_left3 <=  bubble_circle_bed_right1 ? 1 : 0;   

wire bubble3_back2_left = (bubble_bottom3 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_right3 
&& bubble_right3 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble3_back2_right = (bubble_bottom3 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_left3 
&& bubble_left3 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble3_back3_left = (bubble_bottom3 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3<= bubble_right3
&& bubble_right3 <=  bubble_circle_bed_right3 ? 1 : 0;

wire bubble3_back3_right = (bubble_bottom3 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3 <= bubble_left3 
&& bubble_left3 <=  bubble_circle_bed_right3 ? 1 : 0;  

/////////////bubble4와의 충돌////////////////

wire bubble4_back1_left = (bubble_bottom4 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1 <= bubble_right4
&& bubble_right4 <=  bubble_circle_bed_right1 ? 1 : 0;

wire bubble4_back1_right = (bubble_bottom4 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left4 
&& bubble_left4 <=  bubble_circle_bed_right1 ? 1 : 0;   

wire bubble4_back2_left = (bubble_bottom4 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_right4 
&& bubble_right4 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble4_back2_right = (bubble_bottom4 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_left4 
&& bubble_left4 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble4_back3_left = (bubble_bottom4 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3<= bubble_right4
&& bubble_right4 <=  bubble_circle_bed_right3 ? 1 : 0;

wire bubble4_back3_right = (bubble_bottom4 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3 <= bubble_left4 
&& bubble_left4 <=  bubble_circle_bed_right3 ? 1 : 0;  

/////////////bubble5와의 충돌////////////////

wire bubble5_back1_left = (bubble_bottom5 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1 <= bubble_right5
&& bubble_right5 <=  bubble_circle_bed_right1 ? 1 : 0;

wire bubble5_back1_right = (bubble_bottom5 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left5 
&& bubble_left5 <=  bubble_circle_bed_right1 ? 1 : 0;   

wire bubble5_back2_left = (bubble_bottom5 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_right5 
&& bubble_right5 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble5_back2_right = (bubble_bottom5 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_left5
&& bubble_left5 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble5_back3_left = (bubble_bottom5 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3<= bubble_right5
&& bubble_right5 <=  bubble_circle_bed_right3 ? 1 : 0;

wire bubble5_back3_right = (bubble_bottom5 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3 <= bubble_left5 
&& bubble_left5 <=  bubble_circle_bed_right3 ? 1 : 0;  


   
                
///////////////////////////////충돌 검사 + complete/////////////////////////////////////////////
reg [3:1]bed_array; //악당 늘리고 배열로 확장시키기
reg complete;

always@(posedge clk or posedge rst) begin
    if(rst) bed_array <= 0;
    else if(collision_left1 || collision_right1) bed_array[1] <= 1;
    else if(collision_left2 || collision_right2) bed_array[2] <= 1;
    else if(collision_left3 || collision_right3) bed_array[3] <= 1;
end

always@ (posedge clk or posedge rst) begin
    if(rst) complete<=0;
    else if(bed_array[1]==1 && bed_array[2]==1 && bed_array[3]==1)  complete<=1;
end

wire complete_on = complete && (300 <= x && x <= 350 && 200 <= y && y <= 250);
//////////////////////die 검사/////////////////////////////
wire die_left1 = current_y == current_bed_y1 && current_bed_x1 <= current_x + 45 && current_x + 45 <= current_bed_x1+30;
wire die_right1 = current_y == current_bed_y1 && current_bed_x1 <= current_x && current_x <= current_bed_x1+30;

wire die_left2 = current_y == current_bed_y2 && current_bed_x2 <= current_x + 45 && current_x + 45 <= current_bed_x2+30;
wire die_right2 = current_y == current_bed_y2 && current_bed_x2 <= current_x && current_x <= current_bed_x2+30;

wire die_left3 = current_y == current_bed_y3 && current_bed_x3 <= current_x + 45 && current_x + 45 <= current_bed_x3+30;
wire die_right3 = current_y == current_bed_y3 && current_bed_x3 <= current_x && current_x <= current_bed_x3+30;
reg die_reg;

always@(posedge clk or posedge rst) begin
    if(rst) die_reg <= 0;
    else if(die_left1 || die_right1 || die_left2 || die_right2 || die_left3 || die_right3) die_reg <= 1;
end

wire die_on = die_reg && (300 <= x && x <= 350 && 200 <= y && y <= 250);



///////////////rgb출력///////////////////////////////////////////////////////////

assign rgb =  (die_on == 1 ) ? 3'b100 :
              (complete_on == 1 ) ? 3'b111 :
              
              //////////////플레이어/////////////////////////
              (plyer_eyes_on_left == 1 && left) ? 3'b000 :
              (plyer_eyes_on_right == 1 && right) ? 3'b000 :
              (player_right_on == 1 && right) ? 3'b010 :
              (player_left_on == 1 && left) ? 3'b010 :
              
              //////////////////충돌제어//////////////////////
              /////////////악당1과의 충돌///////////////////////////////////////
              (bubble_bed_eyes_on_left1 == 1) ? 3'b000 :
              (bubble_bed_eyes_on_right1 == 1) ? 3'b000 :
              (bubble_bed1_on_left == 1) ? 3'b101 :
              (bubble_bed1_on_right == 1) ? 3'b101 :
              (bubble_bed1_on_back &&  back_cor_reg == 3'b100 && !collision_left_reg1 && !collision_right_reg1) ? 3'b011:
              (bubble_bed1_on_back &&  back_cor_reg == 3'b010 && !collision_left_reg1 && !collision_right_reg1) ? 3'b010:
              (bubble_bed1_on_back && back_cor_reg == 3'b001 && !collision_left_reg1 && !collision_right_reg1 ) ? 3'b110:
              
              /////////////악당2과의 충돌///////////////////////////////////////
              (bubble_bed_eyes_on_left2 == 1) ? 3'b000 :
              (bubble_bed_eyes_on_right2 == 1) ? 3'b000 :
              (bubble_bed2_on_left == 1) ? 3'b101 :
              (bubble_bed2_on_right == 1) ? 3'b101 :
              (bubble_bed2_on_back &&  back_cor_reg2 == 3'b100 && !collision_left_reg2 && !collision_right_reg2) ? 3'b011:
              (bubble_bed2_on_back &&  back_cor_reg2 == 3'b010 && !collision_left_reg2 && !collision_right_reg2) ? 3'b010:
              (bubble_bed2_on_back && back_cor_reg2 == 3'b001 && !collision_left_reg2 && !collision_right_reg2 ) ? 3'b110:

                /////////////악당3과의 충돌///////////////////////////////////////
              (bubble_bed_eyes_on_left3 == 1) ? 3'b000 :
              (bubble_bed_eyes_on_right3 == 1) ? 3'b000 :
              (bubble_bed3_on_left == 1) ? 3'b101 :
              (bubble_bed3_on_right == 1) ? 3'b101 :
              (bubble_bed3_on_back &&  back_cor_reg3 == 3'b100 && !collision_left_reg3 && !collision_right_reg3) ? 3'b011:
              (bubble_bed3_on_back &&  back_cor_reg3 == 3'b010 && !collision_left_reg3 && !collision_right_reg3) ? 3'b010:
              (bubble_bed3_on_back && back_cor_reg3 == 3'b001 && !collision_left_reg3 && !collision_right_reg3 ) ? 3'b110:
              
              //////////////버블////////////////////////////////////
              (bubble_on1== 1) ? 3'b011: 
              (bubble_on2== 1) ? 3'b010: 
              (bubble_on3== 1) ? 3'b110: 
              (bubble_on4== 1) ? 3'b011: 
              (bubble_on5== 1) ? 3'b010:
              
              //////////악당1///////////////////////|
              (bed_eyes_on_right1 == 1 && bed_right1) ? 3'b000 :
              (bed_eyes_on_left1 == 1 && bed_left1) ? 3'b000 :
              (bed_on1_left == 1 && bed_left1) ? 3'b101:
              (bed_on1_right == 1&& bed_right1) ? 3'b101:
              
              //////////악당2///////////////////////|
              (bed_eyes_on_right2 == 1 && bed_right2) ? 3'b000 :
              (bed_eyes_on_left2 == 1 && bed_left2) ? 3'b000 :
              (bed_on2_left == 1 && bed_left2) ? 3'b101:
              (bed_on2_right == 1&& bed_right2) ? 3'b101:
              
              //////악당3////////////////////////////////////
              
              (bed_eyes_on_right3 == 1 && bed_right3) ? 3'b000 :
              (bed_eyes_on_left3 == 1 && bed_left3) ? 3'b000 :
              (bed_on3_left == 1 && bed_left3) ? 3'b101:
              (bed_on3_right == 1&& bed_right3) ? 3'b101:
              
              ///////////////////벽////////////////////////////
              (bottom_on == 1) ? 3'b100 :
              (left_on == 1) ? 3'b100 :
              (right_on == 1) ? 3'b100 :
              (top_on == 1) ? 3'b100 :
              (wall_1_on == 1) ? 3'b100 :
              (wall_2_on== 1) ? 3'b100 :
              (wall_3_on == 1) ? 3'b100 : 
              (ladder_1_on) ? 3'b100 : 
              (ladder_2_on) ? 3'b100 : 
              (ladder_3_on) ? 3'b100 : 
              3'b000;
             


endmodule
