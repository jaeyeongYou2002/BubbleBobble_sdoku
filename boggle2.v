module boggle_graph_mod2 (clk, rst, x, y, key, key_pulse, rgb, bos_complete, die_on);
parameter H = 5;
parameter W = 10;

parameter MAX_X = 640; 
parameter MAX_Y = 480;  

parameter PLAYER_Y_SIZE = 20; 
parameter PLAYER_Y = 170; 

parameter PLAYER_X_SIZE = 40; 
parameter PLAYER_X = 4; 

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


parameter FLOOR3_A_TOP = 92 - H;
parameter FLOOR3_A_BOTTOM = 122 - H;
parameter FLOOR3_A_LEFT = 110;
parameter FLOOR3_A_RIGHT = 240;

parameter FLOOR3_B_TOP = 92 - H;
parameter FLOOR3_B_BOTTOM = 122 - H;
parameter FLOOR3_B_LEFT = 400;
parameter FLOOR3_B_RIGHT = 530;

parameter FLOOR2_A_TOP = 194- H;
parameter FLOOR2_A_BOTTOM = 224- H;
parameter FLOOR2_A_LEFT = 110;
parameter FLOOR2_A_RIGHT = 250;

parameter FLOOR2_B_TOP = 194 - H;
parameter FLOOR2_B_BOTTOM = 224- H; 
parameter FLOOR2_B_LEFT = 390;
parameter FLOOR2_B_RIGHT = 530;

parameter FLOOR1_A_TOP = 296 - H;
parameter FLOOR1_A_BOTTOM = 326 - H;
parameter FLOOR1_A_LEFT = 110;
parameter FLOOR1_A_RIGHT = 260;

parameter FLOOR1_B_TOP = 296 - H;
parameter FLOOR1_B_BOTTOM = 326 - H;
parameter FLOOR1_B_LEFT = 380;
parameter FLOOR1_B_RIGHT = 530;

parameter FLOOR0_A_TOP = 350 + 2*H;
parameter FLOOR0_A_BOTTOM = 380 + 2*H;
parameter FLOOR0_A_LEFT = 30;
parameter FLOOR0_A_RIGHT = 230;

parameter FLOOR0_B_TOP = 350 + 2*H;
parameter FLOOR0_B_BOTTOM = 380 + 2*H;
parameter FLOOR0_B_LEFT = 410;
parameter FLOOR0_B_RIGHT = 610;

parameter WALL_A_TOP = 92 - H;
parameter WALL_A_BOTTOM = 326 - H;
parameter WALL_A_LEFT = 110;
parameter WALL_A_RIGHT = 130;

parameter WALL_B_TOP = 92 - H;
parameter WALL_B_BOTTOM = 326 - H;
parameter WALL_B_LEFT = 510;
parameter WALL_B_RIGHT = 530;

input clk, rst;
input [9:0] x, y;
input [4:0] key, key_pulse; 
output [2:0] rgb; 
output bos_complete, die_on;

wire floor0_a_on = (FLOOR0_A_LEFT <= x && x <= FLOOR0_A_RIGHT) && (FLOOR0_A_TOP <= y && y <= FLOOR0_A_BOTTOM);
wire floor0_b_on = (FLOOR0_B_LEFT <= x && x <= FLOOR0_B_RIGHT) && (FLOOR0_B_TOP <= y && y <= FLOOR0_B_BOTTOM);

wire floor1_a_on = (FLOOR1_A_LEFT <= x && x <= FLOOR1_A_RIGHT) && (FLOOR1_A_TOP <= y && y <= FLOOR1_A_BOTTOM);
wire floor1_b_on = (FLOOR1_B_LEFT <= x && x <= FLOOR1_B_RIGHT) && (FLOOR1_B_TOP <= y && y <= FLOOR1_B_BOTTOM);

wire floor2_a_on = (FLOOR2_A_LEFT <= x && x <= FLOOR2_A_RIGHT) && (FLOOR2_A_TOP <= y && y <= FLOOR2_A_BOTTOM);
wire floor2_b_on = (FLOOR2_B_LEFT <= x && x <= FLOOR2_B_RIGHT) && (FLOOR2_B_TOP <= y && y <= FLOOR2_B_BOTTOM);

wire floor3_a_on = (FLOOR3_A_LEFT <= x && x <= FLOOR3_A_RIGHT) && (FLOOR3_A_TOP <= y && y <= FLOOR3_A_BOTTOM);
wire floor3_b_on = (FLOOR3_B_LEFT <= x && x <= FLOOR3_B_RIGHT) && (FLOOR3_B_TOP <= y && y <= FLOOR3_B_BOTTOM);

wire wall_a_on = (WALL_A_LEFT <= x && x <= WALL_A_RIGHT) && (WALL_A_TOP <= y && y <= WALL_A_BOTTOM);
wire wall_b_on = (WALL_B_LEFT <= x && x <= WALL_B_RIGHT) && (WALL_B_TOP <= y && y <= WALL_B_BOTTOM);

wire bottom_on = (BOTTOM_X_MIN <= x && BOTTOM_X_MAX >= x && BOTTOM_Y_MIN <= y && BOTTOM_Y_MAX >= y ) ? 1 : 0;
wire top_on = (TOP_X_MIN <= x && TOP_X_MAX >= x && TOP_Y_MIN <= y && TOP_Y_MAX >= y ) ? 1 : 0;
wire right_on = (RIGHT_X_MIN <= x && RIGHT_X_MAX >= x && RIGHT_Y_MIN <= y && RIGHT_Y_MAX >= y ) ? 1 : 0;
wire left_on = (LEFT_X_MIN <= x && LEFT_X_MAX >= x && LEFT_Y_MIN <= y && LEFT_Y_MAX >= y ) ? 1 : 0;



///////////////////////////////////player 제어////////////////////////////////////////////////////////
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
wire player_x_conter = current_x + 20;

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
     
     
reg left, right;    
reg jump_en; 
reg [9:0] jump_counter;
     
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



/////////////////player - x좌표 제어//////////////////

assign frame_tick = (y==MAX_Y-1 && x==MAX_X-1)? 1 : 0; 

always @* begin
    if (rst) next_x <= MAX_X/2;
    else if (frame_tick==1 && key==5'b10000 && 
    
            player_x_l >=  LEFT_X_MAX + PLAYER_X  &&  
    
            !(current_y == FLOOR1_A_TOP && player_x_l <= WALL_A_RIGHT) &&
            
            !(current_y == FLOOR2_A_TOP && player_x_l <= WALL_A_RIGHT)) 
            
            next_x = current_x - PLAYER_X;
   
    
    else if (frame_tick==1 && key==5'h1f && 
             player_x_r <= RIGHT_X_MIN - PLAYER_X && 
             !(current_y == FLOOR1_B_TOP && player_x_r >= WALL_B_LEFT)  && 
            
            !(current_y == FLOOR2_B_TOP && player_x_r >= WALL_B_LEFT))
            
            next_x = current_x + PLAYER_X;
     
    else next_x = current_x; 
end



always @(posedge clk, posedge rst) begin
    if (rst) current_x <= MAX_X/2;
    else current_x <= next_x; 
end

/////////////////player - y좌표 제어//////////////////

clk_divider #(.DIVISOR(160000)) clk_d(clk, rst , clk_out);

wire land = ((current_y==BOTTOM_Y_MIN)  
|| (current_y==FLOOR0_A_TOP && (FLOOR0_A_LEFT <= current_x + 20 && current_x + 20 <= FLOOR0_A_RIGHT)) 
|| (current_y==FLOOR0_B_TOP && (FLOOR0_B_LEFT <= current_x + 20 && current_x + 20 <= FLOOR0_B_RIGHT)) 

|| (current_y==FLOOR1_A_TOP) && (WALL_A_RIGHT <= current_x + 20 && current_x + 20 <= FLOOR1_A_RIGHT) 
|| (current_y==FLOOR1_B_TOP) && (FLOOR1_B_LEFT <= current_x + 20 && current_x + 20 <= WALL_B_LEFT)

|| (current_y==FLOOR2_A_TOP) && (WALL_A_RIGHT <= current_x + 20 && current_x + 20 <= FLOOR2_A_RIGHT)
|| (current_y==FLOOR2_B_TOP) && (FLOOR2_B_LEFT <= current_x + 20 && current_x + 20 <= WALL_B_LEFT)

|| (current_y==FLOOR3_A_TOP) && (WALL_A_RIGHT <= current_x + 20 && current_x + 20 <= FLOOR3_A_RIGHT)
|| (current_y==FLOOR3_B_TOP) && (FLOOR3_B_LEFT <= current_x + 20 && current_x + 20 <= WALL_B_LEFT)) ? 1 : 0; 

//////////////////jump_en, jump_counter 생성//////////////////////////
always@(posedge clk or posedge rst) begin
    if(rst) jump_en <= 0;
    else if(key_pulse == 5'h1e) jump_en <= 1;
    else if(jump_counter==60 && !land) jump_en <= 0;
end


always@(posedge clk_out or posedge rst) begin
if(rst) jump_counter<=0;
else if(jump_en) begin
    if(jump_counter==60) jump_counter <= 0;
    else jump_counter <= jump_counter+1;
end
end

/////////////////////y좌표 제어/////////////////////////
always@(posedge clk_out or posedge rst) begin
    if(rst) current_y <= 459;
    
    else if(jump_en ) begin
        current_y <= current_y-2; //점프하는 동안 빠르게 점프
    end
    
    else if(jump_counter == 60) begin //점프하는 동안 느리게 착지
        if(land) current_y <= current_y;
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

////////////////악당1 생성////////////
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
    else if(bubble1_bed1_left== 1 || bubble1_bed1_right ==1 || bubble2_bed1_left== 1 || bubble2_bed1_right == 1
           || bubble3_bed1_left== 1 || bubble3_bed1_right ==1 || bubble4_bed1_left== 1 || bubble4_bed1_right ==1 || 
           bubble5_bed1_left== 1 || bubble5_bed1_right ==1) in_bubble1 <= 1;
end


////////////////bed_left, bed_right 제어///////////////                  
always@(posedge clk or posedge rst) begin
    if(rst) bed_left1 <= 1;
    else if(bed1_reach_right || (bed1_reach_wall && bed1_down_reg)) bed_left1 <= 1;
    else if(bed1_reach_left)  bed_left1 <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) bed_right1 <= 0;
    else if(bed1_reach_left) bed_right1 <= 1;
    else if(bed1_reach_right || (bed1_reach_wall && bed1_down_reg))  bed_right1 <= 0;
end                 

////////////////bed1 y제어 - current_bed_y1///////////////////

/////////////떨어지는 bed1 구현을 위한 reg신호/////////////

reg bed1_down_reg;
always@(posedge clk or posedge rst) begin
    if(rst) bed1_down_reg <= 0;
    else if(current_bed_y1 == FLOOR3_A_TOP && bed1_reach_floor3_left) bed1_down_reg <= 1;
    else if(current_bed_y1 == FLOOR0_A_TOP) bed1_down_reg <= 0;
end
 always@(posedge clk_out or posedge rst) begin
    if(rst) current_bed_y1<=TOP_Y_MAX+30;
    
    /////////////////괄호 유의///////////////////////////
     else if(bed_start &&  (!bed1_down_reg) && ((bubble1_bed1_left==0 &&   bubble1_bed1_right==0) && (bubble2_bed1_left==0 && bubble2_bed1_right==0) && 
    (bubble3_bed1_left==0 &&   bubble3_bed1_right==0) && (bubble4_bed1_left==0 &&   bubble4_bed1_right==0) && (bubble5_bed1_left==0 &&   bubble5_bed1_right==0))) begin
            
                if(current_bed_y1 < FLOOR3_A_TOP) current_bed_y1 <= current_bed_y1 + 1;
    end
    
    else if(bed1_down_reg) begin
            if(current_bed_y1 < FLOOR0_A_TOP ) current_bed_y1 <= current_bed_y1 + 1;
            end    
    
    
    //////그냥 넣기/////////
    else if(bubble2_bed1_left || bubble2_bed1_right || bubble1_bed1_left || bubble1_bed1_right
    || bubble3_bed1_left || bubble3_bed1_right || bubble4_bed1_left || bubble4_bed1_right|| bubble5_bed1_left || bubble5_bed1_right) current_bed_y1 <= 550; 
 end
 
////////////////bed1 x제어 - current_bed_x1///////////////////
wire bed1_reach_right = (bed_x_r1 >= FLOOR3_A_RIGHT) ? 1 : 0;
wire bed1_reach_left = (bed_x_l1 <= LEFT_X_MAX) ? 1 : 0;
wire bed1_reach_floor3_left = (bed_x_r1 <= FLOOR3_A_LEFT)  ? 1 : 0;
wire bed1_reach_wall = (bed_x_r1 >= WALL_A_LEFT-1) ? 1 : 0;

//다음 변위 결정

always@* begin 
    if(rst) next_bed_x1_vx = -2;
    else if(!bed1_down_reg && bed1_reach_right) next_bed_x1_vx = -2;
    else if(!bed1_down_reg && bed1_reach_left) next_bed_x1_vx = 2;
    
    else if(bed1_down_reg ) begin 
            if(bed1_reach_wall) next_bed_x1_vx = -2;
            else if(bed1_reach_left) next_bed_x1_vx = 2; 
            else next_bed_x1_vx = current_bed_x1_vx;
    end
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
    else if(bubble1_bed2_left == 1 || bubble1_bed2_right == 1 || bubble2_bed2_left == 1 || bubble2_bed2_right == 1
    || bubble3_bed2_left == 1 || bubble3_bed2_right == 1|| bubble4_bed2_left == 1 || bubble4_bed2_right == 1 || bubble5_bed2_left == 1 || bubble5_bed2_right == 1) in_bubble2 <= 1;
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
    
    if(current_bed_y2 < FLOOR2_B_TOP) current_bed_y2 <= current_bed_y2 + 1;
    end
    ///////////그냥 넣기///////////////////
    else if(bubble1_bed2_left || bubble1_bed2_right || bubble2_bed2_left || bubble2_bed2_right || 
    bubble3_bed2_left || bubble3_bed2_right || bubble4_bed2_left || bubble4_bed2_right|| bubble5_bed2_left || bubble5_bed2_right) current_bed_y2 <= 550; 
 end
 
////////////////bed2 x제어 - current_bed_x2///////////////////
wire bed2_reach_right = (bed_x_r2 >= WALL_B_LEFT) ? 1 : 0;
wire bed2_reach_left = (bed_x_l2 <= FLOOR2_B_LEFT) ? 1 : 0;

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
    if(current_bed_y3<FLOOR1_B_TOP) current_bed_y3 <= current_bed_y3 + 1;
    end
    
    else if(bubble1_bed3_left== 1 || bubble1_bed3_right ==1 || bubble2_bed3_left== 1 || bubble2_bed3_right == 1
           || bubble3_bed3_left== 1 || bubble3_bed3_right ==1 || bubble4_bed3_left== 1 || bubble4_bed3_right ==1 || 
           bubble5_bed3_left== 1 || bubble5_bed3_right ==1) current_bed_y3 <= 550; 
 end
 

wire bed3_reach_right = (bed_x_r3 >= FLOOR1_A_RIGHT) ? 1 : 0;
wire bed3_reach_left = (bed_x_l3 <= WALL_A_RIGHT) ? 1 : 0;


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

////////////////////공격1//////////////////////////////////////////////
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
        if(bubble_speed1==100) bubble_speed1 <= 0;
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


////////////////////////////////////////////////////////////////////////
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
// ila_0 i(clk, collision_left1, collision_right1,bubble_bed_reach_bottom1,bubble2_bed1_right,bubble2_bed1_left,current_bubble_bed1_y,current_y);
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
&& bubble_right1 <= bed_x_r1) ? 1 : 0;

///////bubble이 오른쪽에서에서 충돌하는 경우 -> 왼쪽으로 가야함/////////////
wire bubble1_bed1_right = ( bubble_bottom1 == bed_y_b1 && bubble_left1 >= bed_x_l1 
&& bubble_left1 <= bed_x_r1) ? 1 : 0;

//////////////버블 2 와의 충돌/////////////////////
wire bubble2_bed1_left = (bubble_bottom2 == bed_y_b1 && bubble_right2 >= bed_x_l1 
&& bubble_right2 <= bed_x_r1) ? 1 : 0;

wire bubble2_bed1_right = (bubble_bottom2 == bed_y_b1 && bubble_left2 >= bed_x_l1 
&& bubble_left2 <= bed_x_r1) ? 1 : 0;

////////////버블3과의 충돌////////////////////
wire bubble3_bed1_left = (bubble_bottom3 == bed_y_b1 && bubble_right3 >= bed_x_l1 
&& bubble_right3 <= bed_x_r1) ? 1 : 0;

wire bubble3_bed1_right = (bubble_bottom3 == bed_y_b1 && bubble_left3 >= bed_x_l1 
&& bubble_left3 <= bed_x_r1) ? 1 : 0;

////////////버블 4와의 충돌//////////////////
wire bubble4_bed1_left = (bubble_bottom4 == bed_y_b1 && bubble_right4 >= bed_x_l1 
&& bubble_right4 <= bed_x_r1) ? 1 : 0;

wire bubble4_bed1_right = (bubble_bottom4 == bed_y_b1 && bubble_left4 >= bed_x_l1 
&& bubble_left4 <= bed_x_r1) ? 1 : 0;

////////////버블 5와의 충돌/////////////
wire bubble5_bed1_left = (bubble_bottom5 == bed_y_b1 && bubble_right5 >= bed_x_l1 
&& bubble_right5 <= bed_x_r1) ? 1 : 0;

wire bubble5_bed1_right = (bubble_bottom5 == bed_y_b1 && bubble_left5 >= bed_x_l1 
&& bubble_left5 <= bed_x_r1) ? 1 : 0;

assign bubble_bed_reach_right1 = (bubble_circle_bed_left1 >= FLOOR0_A_RIGHT && current_bubble_bed1_x != 650 && current_bubble_bed1_y != 0)  ? 1 : 0;
assign bubble_bed_reach_bottom1 = (bubble_circle_bed_bottom1 >= BOTTOM_Y_MIN && current_bubble_bed1_x != 650 && current_bubble_bed1_y != 0) ? 1 : 0;
wire bubble_bed_reach_left_wall_1 = (bubble_circle_bed_left1<= LEFT_X_MAX && current_bubble_bed1_x != 650 && current_bubble_bed1_y != 0) ? 1 : 0;
wire bubble_bed_reach_right_wall_1 = (bubble_circle_bed_right1 >= RIGHT_X_MIN && current_bubble_bed1_x != 650 && current_bubble_bed1_y != 0) ? 1 : 0;

////////////////갇혔을때의 방향 정의////////////
always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_left1 <= 0;
                            //////////////괄호 유의//////////////////
    else if(bed_left1 && ((bubble1_bed1_left == 1 || bubble1_bed1_right==1) || (bubble2_bed1_left == 1 || bubble2_bed1_right==1) || 
    (bubble3_bed1_left == 1 || bubble3_bed1_right==1) || (bubble4_bed1_left == 1 || bubble4_bed1_right==1) || (bubble5_bed1_left == 1 || bubble5_bed1_right==1)))
        in_bubble_left1 <= 1;
end

always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_right1 <= 0;
                            //////////////괄호 유의//////////////////
    else if(bed_right1 && ((bubble1_bed1_left == 1 || bubble1_bed1_right==1) || (bubble2_bed1_left == 1 || bubble2_bed1_right==1) ||
    (bubble3_bed1_left == 1 || bubble3_bed1_right==1) || (bubble4_bed1_left == 1 || bubble4_bed1_right==1)|| (bubble5_bed1_left == 1 || bubble5_bed1_right==1)))
         in_bubble_right1 <= 1;
end
////////////////////////////////////////////////반띵///////////////////////////////////////////////////////
/////////////변위 제어/////////////
always@(*) begin
    if(rst) next_bubble_bed1_vy = 0;
    else if((bubble_bed_reach_right1) && !bubble_bed_reach_bottom1) next_bubble_bed1_vy = 1 * BULLE_V;
    else if(bubble_bed_reach_bottom1) next_bubble_bed1_vy = 0;
    else next_bubble_bed1_vy = current_bubble_bed1_vy; 
end

///////////////wall3, right, left에 닿으면 그 신호를 유지시킴//////////////////
reg wall1_right_reg;
always@(posedge clk or posedge rst) begin
    if(rst) wall1_right_reg <= 0;
    else if(bubble_bed_reach_bottom1 && bubble_bed_reach_right_wall_1) wall1_right_reg <= 1;
    else if(bubble_bed_reach_bottom1 && bubble_bed_reach_left_wall_1) wall1_right_reg <= 0;

    else if( bubble2_back1_left || bubble3_back1_left || bubble4_back1_left || bubble5_back1_left) wall1_right_reg <= 0;
    else if(bubble2_back1_right || bubble3_back1_right || bubble4_back1_right || bubble5_back1_right) wall1_right_reg <= 1;
end

reg wall1_left_reg;
always@(posedge clk or posedge rst) begin
    if(rst) wall1_left_reg <= 0;
    else if(bubble_bed_reach_bottom1 && bubble_bed_reach_left_wall_1) wall1_left_reg <= 1;
    else if(bubble_bed_reach_bottom1 && bubble_bed_reach_right_wall_1) wall1_left_reg <= 0;
    else if(bubble1_back1_left || bubble2_back1_left || bubble3_back1_left || bubble4_back1_left || bubble5_back1_left) wall1_left_reg <= 1;
    else if(bubble1_back1_right || bubble2_back1_right || bubble3_back1_right || bubble4_back1_right || bubble5_back1_right) wall1_left_reg <= 0;
end


always@(posedge clk or posedge rst) begin
    if(rst) next_bubble_bed1_vx <= 0;
    ///////////////그냥 넣기//////////////////
    else if(bubble1_bed1_left || bubble2_bed1_left || bubble3_bed1_left || bubble4_bed1_left || bubble5_bed1_left ||
    bubble2_back1_left || bubble3_back1_left || bubble4_back1_left || bubble5_back1_left 
    || (bubble_bed_reach_left_wall_1 && !bubble_bed_reach_bottom1)) 
    next_bubble_bed1_vx <= 1 * BULLE_V;
    
    else if(bubble1_bed1_right || bubble2_bed1_right || bubble3_bed1_right || bubble4_bed1_right || bubble5_bed1_right
     || bubble2_back1_right || bubble3_back1_right || bubble4_back1_right || bubble5_back1_right)
     next_bubble_bed1_vx <= -1 * BULLE_V;
    
    else if(bubble_bed_reach_right1 && !bubble_bed_reach_bottom1) next_bubble_bed1_vx <= 0;
    
    else if(bubble_bed_reach_bottom1 && wall1_left_reg) next_bubble_bed1_vx <= 1 * BULLE_V;
    
    else if(bubble_bed_reach_bottom1 && wall1_right_reg) next_bubble_bed1_vx <= -1 * BULLE_V;
    
    else if(bubble_circle_bed_bottom1 != FLOOR0_A_TOP && !wall1_right_reg && !wall1_left_reg) next_bubble_bed1_vx <= 1 * BULLE_V;
     
    
    
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
else if(bubble1_bed1_left || bubble1_bed1_right || bubble2_bed1_right || bubble2_bed1_left ||
 bubble3_bed1_left || bubble3_bed1_right || bubble4_bed1_left || bubble4_bed1_right || bubble5_bed1_left || bubble5_bed1_right) begin
 
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
                        current_x+45 <= current_bubble_bed1_x + BUBBLE_SIZE) || ((current_y+1 == current_bubble_bed1_y) && current_bubble_bed1_x <= current_x+45 && 
                        current_x+45 <= current_bubble_bed1_x + BUBBLE_SIZE) ? 1 : 0;
                        
wire collision_right1 = ((current_y == current_bubble_bed1_y) && current_bubble_bed1_x <= current_x && 
                        current_x <= current_bubble_bed1_x + BUBBLE_SIZE) || ((current_y +1 == current_bubble_bed1_y) && current_bubble_bed1_x <= current_x && 
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
&& bubble_right1 <= bed_x_r2) ? 1 : 0;

///////bubble이 오른쪽에서에서 충돌하는 경우 -> 왼쪽으로 가야함/////////////
wire bubble1_bed2_right = (bubble_bottom1 == bed_y_b2 && bubble_left1 >= bed_x_l2 
&& bubble_left1 <= bed_x_r2) ? 1 : 0;

//////////////버블 2 와의 충돌/////////////////////
wire bubble2_bed2_left = (bubble_bottom2 == bed_y_b2 && bubble_right2 >= bed_x_l2 
&& bubble_right2 <= bed_x_r2) ? 1 : 0;

wire bubble2_bed2_right = (bubble_bottom2 == bed_y_b2 && bubble_left2 >= bed_x_l2 
&& bubble_left2 <= bed_x_r2) ? 1 : 0;

////////////버블3과의 충돌////////////////////
wire bubble3_bed2_left = (bubble_bottom3 == bed_y_b2 && bubble_right3 >= bed_x_l2 
&& bubble_right3 <= bed_x_r2) ? 1 : 0;

wire bubble3_bed2_right = ( bubble_bottom3 == bed_y_b2 && bubble_left3 >= bed_x_l2 
&& bubble_left3 <= bed_x_r2) ? 1 : 0;

/////////////버블 4와의 충돌//////////
wire bubble4_bed2_left = (bubble_bottom4 == bed_y_b2 && bubble_right4 >= bed_x_l2 
&& bubble_right4 <= bed_x_r2) ? 1 : 0;

wire bubble4_bed2_right = (bubble_bottom4 == bed_y_b2 && bubble_left4 >= bed_x_l2 
&& bubble_left4 <= bed_x_r2) ? 1 : 0;

/////////////버블 5와의 충돌//////////
wire bubble5_bed2_left = (bubble_bottom5 == bed_y_b2 && bubble_right5 >= bed_x_l2 
&& bubble_right5 <= bed_x_r2) ? 1 : 0;

wire bubble5_bed2_right = (bubble_bottom5 == bed_y_b2 && bubble_left5 >= bed_x_l2 
&& bubble_left5 <= bed_x_r2) ? 1 : 0;

assign bubble_bed_reach_left2 = (bubble_circle_bed_right2 <= FLOOR2_B_LEFT) ? 1 : 0;
assign bubble_bed_reach_right2 = (bubble_circle_bed_right2 >= WALL_B_LEFT && current_bubble_bed2_x != 650 && current_bubble_bed2_y != 0)  ? 1 : 0;
assign bubble_bed_reach_bottom2 = (bubble_circle_bed_bottom2 >= BOTTOM_Y_MIN && current_bubble_bed2_x != 650 && current_bubble_bed2_y != 0) ? 1 : 0;
wire bubble_bed_reach_left_wall2 = (bubble_circle_bed_left2 <= LEFT_X_MAX && current_bubble_bed2_x != 650 && current_bubble_bed2_y != 0) ? 1 : 0;
wire bubble_bed_reach_right_wall2 = (bubble_circle_bed_right2 >= RIGHT_X_MIN && current_bubble_bed2_x != 650 && current_bubble_bed2_y != 0) ? 1 : 0;

////////////////갇혔을때의 방향 정의////////////
always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_left2 <= 0;
                            //////////////괄호 유의//////////////////
    else if(bed_left2 && ((bubble1_bed2_left == 1 || bubble1_bed2_right==1) || (bubble2_bed2_left == 1 || bubble2_bed2_right==1) || 
    (bubble3_bed2_left == 1 || bubble3_bed2_right==1) || (bubble4_bed2_left == 1 || bubble4_bed2_right==1) || (bubble5_bed2_left == 1 || bubble5_bed2_right==1)))
        in_bubble_left2 <= 1;
end

always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_right2 <= 0;
                            //////////////괄호 유의//////////////////
    else if(bed_right2 && ((bubble1_bed2_left == 1 || bubble1_bed2_right==1) || (bubble2_bed2_left == 1 || bubble2_bed2_right==1) || 
    (bubble3_bed2_left == 1 || bubble3_bed2_right==1) || (bubble4_bed2_left == 1 || bubble4_bed2_right==1) || (bubble5_bed2_left == 1 || bubble5_bed2_right==1)))
        in_bubble_right2 <= 1;
end
                
always@(*) begin
    if(rst) next_bubble_bed2_vy = 0;
    else if((bubble_bed_reach_left2) && !bubble_bed_reach_bottom2) next_bubble_bed2_vy = 1 * BULLE_V;
    else if(bubble_bed_reach_bottom2) next_bubble_bed2_vy = 0;
    else next_bubble_bed2_vy = current_bubble_bed2_vy; 
end

///////////////wall2, right, left에 닿으면 그 신호를 유지시킴//////////////////
reg wall2_right_reg;
always@(posedge clk or posedge rst) begin
    if(rst) wall2_right_reg <= 0;
    else if(bubble_bed_reach_bottom2 && bubble_bed_reach_right_wall2) wall2_right_reg <= 1;
    else if(bubble_bed_reach_bottom2 && bubble_bed_reach_left_wall2) wall2_right_reg <= 0;
    else if(bubble1_back2_left || bubble3_back2_left || bubble4_back2_left || bubble5_back2_left) wall2_right_reg <= 0;
    else if(bubble1_back2_right || bubble3_back2_right || bubble4_back2_right || bubble5_back2_right) wall2_right_reg <= 1;
end

reg wall2_left_reg;
always@(posedge clk or posedge rst) begin
    if(rst) wall2_left_reg <= 0;
    else if(bubble_bed_reach_bottom2 && bubble_bed_reach_left_wall2) wall2_left_reg <= 1;
    else if(bubble_bed_reach_bottom2 && bubble_bed_reach_right_wall2) wall2_left_reg <= 0;
    else if(bubble1_back2_left || bubble3_back2_left || bubble4_back2_left || bubble5_back2_left) wall2_left_reg <= 1;
    else if(bubble1_back2_right || bubble3_back2_right || bubble4_back2_right || bubble5_back2_right) wall2_left_reg <= 0;
end


always@(posedge clk or posedge rst) begin
    if(rst) next_bubble_bed2_vx <= 0;
    ///////////////그냥 넣기//////////////////
    else if(bubble1_bed2_left || bubble2_bed2_left || bubble3_bed2_left || bubble4_bed2_left || bubble5_bed2_left || 
    bubble1_back2_left || bubble3_back2_left || bubble4_back2_left || bubble5_back2_left) 
    next_bubble_bed2_vx <= 1 * BULLE_V;
    
    else if(bubble1_bed2_right || bubble2_bed2_right || bubble3_bed2_right || bubble4_bed2_right || bubble5_bed2_right
    || bubble1_back2_right || bubble3_back2_right || bubble4_back2_right || bubble5_back2_right || 
    (bubble_bed_reach_right2 && !bubble_bed_reach_bottom2))
     next_bubble_bed2_vx <= -1 * BULLE_V;
    
    else if(bubble_bed_reach_left2 && !bubble_bed_reach_bottom2) next_bubble_bed2_vx <= 0;
    
    else if(bubble_bed_reach_bottom2 && wall2_left_reg) next_bubble_bed2_vx <= 1 * BULLE_V;
    
    else if(bubble_bed_reach_bottom2 && wall2_right_reg) next_bubble_bed2_vx <= -1 * BULLE_V;
    
    else if(bubble_circle_bed_bottom2 != FLOOR2_B_TOP && !wall2_right_reg && !wall2_left_reg) next_bubble_bed2_vx <= 1 * BULLE_V;
     
    
    
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
else if(bubble1_bed2_left || bubble1_bed2_right || bubble2_bed2_right || bubble2_bed2_left ||
 bubble3_bed2_left || bubble3_bed2_right || bubble4_bed2_left || bubble4_bed2_right || bubble5_bed2_left || bubble5_bed2_right) begin
 
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
&& bubble_right1 <= bed_x_r3) ? 1 : 0;

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




assign bubble_bed_reach_left3 = (bubble_circle_bed_left3 <= FLOOR1_A_LEFT) ? 1 : 0;
assign bubble_bed_reach_right3 = (bubble_circle_bed_left3 >= FLOOR1_A_RIGHT && current_bubble_bed3_x != 650 && current_bubble_bed3_y != 0)  ? 1 : 0;
assign bubble_bed_reach_bottom3 = (bubble_circle_bed_bottom3 >= BOTTOM_Y_MIN && current_bubble_bed3_x != 650 && current_bubble_bed3_y != 0) ? 1 : 0;
wire bubble_bed_reach_left_wall3 = (bubble_circle_bed_left3 <= LEFT_X_MAX && current_bubble_bed3_x != 650 && current_bubble_bed3_y != 0) ? 1 : 0;
wire bubble_bed_reach_right_wall3 = (bubble_circle_bed_right3 >= RIGHT_X_MIN && current_bubble_bed3_x != 650 && current_bubble_bed3_y != 0) ? 1 : 0;

////////////////갇혔을때의 방향 정의////////////
always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_left3 <= 0;
     //////////////괄호 유의//////////////////
    else if(bed_left3 && ((bubble1_bed3_left == 1 || bubble1_bed3_right == 1) || (bubble2_bed3_left == 1 || bubble2_bed3_right == 1) || 
    (bubble3_bed3_left == 1 || bubble3_bed3_right == 1) || (bubble4_bed3_left == 1 || bubble4_bed3_right == 1) ||
     (bubble5_bed3_left == 1 || bubble5_bed3_right == 1)))
        in_bubble_left3 <= 1;
end

always@(posedge clk or posedge rst) begin
    if(rst) in_bubble_right3 <= 0;
                            //////////////괄호 유의//////////////////
    else if(bed_right3 && ((bubble1_bed3_left == 1 || bubble1_bed3_right == 1) || (bubble2_bed3_left == 1 || bubble2_bed3_right == 1) || 
    (bubble3_bed3_left == 1 || bubble3_bed3_right == 1) || (bubble4_bed3_left == 1 || bubble4_bed3_right == 1) || (bubble5_bed3_left == 1 || bubble5_bed3_right == 1)))
        in_bubble_right3 <= 1;
end
                
always@(*) begin
    if(rst) next_bubble_bed3_vy = 0;
    else if((bubble_bed_reach_right3) && !bubble_bed_reach_bottom3) next_bubble_bed3_vy = 1 * BULLE_V;
    else if(bubble_bed_reach_bottom3) next_bubble_bed3_vy = 0;
    else next_bubble_bed3_vy = current_bubble_bed3_vy; 
end

///////////////wall3, right, left에 닿으면 그 신호를 유지시킴//////////////////
reg wall3_right_reg;
always@(posedge clk or posedge rst) begin
    if(rst) wall3_right_reg <= 0;
    else if(bubble_bed_reach_bottom3 && bubble_bed_reach_right_wall3) wall3_right_reg <= 1;
    else if(bubble_bed_reach_bottom3 && bubble_bed_reach_left_wall3) wall3_right_reg <= 0;
    else if(bubble1_back3_left || bubble2_back3_left || bubble3_back3_left || bubble4_back3_left || bubble5_back3_left) wall3_right_reg <= 0;
    else if(bubble1_back3_right || bubble2_back3_right || bubble3_back3_right || bubble4_back3_right || bubble5_back3_right) wall3_right_reg <= 1;
end

reg wall3_left_reg;
always@(posedge clk or posedge rst) begin
    if(rst) wall3_left_reg <= 0;
    else if(bubble_bed_reach_bottom3 && bubble_bed_reach_left_wall3) wall3_left_reg <= 1;
    else if(bubble_bed_reach_bottom3 && bubble_bed_reach_right_wall3) wall3_left_reg <= 0;
    else if(bubble1_back3_left || bubble2_back3_left || bubble3_back3_left || bubble4_back3_left || bubble5_back3_left) wall3_left_reg <= 1;
    else if(bubble1_back3_right || bubble2_back3_right || bubble3_back3_right || bubble4_back3_right || bubble5_back3_right) wall3_left_reg <= 0;
end


always@(posedge clk or posedge rst) begin
    if(rst) next_bubble_bed3_vx <= 0;
    ///////////////그냥 넣기//////////////////
    else if(bubble1_bed3_left || bubble2_bed3_left || bubble3_bed3_left || bubble4_bed3_left || bubble5_bed3_left || 
    bubble1_back3_left || bubble2_back3_left || bubble3_back3_left || bubble4_back3_left || bubble5_back3_left 
    || (bubble_bed_reach_left3 && !bubble_bed_reach_bottom3)) 
    next_bubble_bed3_vx <= 1 * BULLE_V;
    
    else if(bubble1_bed3_right || bubble2_bed3_right || bubble3_bed3_right || bubble4_bed3_right || bubble5_bed3_right
    || bubble1_back3_right || bubble2_back3_right || bubble3_back3_right || bubble4_back3_right || bubble5_back3_right)
     next_bubble_bed3_vx <= -1 * BULLE_V;
    
    else if(bubble_bed_reach_right3 && !bubble_bed_reach_bottom3) next_bubble_bed3_vx <= 0;
    
    else if(bubble_bed_reach_bottom3 && wall3_left_reg) next_bubble_bed3_vx <= 1 * BULLE_V;
    
    else if(bubble_bed_reach_bottom3 && wall3_right_reg) next_bubble_bed3_vx <= -1 * BULLE_V;
    
    else if(bubble_circle_bed_bottom3 != FLOOR1_A_TOP && !wall3_right_reg && !wall3_left_reg) next_bubble_bed3_vx <= 1 * BULLE_V;
     
    
    
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
else if(collision_left_reg3 || collision_left_reg3) begin
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
wire bubble2_back1_left = ((bubble_bottom2 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_right2 
&& bubble_right2 <=  bubble_circle_bed_right1) || ((bubble_bottom2 +1 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_right2 
&& bubble_right2 <=  bubble_circle_bed_right1) ? 1 : 0;

wire bubble2_back1_right = ((bubble_bottom2 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left2 
&& bubble_left2 <=  bubble_circle_bed_right1) || ((bubble_bottom2+1 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left2 
&& bubble_left2 <=  bubble_circle_bed_right1) ? 1 : 0;   

wire bubble2_back2_left = (bubble_bottom2 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_right2 
&& bubble_right2 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble2_back2_right = (bubble_bottom2 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_left2 
&& bubble_left2 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble2_back3_left = (bubble_bottom2 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3<= bubble_right2
&& bubble_right2 <=  bubble_circle_bed_right3 ? 1 : 0;

wire bubble2_back3_right = (bubble_bottom2 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3 <= bubble_left2 
&& bubble_left2 <=  bubble_circle_bed_right3 ? 1 : 0;      

/////////////bubble_3과의 충돌/////////////////////////

wire bubble3_back1_left = ((bubble_bottom3 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_right3 
&& bubble_right3 <=  bubble_circle_bed_right1) || ((bubble_bottom3 + 1== bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_right3 
&& bubble_right3 <=  bubble_circle_bed_right1) ? 1 : 0;

wire bubble3_back1_right = ((bubble_bottom3 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left3 
&& bubble_left3 <=  bubble_circle_bed_right1) || ((bubble_bottom3 + 1== bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left3 
&& bubble_left3 <=  bubble_circle_bed_right1) ? 1 : 0;   

wire bubble3_back2_left = (bubble_bottom3 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_right3 
&& bubble_right3 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble3_back2_right = (bubble_bottom3 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_left3 
&& bubble_left3 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble3_back3_left = (bubble_bottom3 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3<= bubble_right3
&& bubble_right3 <=  bubble_circle_bed_right3 ? 1 : 0;

wire bubble3_back3_right = (bubble_bottom3 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3 <= bubble_left3 
&& bubble_left3 <=  bubble_circle_bed_right3 ? 1 : 0;  

/////////////bubble4와의 충돌////////////////

wire bubble4_back1_left = ((bubble_bottom4 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1 <= bubble_right4
&& bubble_right4 <=  bubble_circle_bed_right1) || ((bubble_bottom4 + 1== bubble_circle_bed_bottom1) && bubble_circle_bed_left1 <= bubble_right4
&& bubble_right4 <=  bubble_circle_bed_right1) ? 1 : 0;

wire bubble4_back1_right = ((bubble_bottom4 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left4 
&& bubble_left4 <=  bubble_circle_bed_right1) || ((bubble_bottom4 + 1== bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left4 
&& bubble_left4 <=  bubble_circle_bed_right1) ? 1 : 0;   

wire bubble4_back2_left = (bubble_bottom4 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_right4 
&& bubble_right4 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble4_back2_right = (bubble_bottom4 == bubble_circle_bed_bottom2) && bubble_circle_bed_left2<= bubble_left4 
&& bubble_left4 <=  bubble_circle_bed_right2 ? 1 : 0;

wire bubble4_back3_left = (bubble_bottom4 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3<= bubble_right4
&& bubble_right4 <=  bubble_circle_bed_right3 ? 1 : 0;

wire bubble4_back3_right = (bubble_bottom4 == bubble_circle_bed_bottom3) && bubble_circle_bed_left3 <= bubble_left4 
&& bubble_left4 <=  bubble_circle_bed_right3 ? 1 : 0;  

/////////////bubble5와의 충돌////////////////

wire bubble5_back1_left = ((bubble_bottom5 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1 <= bubble_right5
&& bubble_right5 <=  bubble_circle_bed_right1) || 

((bubble_bottom5 + 1 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1 <= bubble_right5
 && bubble_right5 <=  bubble_circle_bed_right1)? 1 : 0;


wire bubble5_back1_right = ((bubble_bottom5 == bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left5 
&& bubble_left5 <=  bubble_circle_bed_right1) || 

((bubble_bottom5 + 1== bubble_circle_bed_bottom1) && bubble_circle_bed_left1<= bubble_left5 
&& bubble_left5 <=  bubble_circle_bed_right1) ? 1 : 0;   




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
    else if(die_left1 || die_right1 || die_left2 || die_right2 || die_left3 || die_right3 || collision_bos) die_reg <= 1;
end

wire die_on = die_reg && (300 <= x && x <= 350 && 200 <= y && y <= 250) ;

///////////////////보스 스테이지////////////////

reg [10:0] current_bos_x;
reg [10:0] next_bos_x;
reg [10:0] next_bos_x_vx;
reg [10:0] current_bos_x_vx;

reg [10:0] current_bos_y;

wire [10:0] bos_x_l;
wire [10:0] bos_y_b;
wire [10:0] bos_x_r;
wire [10:0] bos_y_t;
reg bos_left, bos_right;

reg bos_start;


assign bos_x_l = current_bos_x;
assign bos_y_b = current_bos_y;

assign bos_x_r = bos_x_l + 270;
assign bos_y_t = bos_y_b - 270;


wire bos_on_left =((bos_x_l <= x && x <= bos_x_l + 270 && bos_y_b-130 <= y && y <= bos_y_b) ||
                 (bos_x_l + 90 <= x && x <= bos_x_l + 270 && bos_y_b-190 <= y && y <= bos_y_b-130) ||
                  (bos_x_l <= x && x <= bos_x_l + 270 && bos_y_b-320 <= y && y <= bos_y_b-190)) ? 1 : 0;
                  
                  
wire bos_on_right = ((bos_x_l <= x && x <= bos_x_l + 270 && bos_y_b-130 <= y && y <= bos_y_b) ||
                 (bos_x_l <= x && x <= bos_x_l + 180 && bos_y_b-190 <= y && y <= bos_y_b-130) ||
                  (bos_x_l <= x && x <= bos_x_l + 270 && bos_y_b-320 <= y && y <= bos_y_b-190)) ? 1 : 0;

wire bos_eyes_on_left = ((bos_x_l+40<= x && x<= bos_x_l+70 && bos_y_b - 270 <= y && y <= bos_y_b-240) || 
                                    (bos_x_l+110 <= x && x<= bos_x_l+140 && bos_y_b - 270 <= y && y <= bos_y_b-240)); 
                                                      
wire bos_eyes_on_right = ((bos_x_l+130 <= x && x<= bos_x_l+160 && bos_y_b - 270 <= y && y <= bos_y_b-240) || 
                                    (bos_x_l+200 <= x && x<= bos_x_l+230 && bos_y_b - 270 <= y && y <= bos_y_b-240));                  
                  
                  

////////////////bos_left, bos_right 제어///////////////                  
always@(posedge clk or posedge rst) begin
    if(rst) bos_left <= 1;
    else if(bos_reach_right) bos_left <= 1;
    else if(bos_reach_left)  bos_left <= 0;
end

always@(posedge clk or posedge rst) begin
    if(rst) bos_right <= 0;
    else if(bos_reach_left) bos_right <= 1;
    else if(bos_reach_right)  bos_right <= 0;
end                 

always@(posedge clk or posedge rst) begin
    if(rst) bos_start <= 0;
    else if(complete) bos_start <= 1;
end


////////////////bos y 제어 - current_bos_y///////////////////
 always@(posedge clk_out or posedge rst) begin
    if(rst) current_bos_y<=0;
    
    /////////////////괄호 유의///////////////////////////
    else if(bos_start) begin 
    if(current_bos_y < BOTTOM_Y_MIN) 
    current_bos_y <= current_bos_y + 1;
     end
  end 
 
////////////////bos x 제어 - current_bos_x///////////////////
wire bos_reach_right = (bos_x_r >= RIGHT_X_MIN) ? 1 : 0;
wire bos_reach_left = (bos_x_l <= LEFT_X_MAX) ? 1 : 0;


//다음 변위 결정

always@* begin 
    if(rst) next_bos_x_vx = -2;
    else if(bos_reach_right) next_bos_x_vx = -2;
    else if(bos_reach_left) next_bos_x_vx = 2;
    else next_bos_x_vx = current_bos_x_vx;
end

always@(posedge clk or posedge rst) begin
if(rst) current_bos_x_vx <= -2;
else current_bos_x_vx <= next_bos_x_vx;
end

always@* begin
    if(rst) next_bos_x = MAX_X/2;
    else if(frame_tick) next_bos_x = current_bos_x + current_bos_x_vx;
    else next_bos_x = current_bos_x;
end

always@(posedge clk or posedge rst) begin
 if(rst) current_bos_x<= MAX_X/2;
 else current_bos_x <= next_bos_x;
end


/////////////////////다이아 몬드 1/////////////////////////

reg [10:0] current_diamond1_x;
reg [10:0] next_diamond1_x;

reg [10:0] current_diamond1_y;

wire [10:0] diamond_x_l;
wire [10:0] diamond_y_b;
wire [10:0] diamond_x_r;
wire [10:0] diamond_y_t;
reg diamond1_left, diamond1_right;

reg diamond1_start;

assign diamond_x_l = current_diamond1_x;
assign diamond_y_b = current_diamond1_y;

assign diamond_x_r = diamond_x_l + 50;
assign diamond_y_t = diamond_y_b - 50;

wire diamond_on = 
      (y == diamond_y_b && diamond_x_l + 25 == x) ||
    (y == diamond_y_b - 1 && diamond_x_l + 24 <= x && x <= diamond_x_l + 26) ||
    (y == diamond_y_b - 2 && diamond_x_l + 23 <= x && x <= diamond_x_l + 27) ||
    (y == diamond_y_b - 3 && diamond_x_l + 22 <= x && x <= diamond_x_l + 28) ||
    (y == diamond_y_b - 4 && diamond_x_l + 21 <= x && x <= diamond_x_l + 29) ||
    (y == diamond_y_b - 5 && diamond_x_l + 20 <= x && x <= diamond_x_l + 30) ||
    (y == diamond_y_b - 6 && diamond_x_l + 19 <= x && x <= diamond_x_l + 31) ||
    (y == diamond_y_b - 7 && diamond_x_l + 18 <= x && x <= diamond_x_l + 32) ||
    (y == diamond_y_b - 8 && diamond_x_l + 17 <= x && x <= diamond_x_l + 33) ||
    (y == diamond_y_b - 9 && diamond_x_l + 16 <= x && x <= diamond_x_l + 34) ||
    (y == diamond_y_b - 10 && diamond_x_l + 15 <= x && x <= diamond_x_l + 35) ||
    (y == diamond_y_b - 11 && diamond_x_l + 14 <= x && x <= diamond_x_l + 36) ||
    (y == diamond_y_b - 12 && diamond_x_l + 13 <= x && x <= diamond_x_l + 37) ||
    (y == diamond_y_b - 13 && diamond_x_l + 12 <= x && x <= diamond_x_l + 38) ||
    (y == diamond_y_b - 14 && diamond_x_l + 11 <= x && x <= diamond_x_l + 39) ||
    (y == diamond_y_b - 15 && diamond_x_l + 10 <= x && x <= diamond_x_l + 40) ||
    (y == diamond_y_b - 16 && diamond_x_l + 9 <= x && x <= diamond_x_l + 41) ||
    (y == diamond_y_b - 17 && diamond_x_l + 8 <= x && x <= diamond_x_l + 42) ||
    (y == diamond_y_b - 18 && diamond_x_l + 7 <= x && x <= diamond_x_l + 43) ||
    (y == diamond_y_b - 19 && diamond_x_l + 6 <= x && x <= diamond_x_l + 44) ||
    (y == diamond_y_b - 20 && diamond_x_l + 5 <= x && x <= diamond_x_l + 45) ||
    (y == diamond_y_b - 21 && diamond_x_l + 4 <= x && x <= diamond_x_l + 46) ||
    (y == diamond_y_b - 22 && diamond_x_l + 3 <= x && x <= diamond_x_l + 47) ||
    (y == diamond_y_b - 23 && diamond_x_l + 2 <= x && x <= diamond_x_l + 48) ||
    (y == diamond_y_b - 24 && diamond_x_l + 1 <= x && x <= diamond_x_l + 49) ||
    (y == diamond_y_b - 25 && diamond_x_l <= x && x <= diamond_x_l + 50) ||
    (y == diamond_y_b - 26 && diamond_x_l + 1 <= x && x <= diamond_x_l + 49) ||
    (y == diamond_y_b - 27 && diamond_x_l + 2 <= x && x <= diamond_x_l + 48) ||
    (y == diamond_y_b - 28 && diamond_x_l + 3 <= x && x <= diamond_x_l + 47) ||
    (y == diamond_y_b - 29 && diamond_x_l + 4 <= x && x <= diamond_x_l + 46) ||
    (y == diamond_y_b - 30 && diamond_x_l + 5 <= x && x <= diamond_x_l + 45) ||
    (y == diamond_y_b - 31 && diamond_x_l + 6 <= x && x <= diamond_x_l + 44) ||
    (y == diamond_y_b - 32 && diamond_x_l + 7 <= x && x <= diamond_x_l + 43) ||
    (y == diamond_y_b - 33 && diamond_x_l + 8 <= x && x <= diamond_x_l + 42) ||
    (y == diamond_y_b - 34 && diamond_x_l + 9 <= x && x <= diamond_x_l + 41) ||
    (y == diamond_y_b - 35 && diamond_x_l + 10 <= x && x <= diamond_x_l + 40) ||
    (y == diamond_y_b - 36 && diamond_x_l + 11 <= x && x <= diamond_x_l + 39) ||
    (y == diamond_y_b - 37 && diamond_x_l + 12 <= x && x <= diamond_x_l + 38) ||
    (y == diamond_y_b - 38 && diamond_x_l + 13 <= x && x <= diamond_x_l + 37) ||
    (y == diamond_y_b - 39 && diamond_x_l + 14 <= x && x <= diamond_x_l + 36) ||
    (y == diamond_y_b - 40 && diamond_x_l + 15 <= x && x <= diamond_x_l + 35) ||
    (y == diamond_y_b - 41 && diamond_x_l + 16 <= x && x <= diamond_x_l + 34) ||
    (y == diamond_y_b - 42 && diamond_x_l + 17 <= x && x <= diamond_x_l + 33) ||
    (y == diamond_y_b - 43 && diamond_x_l + 18 <= x && x <= diamond_x_l + 32) ||
    (y == diamond_y_b - 44 && diamond_x_l + 19 <= x && x <= diamond_x_l + 31) ||
    (y == diamond_y_b - 45 && diamond_x_l + 20 <= x && x <= diamond_x_l + 30) ||
    (y == diamond_y_b - 46 && diamond_x_l + 21 <= x && x <= diamond_x_l + 29) ||
    (y == diamond_y_b - 47 && diamond_x_l + 22 <= x && x <= diamond_x_l + 28) ||
    (y == diamond_y_b - 48 && diamond_x_l + 23 <= x && x <= diamond_x_l + 27) ||
    (y == diamond_y_b - 49 && diamond_x_l + 24 <= x && x <= diamond_x_l + 26) ||
    (y == diamond_y_b - 50 && diamond_x_l + 25 <= x && x <= diamond_x_l + 25); 

always@(posedge clk or posedge rst) begin
    if(rst) diamond1_start <= 0;
    else if(complete) diamond1_start <= 1;
end


////////////////diamond1 y 제어 - current_diamond1_y/////////////////// 
 always@(posedge clk_out or posedge rst) begin
    if(rst) current_diamond1_y<=0;
    
    /////////////////괄호 유의/////////////////////////// 
    else if(diamond1_start) begin 
    if(current_diamond1_y < FLOOR3_A_TOP) 
            current_diamond1_y <= current_diamond1_y + 1;
     end
  end 
 
always@(posedge clk or posedge rst) begin
 if(rst) current_diamond1_x<= MAX_X/2-25;
 else current_diamond1_x<= MAX_X/2-25;
end  




////////////////////////////////////////////////////////
///////////////보스, 다이아몬드와 충동제어////////////////////////

wire collision_bos = (bos_x_l <= current_x && current_x <= bos_x_r && bos_y_t <= current_y  && current_y <= bos_y_b) 
            || (bos_x_l <= current_x+40 && current_x+40 <= bos_x_r && bos_y_t <= current_y  && current_y <= bos_y_b);


assign bos_complete = (diamond_x_l <= bubble_left4 && bubble_left4 <= diamond_x_r && bubble_bottom4 == diamond_y_b) 
                    ||(diamond_x_l <= bubble_right4 && bubble_right4 <= diamond_x_r && bubble_bottom4 == diamond_y_b)
                    ||(diamond_x_l <= bubble_right5 && bubble_right5 <= diamond_x_r && bubble_bottom5 == diamond_y_b)
                    ||(diamond_x_l <= bubble_right5 && bubble_right5 <= diamond_x_r && bubble_bottom5 == diamond_y_b);

reg bos_complete_reg;

always@(posedge clk or posedge rst) begin
if(rst) bos_complete_reg<=0;
else if(bos_complete) bos_complete_reg <= 1;
end

wire bos_complete_on = bos_complete_reg && (300 <= x && x <= 350 && 200 <= y && y <= 250) ;




///////////////////rgb///////////////////////////
assign rgb =
            (bos_complete_on == 1) ? 3'b111 :   
            (die_on == 1) ? 3'b100 :  
              
            ////////player////////////////
            ( plyer_eyes_on_left == 1 && left) ? 3'b000 :
              (plyer_eyes_on_right == 1 && right) ? 3'b000 :
              (player_right_on == 1 && right) ? 3'b010 :
              (player_left_on == 1 && left) ? 3'b010 :
              
              ///////////다이아 몬드////////
              (diamond_on == 1) ? 3'b110 :
              
              
              //////////보스1///////////////////////
              (bos_eyes_on_right == 1 && bos_right) ? 3'b000 :
              (bos_eyes_on_left == 1 && bos_left) ? 3'b000 :
              (bos_on_left == 1 && bos_left) ? 3'b101:
              (bos_on_right == 1&& bos_right) ? 3'b101:
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
              /////////////벽/////////////////////////
              (bottom_on == 1) ? 3'b100 :
              (left_on == 1) ? 3'b100 :
              (right_on == 1) ? 3'b100 :
              (top_on == 1) ? 3'b100 :
              (floor0_a_on == 1) ? 3'b100 :
              (floor0_b_on == 1) ? 3'b100 :
              (floor1_a_on == 1) ? 3'b100 :
              (floor1_b_on == 1) ? 3'b100 :
              (floor2_a_on == 1) ? 3'b100 :
              (floor2_b_on == 1) ? 3'b100 :
              (floor3_a_on == 1) ? 3'b100 :
              (floor3_b_on == 1) ? 3'b100 :
              (wall_a_on == 1) ? 3'b100 :
              (wall_b_on == 1) ? 3'b100 : 
              3'b000;
endmodule