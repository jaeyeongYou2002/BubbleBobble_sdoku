module number_input_mode1(input clk, rst , [4:0] key_pulse, [3:0] edit_x, [3:0] edit_y, [9:0]x, [9:0]y, [3:0] n, output reg[323:0] array);

always@(*) begin
if(rst) begin
        array = 0;
        
        array[3:0] = 4'b0101;
        array[7:4] = 4'b0011;
        array[19:16] = 4'b0111;
        array[39:36] = 4'b0110;
        array[51:48] = 4'b0001;
        array[55:52] = 4'b1001;
        array[59:56] = 4'b0101;
        array[79:76] = 4'b1001;
        array[83:80] = 4'b1000;
        array[103:100] = 4'b0110;
        array[111:108] = 4'b1000;
        array[127:124] = 4'b0110;
        
        array[143:140] = 4'b0011;
        array[147:144] = 4'b0100;
        array[159:156] = 4'b1000;
        
        array[167:164] = 4'b0011;
        array[179:176] = 4'b0001;
        array[183:180] = 4'b0111;
        array[199:196] = 4'b0010;
        array[215:212] = 4'b0110;
        
        array[223:220] = 4'b0110;
        array[243:240] = 4'b0010;
        array[247:244] = 4'b1000;
        array[267:264] = 4'b0100;
        
        array[271:268] = 4'b0001;
        array[275:272] = 4'b1001;
        array[287:284] = 4'b0101;
        array[307:304] = 4'b1000;
        array[319:316] = 4'b0111;
        array[323:320] = 4'b1001;
        
  end
  
else begin if(key_pulse == 5'h1C) begin
    case(edit_y)
    0 : begin 
        case(edit_x) 
         0: array[3:0] = 4'b0101;
         1: array[7:4] = 4'b0011;
         2: array[11:8] = n;
         3: array[15:12] = n;
         4: array[19:16] = 4'b0111;
         5: array[23:20] = n;
         6: array[27:24] = n;
         7: array[31:28] = n;
         8: array[35:32] = n;
             
        endcase
    end 
       
    1 : begin 
        case(edit_x) 
         0: array[39:36] = 4'b0110;
         1: array[43:40] = n;
         2: array[47:44] = n;
         3: array[51:48] = 4'b0001;
         4: array[55:52] = 4'b1001;
         5: array[59:56] = 4'b0101;
         6: array[63:60] = n;
         7: array[67:64] = n;
         8: array[71:68] = n;
             
        endcase
    end
    
    2 :begin
    case(edit_x) 
         0: array[75:72] = n;
         1: array[79:76] = 4'b1001;
         2: array[83:80] = 4'b1000;
         3: array[87:84] = n;
         4: array[91:88] = n;
         5: array[95:92] = n;
         6: array[99:96] = n;
         7: array[103:100] = 4'b0110;
         8: array[107:104] = n;
             
        endcase
     end
     
    3 : begin
    case(edit_x) 
         0: array[111:108] = 4'b1000;
         1: array[115:112] = n;
         2: array[119:116] = n;
         3: array[123:120] = n;
         4: array[127:124] = 4'b0110;
         5: array[131:128] = n;
         6: array[135:132] = n;
         7: array[139:136] = n;
         8: array[143:140] = 4'b0011;    
        endcase
     end
     
     4 : begin
    case(edit_x) 
         0: array[147:144] = 4'b0100;
         1: array[151:148] = n;
         2: array[155:152] = n;
         3: array[159:156] = 4'b1000;
         4: array[163:160] = n;
         5: array[167:164] = 4'b0011;
         6: array[171:168] = n;
         7: array[175:172] = n;
         8: array[179:176] = 4'b0001;    
        endcase
     end
     
     5 : begin
    case(edit_x) 
         0: array[183:180] = 4'b0111;
         1: array[187:184] = n;
         2: array[191:188] = n;
         3: array[195:192] = n;
         4: array[199:196] = 4'b0010;
         5: array[203:200] = n;
         6: array[207:204] = n;
         7: array[211:208] = n;
         8: array[215:212] = 4'b0110;    
        endcase
     end
     
     6 : begin
    case(edit_x) 
         0: array[219:216] = n;
         1: array[223:220] = 4'b0110;
         2: array[227:224] = n;
         3: array[231:228] = n;
         4: array[235:232] = n;
         5: array[239:236] = n;
         6: array[243:240] = 4'b0010;
         7: array[247:244] = 4'b1000;
         8: array[251:248] = n;    
        endcase
     end
     
     7 : begin
    case(edit_x) 
         0: array[255:252] = n;
         1: array[259:256] = n;
         2: array[263:260] = n;
         3: array[267:264] = 4'b0100;
         4: array[271:268] = 4'b0001;
         5: array[275:272] = 4'b1001;
         6: array[279:276] = n;
         7: array[283:280] = n;
         8: array[287:284] = 4'b0101;    
        endcase
     end
     
     8 : begin
    case(edit_x) 
         0: array[291:288] = n;
         1: array[295:292] = n;
         2: array[299:296] = n;
         3: array[303:300] = n;
         4: array[307:304] = 4'b1000;
         5: array[311:308] = n;
         6: array[315:312] = n;
         7: array[319:316] = 4'b0111;
         8: array[323:320] = 4'b1001;    
        endcase
     end
     
     default : array = 0;
    
    endcase
end
end
end
          
endmodule                 
                   
