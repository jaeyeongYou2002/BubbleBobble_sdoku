module gameCharacter (
    input wire clk,
    input wire rst_n,
    input wire e_key,              // 'e' Ű �Է� (1�̸� ����)
    input wire [9:0] x_pos,        // ĳ������ X ��ġ
    input wire [9:0] y_pos,        // ĳ������ Y ��ġ
    output reg [9:0] out_y_pos,    // ���� Y ��ġ (���� �� ���� ��)
    output reg [9:0] out_x_pos     // ���� X ��ġ
);

    // ���� ����
    
    parameter IDLE = 3'b000;    // ��� ����
     parameter JUMP = 3'b001;      // ���� ����
     parameter  FALL = 3'b010;      // �ϰ� ����
     parameter  LAND = 3'b011;       // ���� ����
    

    // ���� ��������
    reg [2:0] player_state, next_player_state;

    // ���� ���̿� �ϰ� �ӵ�
    parameter JUMP_HEIGHT = 50;    // ���� ����
    parameter LAND_HEIGHT = 160;   // ���� Y ��ǥ

    // ���� X, Y ��ǥ ����
    parameter WALL_X_MIN = 400;
    parameter WALL_X_MAX = 639;
    parameter WALL_Y_MIN = 150;
    parameter WALL_Y_MAX = 170;

    // ���� �ӽ�
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            player_state <= IDLE;
        else
            player_state <= next_player_state;
    end

    // ���� �ӽ� ��ȯ
    always @(*) begin
        case(player_state)
            IDLE: begin
                if (e_key)  // 'e' Ű�� ������ ���� ����
                    next_player_state = JUMP;
                else
                    next_player_state = IDLE;
            end

            JUMP: begin
                if (y_pos <= JUMP_HEIGHT)  // ���� ���̿� �����ϸ� �ϰ� ���·� ��ȯ
                    next_player_state = FALL;
                else
                    next_player_state = JUMP;
            end

            FALL: begin
                if (y_pos >= LAND_HEIGHT && (x_pos >= WALL_X_MIN && x_pos <= WALL_X_MAX))
                    next_player_state = LAND;  // ���� ����
                else if (y_pos >= 480)
                    next_player_state = IDLE;  // �ٴڿ� �����ϸ� ���� ���·� ���ư���
                else
                    next_player_state = FALL;
            end

            LAND: begin
                next_player_state = IDLE;  // ���� �� ��� ���·� ���ư�
            end

            default: next_player_state = IDLE;
        endcase
    end

    // Y ��ġ ����
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            out_y_pos <= 10'd0;  // �ʱ� Y ��ġ�� 0
        else begin
            case(player_state)
                JUMP: begin
                    if (y_pos > 0)
                        out_y_pos <= y_pos - 1;  // ���� �߿��� Y ��ġ ����
                    else
                        out_y_pos <= 0; // Y ��ġ�� 0���� ���� ���� 0���� ����
                end

                FALL: begin
                    if (y_pos < 480)
                        out_y_pos <= y_pos + 1;  // �ϰ� �߿��� Y ��ġ ����
                    else
                        out_y_pos <= 480; // �ٴڿ� �����ϸ� Y ��ġ�� 480 (ȭ�� �ϴ�)
                end

                LAND: begin
                    out_y_pos <= LAND_HEIGHT;  // ���� �����ϸ� ������ ���� ���̷� ����
                end

                IDLE: begin
                    out_y_pos <= y_pos;  // ��� ���¿����� Y ��ġ ��ȭ ����
                end

                default: out_y_pos <= 0;
            endcase
        end
    end

endmodule
