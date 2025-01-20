module gameCharacter (
    input wire clk,
    input wire rst_n,
    input wire e_key,              // 'e' 키 입력 (1이면 눌림)
    input wire [9:0] x_pos,        // 캐릭터의 X 위치
    input wire [9:0] y_pos,        // 캐릭터의 Y 위치
    output reg [9:0] out_y_pos,    // 최종 Y 위치 (점프 및 착지 후)
    output reg [9:0] out_x_pos     // 최종 X 위치
);

    // 상태 정의
    
    parameter IDLE = 3'b000;    // 대기 상태
     parameter JUMP = 3'b001;      // 점프 상태
     parameter  FALL = 3'b010;      // 하강 상태
     parameter  LAND = 3'b011;       // 착지 상태
    

    // 상태 레지스터
    reg [2:0] player_state, next_player_state;

    // 점프 높이와 하강 속도
    parameter JUMP_HEIGHT = 50;    // 점프 높이
    parameter LAND_HEIGHT = 160;   // 착지 Y 좌표

    // 벽의 X, Y 좌표 범위
    parameter WALL_X_MIN = 400;
    parameter WALL_X_MAX = 639;
    parameter WALL_Y_MIN = 150;
    parameter WALL_Y_MAX = 170;

    // 상태 머신
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            player_state <= IDLE;
        else
            player_state <= next_player_state;
    end

    // 상태 머신 전환
    always @(*) begin
        case(player_state)
            IDLE: begin
                if (e_key)  // 'e' 키가 눌리면 점프 시작
                    next_player_state = JUMP;
                else
                    next_player_state = IDLE;
            end

            JUMP: begin
                if (y_pos <= JUMP_HEIGHT)  // 점프 높이에 도달하면 하강 상태로 전환
                    next_player_state = FALL;
                else
                    next_player_state = JUMP;
            end

            FALL: begin
                if (y_pos >= LAND_HEIGHT && (x_pos >= WALL_X_MIN && x_pos <= WALL_X_MAX))
                    next_player_state = LAND;  // 벽에 착지
                else if (y_pos >= 480)
                    next_player_state = IDLE;  // 바닥에 도달하면 원래 상태로 돌아가기
                else
                    next_player_state = FALL;
            end

            LAND: begin
                next_player_state = IDLE;  // 착지 후 대기 상태로 돌아감
            end

            default: next_player_state = IDLE;
        endcase
    end

    // Y 위치 제어
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            out_y_pos <= 10'd0;  // 초기 Y 위치는 0
        else begin
            case(player_state)
                JUMP: begin
                    if (y_pos > 0)
                        out_y_pos <= y_pos - 1;  // 점프 중에는 Y 위치 감소
                    else
                        out_y_pos <= 0; // Y 위치가 0보다 적게 가면 0으로 고정
                end

                FALL: begin
                    if (y_pos < 480)
                        out_y_pos <= y_pos + 1;  // 하강 중에는 Y 위치 증가
                    else
                        out_y_pos <= 480; // 바닥에 도달하면 Y 위치는 480 (화면 하단)
                end

                LAND: begin
                    out_y_pos <= LAND_HEIGHT;  // 벽에 착지하면 지정된 착지 높이로 고정
                end

                IDLE: begin
                    out_y_pos <= y_pos;  // 대기 상태에서는 Y 위치 변화 없음
                end

                default: out_y_pos <= 0;
            endcase
        end
    end

endmodule
