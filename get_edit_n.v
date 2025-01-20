module get_edit_n(input clk, rst, [4:0] key_pulse, 
output reg [3:0] n, reg [3:0] edit_x,reg [3:0] edit_y);


always@(posedge clk or posedge rst) begin
    if(rst) n <= 0;
    else begin
    case(key_pulse) 
    5'h11 : n<=1;
    5'h12 : n<=2;
    5'h13 : n<=3;
    5'h14 : n<=4;
    5'h15 : n<=5;
    5'h16 : n<=6;
    5'h17 : n<=7;
    5'h18 : n<=8;
    5'h19 : n<=9; 
    5'h1A : n<=0;
    5'h1B : n<=0;
    endcase
  
    end
end

//edit_x, edit_y는 A,B버튼 누를때마다 올라가는 0-3 카운터
always@ (posedge clk or posedge rst) begin
    if(rst) edit_x <= 0;
     else if(key_pulse == 5'h1E) begin 
        if(edit_x==8) edit_x <= 0;
        else edit_x <= edit_x + 1; 
     end  
     
     else if(key_pulse == 5'h1F) begin
        if(edit_x==0) edit_x <= 8;
        else edit_x <= edit_x - 1; 
     end
     
end

always@ (posedge clk or posedge rst) begin
    if(rst) edit_y <= 0;
     else if(key_pulse == 5'h1B) begin 
        if(edit_y==8) edit_y <= 0;
        else edit_y <= edit_y + 1; 
     end  
     
     else if(key_pulse == 5'h1A) begin 
        if(edit_y==0) edit_y <= 8;
        else edit_y <= edit_y - 1; 
     end  
end
endmodule