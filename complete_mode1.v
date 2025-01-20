module complete_mode1(input clk, rst, [4:0] key_pulse, [323:0] array , output complete);

    wire [26:0] check;
    reg [9:1] line1, line2 , line3, line4, line5, line6, line7, line8,line9,line10,line11,line12,line13,line14,line15,line16,line17,line18; 
    reg [9:1] squre1, squre2, squre3, squre4, squre5, squre6, squre7, squre8, squre9;
    
   assign complete = (check[0] && check[1] && check[2] && check[3] && check[4] && check[5] 
                            && check[6] && check[7] && check[8] && check[9] && check[10] && check[11]
                            && check[12] && check[13] && check[14] && check[15] && check[16] && check[17] && check[18] && check[19] && check[20]
                            && check[21] && check[22] && check[23] && check[24] && check[25] && check[26]) ? 1 : 0;
                            
                            
assign check[0] = line1[4] && line1[1] && line1[2] && line1[3] && line1[5] && line1[6] && line1[7] && line1[8] && line1[9];
assign check[1] = line2[4] && line2[1] && line2[2] && line2[3] && line2[5] && line2[6] && line2[7] && line2[8] && line2[9];
assign check[2] = line3[4] && line3[1] && line3[2] && line3[3] && line3[5] && line3[6] && line3[7] && line3[8] && line3[9];
assign check[3] = line4[4] && line4[1] && line4[2] && line4[3] && line4[5] && line4[6] && line4[7] && line4[8] && line4[9];
assign check[4] = line5[4] && line5[1] && line5[2] && line5[3] && line5[5] && line5[6] && line5[7] && line5[8] && line5[9];
assign check[5] = line6[4] && line6[1] && line6[2] && line6[3] && line6[5] && line6[6] && line6[7] && line6[8] && line6[9];
assign check[6] = line7[4] && line7[1] && line7[2] && line7[3] && line7[5] && line7[6] && line7[7] && line7[8] && line7[9];
assign check[7] = line8[4] && line8[1] && line8[2] && line8[3] && line8[5] && line8[6] && line8[7] && line8[8] && line8[9];
assign check[8] = line9[4] && line9[1] && line9[2] && line9[3] && line9[5] && line9[6] && line9[7] && line9[8] && line9[9];
assign check[9] = line10[4] && line10[1] && line10[2] && line10[3] && line10[5] && line10[6] && line10[7] && line10[8] && line10[9];
assign check[10] = line11[4] && line11[1] && line11[2] && line11[3] && line11[5] && line11[6] && line11[7] && line11[8] && line11[9];
assign check[11] = line12[4] && line12[1] && line12[2] && line12[3] && line12[5] && line12[6] && line12[7] && line12[8] && line12[9];
assign check[12] = line13[4] && line13[1] && line13[2] && line13[3] && line13[5] && line13[6] && line13[7] && line13[8] && line13[9];
assign check[13] = line14[4] && line14[1] && line14[2] && line14[3] && line14[5] && line14[6] && line14[7] && line14[8] && line14[9];
assign check[14] = line15[4] && line15[1] && line15[2] && line15[3] && line15[5] && line15[6] && line15[7] && line15[8] && line15[9];
assign check[15] = line16[4] && line16[1] && line16[2] && line16[3] && line16[5] && line16[6] && line16[7] && line16[8] && line16[9];
assign check[16] = line17[4] && line17[1] && line17[2] && line17[3] && line17[5] && line17[6] && line17[7] && line17[8] && line17[9];
assign check[17] = line18[4] && line18[1] && line18[2] && line18[3] && line18[5] && line18[6] && line18[7] && line18[8] && line18[9];

    
    
assign check[18] = squre1[4] && squre1[1] && squre1[2] && squre1[3] && squre1[5] && squre1[6] && squre1[7] && squre1[8] && squre1[9];
assign check[19] = squre2[4] && squre2[1] && squre2[2] && squre2[3] && squre2[5] && squre2[6] && squre2[7] && squre2[8] && squre2[9];
assign check[20] = squre3[4] && squre3[1] && squre3[2] && squre3[3] && squre3[5] && squre3[6] && squre3[7] && squre3[8] && squre3[9];
assign check[21] = squre4[4] && squre4[1] && squre4[2] && squre4[3] && squre4[5] && squre4[6] && squre4[7] && squre4[8] && squre4[9];
assign check[22] = squre5[4] && squre5[1] && squre5[2] && squre5[3] && squre5[5] && squre5[6] && squre5[7] && squre5[8] && squre5[9];
assign check[23] = squre6[4] && squre6[1] && squre6[2] && squre6[3] && squre6[5] && squre6[6] && squre6[7] && squre6[8] && squre6[9];
assign check[24] = squre7[4] && squre7[1] && squre7[2] && squre7[3] && squre7[5] && squre7[6] && squre7[7] && squre7[8] && squre7[9];
assign check[25] = squre8[4] && squre8[1] && squre8[2] && squre8[3] && squre8[5] && squre8[6] && squre8[7] && squre8[8] && squre8[9];
assign check[26] = squre9[4] && squre9[1] && squre9[2] && squre9[3] && squre9[5] && squre9[6] && squre9[7] && squre9[8] && squre9[9];


    
 ////////////////////////////line/////////////////////////
   
always@(*) begin
        if(rst) line1 = 0;
        else begin
        
         if (array[3:0] == 1 || array[7:4] == 1 || array[11:8] == 1  || 
           array[15:12] ==1 || array[19:16]  == 1 || array[23:20] == 1    ||
           array[27:24]  == 1  || array[31:28] == 1 || array[35:32] == 1)  
           
           line1[1] = 1;
         
         else  line1[1] = 0; 
           
         
         if (array[3:0] == 2 || array[7:4] == 2 || array[11:8] == 2  || 
           array[15:12] ==2 || array[19:16]  == 2 || array[23:20] == 2    ||
           array[27:24]  == 2  || array[31:28] == 2 || array[35:32] == 2)  
           
           line1[2] = 1;
         
         else  line1[2] = 0; 
         
         if (array[3:0] == 3 || array[7:4] == 3 || array[11:8] == 3  || 
           array[15:12] ==3 || array[19:16]  == 3 || array[23:20] == 3    ||
           array[27:24]  == 3  || array[31:28] == 3 || array[35:32] == 3)  
           
           line1[3] = 1;
         
         else  line1[3] = 0;  

        
        if (array[3:0] == 4 || array[7:4] == 4 || array[11:8] == 4  || 
   array[15:12] == 4 || array[19:16]  == 4 || array[23:20] == 4    ||
   array[27:24]  == 4  || array[31:28] == 4 || array[35:32] == 4)  
   
   line1[4] = 1;

else  line1[4] = 0; 


if (array[3:0] == 5 || array[7:4] == 5 || array[11:8] == 5  || 
   array[15:12] == 5 || array[19:16]  == 5 || array[23:20] == 5    ||
   array[27:24]  == 5  || array[31:28] == 5 || array[35:32] == 5)  
   
   line1[5] = 1;

else  line1[5] = 0; 


if (array[3:0] == 6 || array[7:4] == 6 || array[11:8] == 6  || 
   array[15:12] == 6 || array[19:16]  == 6 || array[23:20] == 6    ||
   array[27:24]  == 6  || array[31:28] == 6 || array[35:32] == 6)  
   
   line1[6] = 1;

else  line1[6] = 0; 


if (array[3:0] == 7 || array[7:4] == 7 || array[11:8] == 7  || 
   array[15:12] == 7 || array[19:16]  == 7 || array[23:20] == 7    ||
   array[27:24]  == 7  || array[31:28] == 7 || array[35:32] == 7)  
   
   line1[7] = 1;

else  line1[7] = 0; 


if (array[3:0] == 8 || array[7:4] == 8 || array[11:8] == 8  || 
   array[15:12] == 8 || array[19:16]  == 8 || array[23:20] == 8    ||
   array[27:24]  == 8  || array[31:28] == 8 || array[35:32] == 8)  
   
   line1[8] = 1;

else  line1[8] = 0; 


if (array[3:0] == 9 || array[7:4] == 9 || array[11:8] == 9  || 
   array[15:12] == 9 || array[19:16]  == 9 || array[23:20] == 9    ||
   array[27:24]  == 9  || array[31:28] == 9 || array[35:32] == 9)  
   
   line1[9] = 1;

else  line1[9] = 0;

end
end

    always@(*) begin
    if(rst) 
        line2 = 0;
    else begin
        if (array[39:36] == 1 || array[43:40] == 1 || array[47:44] == 1  || 
            array[51:48] == 1 || array[55:52] == 1 || array[59:56] == 1    ||
            array[63:60] == 1 || array[67:64] == 1 || array[71:68] == 1)  
            line2[1] = 1;
        else  
            line2[1] = 0; 

        if (array[39:36] == 2 || array[43:40] == 2 || array[47:44] == 2  || 
            array[51:48] == 2 || array[55:52] == 2 || array[59:56] == 2    ||
            array[63:60] == 2 || array[67:64] == 2 || array[71:68] == 2)  
            line2[2] = 1;
        else  
            line2[2] = 0; 

        if (array[39:36] == 3 || array[43:40] == 3 || array[47:44] == 3  || 
            array[51:48] == 3 || array[55:52] == 3 || array[59:56] == 3    ||
            array[63:60] == 3 || array[67:64] == 3 || array[71:68] == 3)  
            line2[3] = 1;
        else  
            line2[3] = 0;  
 

    if (array[39:36] == 4 || array[43:40] == 4 || array[47:44] == 4  || 
        array[51:48] == 4 || array[55:52] == 4 || array[59:56] == 4    ||
        array[63:60] == 4 || array[67:64] == 4 || array[71:68] == 4)  
        line2[4] = 1;
    else  
        line2[4] = 0; 

    if (array[39:36] == 5 || array[43:40] == 5 || array[47:44] == 5  || 
        array[51:48] == 5 || array[55:52] == 5 || array[59:56] == 5    ||
        array[63:60] == 5 || array[67:64] == 5 || array[71:68] == 5)  
        line2[5] = 1;
    else  
        line2[5] = 0; 

    if (array[39:36] == 6 || array[43:40] == 6 || array[47:44] == 6  || 
        array[51:48] == 6 || array[55:52] == 6 || array[59:56] == 6    ||
        array[63:60] == 6 || array[67:64] == 6 || array[71:68] == 6)  
        line2[6] = 1;
    else  
        line2[6] = 0; 

    if (array[39:36] == 7 || array[43:40] == 7 || array[47:44] == 7  || 
        array[51:48] == 7 || array[55:52] == 7 || array[59:56] == 7    ||
        array[63:60] == 7 || array[67:64] == 7 || array[71:68] == 7)  
        line2[7] = 1;
    else  
        line2[7] = 0; 

    if (array[39:36] == 8 || array[43:40] == 8 || array[47:44] == 8  || 
        array[51:48] == 8 || array[55:52] == 8 || array[59:56] == 8    ||
        array[63:60] == 8 || array[67:64] == 8 || array[71:68] == 8)  
        line2[8] = 1;
    else  
        line2[8] = 0; 

    if (array[39:36] == 9 || array[43:40] == 9 || array[47:44] == 9  || 
        array[51:48] == 9 || array[55:52] == 9 || array[59:56] == 9    ||
        array[63:60] == 9 || array[67:64] == 9 || array[71:68] == 9)  
        line2[9] = 1;
    else  
        line2[9] = 0;
end
end

always@(*) begin
    if(rst) 
        line3 = 0;
    else begin
        if (array[75:72] == 1 || array[79:76] == 1 || array[83:80] == 1  || 
            array[87:84] == 1 || array[91:88] == 1 || array[95:92] == 1    ||
            array[99:96] == 1 || array[103:100] == 1 || array[107:104] == 1)  
            line3[1] = 1;
        else  
            line3[1] = 0; 

        if (array[75:72] == 2 || array[79:76] == 2 || array[83:80] == 2  || 
            array[87:84] == 2 || array[91:88] == 2 || array[95:92] == 2    ||
            array[99:96] == 2 || array[103:100] == 2 || array[107:104] == 2)  
            line3[2] = 1;
        else  
            line3[2] = 0; 

        if (array[75:72] == 3 || array[79:76] == 3 || array[83:80] == 3  || 
            array[87:84] == 3 || array[91:88] == 3 || array[95:92] == 3    ||
            array[99:96] == 3 || array[103:100] == 3 || array[107:104] == 3)  
            line3[3] = 1;
        else  
            line3[3] = 0;  


    if (array[75:72] == 4 || array[79:76] == 4 || array[83:80] == 4  || 
        array[87:84] == 4 || array[91:88] == 4 || array[95:92] == 4    ||
        array[99:96] == 4 || array[103:100] == 4 || array[107:104] == 4)  
        line3[4] = 1;
    else  
        line3[4] = 0; 

    if (array[75:72] == 5 || array[79:76] == 5 || array[83:80] == 5  || 
        array[87:84] == 5 || array[91:88] == 5 || array[95:92] == 5    ||
        array[99:96] == 5 || array[103:100] == 5 || array[107:104] == 5)  
        line3[5] = 1;
    else  
        line3[5] = 0; 

    if (array[75:72] == 6 || array[79:76] == 6 || array[83:80] == 6  || 
        array[87:84] == 6 || array[91:88] == 6 || array[95:92] == 6    ||
        array[99:96] == 6 || array[103:100] == 6 || array[107:104] == 6)  
        line3[6] = 1;
    else  
        line3[6] = 0; 

    if (array[75:72] == 7 || array[79:76] == 7 || array[83:80] == 7  || 
        array[87:84] == 7 || array[91:88] == 7 || array[95:92] == 7    ||
        array[99:96] == 7 || array[103:100] == 7 || array[107:104] == 7)  
        line3[7] = 1;
    else  
        line3[7] = 0; 

    if (array[75:72] == 8 || array[79:76] == 8 || array[83:80] == 8  || 
        array[87:84] == 8 || array[91:88] == 8 || array[95:92] == 8    ||
        array[99:96] == 8 || array[103:100] == 8 || array[107:104] == 8)  
        line3[8] = 1;
    else  
        line3[8] = 0; 

    if (array[75:72] == 9 || array[79:76] == 9 || array[83:80] == 9  || 
        array[87:84] == 9 || array[91:88] == 9 || array[95:92] == 9    ||
        array[99:96] == 9 || array[103:100] == 9 || array[107:104] == 9)  
        line3[9] = 1;
    else  
        line3[9] = 0;
end
end

always@(*) begin
    if(rst) 
        line4 = 0;
    else begin
        if (array[111:108] == 1 || array[115:112] == 1 || array[119:116] == 1  || 
            array[123:120] == 1 || array[127:124] == 1 || array[131:128] == 1    ||
            array[135:132] == 1 || array[139:136] == 1 || array[143:140] == 1)  
            line4[1] = 1;
        else  
            line4[1] = 0; 

        if (array[111:108] == 2 || array[115:112] == 2 || array[119:116] == 2  || 
            array[123:120] == 2 || array[127:124] == 2 || array[131:128] == 2    ||
            array[135:132] == 2 || array[139:136] == 2 || array[143:140] == 2)  
            line4[2] = 1;
        else  
            line4[2] = 0; 

        if (array[111:108] == 3 || array[115:112] == 3 || array[119:116] == 3  || 
            array[123:120] == 3 || array[127:124] == 3 || array[131:128] == 3    ||
            array[135:132] == 3 || array[139:136] == 3 || array[143:140] == 3)  
            line4[3] = 1;
        else  
            line4[3] = 0;  


        if (array[111:108] == 4 || array[115:112] == 4 || array[119:116] == 4  || 
            array[123:120] == 4 || array[127:124] == 4 || array[131:128] == 4    ||
            array[135:132] == 4 || array[139:136] == 4 || array[143:140] == 4)  
            line4[4] = 1;
        else  
            line4[4] = 0; 

        if (array[111:108] == 5 || array[115:112] == 5 || array[119:116] == 5  || 
            array[123:120] == 5 || array[127:124] == 5 || array[131:128] == 5    ||
            array[135:132] == 5 || array[139:136] == 5 || array[143:140] == 5)  
            line4[5] = 1;
        else  
            line4[5] = 0; 

        if (array[111:108] == 6 || array[115:112] == 6 || array[119:116] == 6  || 
            array[123:120] == 6 || array[127:124] == 6 || array[131:128] == 6    ||
            array[135:132] == 6 || array[139:136] == 6 || array[143:140] == 6)  
            line4[6] = 1;
        else  
            line4[6] = 0; 

        if (array[111:108] == 7 || array[115:112] == 7 || array[119:116] == 7  || 
            array[123:120] == 7 || array[127:124] == 7 || array[131:128] == 7    ||
            array[135:132] == 7 || array[139:136] == 7 || array[143:140] == 7)  
            line4[7] = 1;
        else  
            line4[7] = 0; 

        if (array[111:108] == 8 || array[115:112] == 8 || array[119:116] == 8  || 
            array[123:120] == 8 || array[127:124] == 8 || array[131:128] == 8    ||
            array[135:132] == 8 || array[139:136] == 8 || array[143:140] == 8)  
            line4[8] = 1;
        else  
            line4[8] = 0; 

        if (array[111:108] == 9 || array[115:112] == 9 || array[119:116] == 9  || 
            array[123:120] == 9 || array[127:124] == 9 || array[131:128] == 9    ||
            array[135:132] == 9 || array[139:136] == 9 || array[143:140] == 9)  
            line4[9] = 1;
        else  
            line4[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line5 = 0;
    else begin
        if (array[147:144] == 1 || array[151:148] == 1 || array[155:152] == 1  || 
            array[159:156] == 1 || array[163:160] == 1 || array[167:164] == 1    ||
            array[171:168] == 1 || array[175:172] == 1 || array[179:176] == 1)  
            line5[1] = 1;
        else  
            line5[1] = 0; 

        if (array[147:144] == 2 || array[151:148] == 2 || array[155:152] == 2  || 
            array[159:156] == 2 || array[163:160] == 2 || array[167:164] == 2    ||
            array[171:168] == 2 || array[175:172] == 2 || array[179:176] == 2)  
            line5[2] = 1;
        else  
            line5[2] = 0; 

        if (array[147:144] == 3 || array[151:148] == 3 || array[155:152] == 3  || 
            array[159:156] == 3 || array[163:160] == 3 || array[167:164] == 3    ||
            array[171:168] == 3 || array[175:172] == 3 || array[179:176] == 3)  
            line5[3] = 1;
        else  
            line5[3] = 0;  


        if (array[147:144] == 4 || array[151:148] == 4 || array[155:152] == 4  || 
            array[159:156] == 4 || array[163:160] == 4 || array[167:164] == 4    ||
            array[171:168] == 4 || array[175:172] == 4 || array[179:176] == 4)  
            line5[4] = 1;
        else  
            line5[4] = 0; 

        if (array[147:144] == 5 || array[151:148] == 5 || array[155:152] == 5  || 
            array[159:156] == 5 || array[163:160] == 5 || array[167:164] == 5    ||
            array[171:168] == 5 || array[175:172] == 5 || array[179:176] == 5)  
            line5[5] = 1;
        else  
            line5[5] = 0; 

        if (array[147:144] == 6 || array[151:148] == 6 || array[155:152] == 6  || 
            array[159:156] == 6 || array[163:160] == 6 || array[167:164] == 6    ||
            array[171:168] == 6 || array[175:172] == 6 || array[179:176] == 6)  
            line5[6] = 1;
        else  
            line5[6] = 0; 

        if (array[147:144] == 7 || array[151:148] == 7 || array[155:152] == 7  || 
            array[159:156] == 7 || array[163:160] == 7 || array[167:164] == 7    ||
            array[171:168] == 7 || array[175:172] == 7 || array[179:176] == 7)  
            line5[7] = 1;
        else  
            line5[7] = 0; 

        if (array[147:144] == 8 || array[151:148] == 8 || array[155:152] == 8  || 
            array[159:156] == 8 || array[163:160] == 8 || array[167:164] == 8    ||
            array[171:168] == 8 || array[175:172] == 8 || array[179:176] == 8)  
            line5[8] = 1;
        else  
            line5[8] = 0; 

        if (array[147:144] == 9 || array[151:148] == 9 || array[155:152] == 9  || 
            array[159:156] == 9 || array[163:160] == 9 || array[167:164] == 9    ||
            array[171:168] == 9 || array[175:172] == 9 || array[179:176] == 9)  
            line5[9] = 1;
        else  
            line5[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line6 = 0;
    else begin
        if (array[183:180] == 1 || array[187:184] == 1 || array[191:188] == 1  || 
            array[195:192] == 1 || array[199:196] == 1 || array[203:200] == 1    ||
            array[207:204] == 1 || array[211:208] == 1 || array[215:212] == 1)  
            line6[1] = 1;
        else  
            line6[1] = 0; 

        if (array[183:180] == 2 || array[187:184] == 2 || array[191:188] == 2  || 
            array[195:192] == 2 || array[199:196] == 2 || array[203:200] == 2    ||
            array[207:204] == 2 || array[211:208] == 2 || array[215:212] == 2)  
            line6[2] = 1;
        else  
            line6[2] = 0; 

        if (array[183:180] == 3 || array[187:184] == 3 || array[191:188] == 3  || 
            array[195:192] == 3 || array[199:196] == 3 || array[203:200] == 3    ||
            array[207:204] == 3 || array[211:208] == 3 || array[215:212] == 3)  
            line6[3] = 1;
        else  
            line6[3] = 0;  


        if (array[183:180] == 4 || array[187:184] == 4 || array[191:188] == 4  || 
            array[195:192] == 4 || array[199:196] == 4 || array[203:200] == 4    ||
            array[207:204] == 4 || array[211:208] == 4 || array[215:212] == 4)  
            line6[4] = 1;
        else  
            line6[4] = 0; 

        if (array[183:180] == 5 || array[187:184] == 5 || array[191:188] == 5  || 
            array[195:192] == 5 || array[199:196] == 5 || array[203:200] == 5    ||
            array[207:204] == 5 || array[211:208] == 5 || array[215:212] == 5)  
            line6[5] = 1;
        else  
            line6[5] = 0; 

        if (array[183:180] == 6 || array[187:184] == 6 || array[191:188] == 6  || 
            array[195:192] == 6 || array[199:196] == 6 || array[203:200] == 6    ||
            array[207:204] == 6 || array[211:208] == 6 || array[215:212] == 6)  
            line6[6] = 1;
        else  
            line6[6] = 0; 

        if (array[183:180] == 7 || array[187:184] == 7 || array[191:188] == 7  || 
            array[195:192] == 7 || array[199:196] == 7 || array[203:200] == 7    ||
            array[207:204] == 7 || array[211:208] == 7 || array[215:212] == 7)  
            line6[7] = 1;
        else  
            line6[7] = 0; 

        if (array[183:180] == 8 || array[187:184] == 8 || array[191:188] == 8  || 
            array[195:192] == 8 || array[199:196] == 8 || array[203:200] == 8    ||
            array[207:204] == 8 || array[211:208] == 8 || array[215:212] == 8)  
            line6[8] = 1;
        else  
            line6[8] = 0; 

        if (array[183:180] == 9 || array[187:184] == 9 || array[191:188] == 9  || 
            array[195:192] == 9 || array[199:196] == 9 || array[203:200] == 9    ||
            array[207:204] == 9 || array[211:208] == 9 || array[215:212] == 9)  
            line6[9] = 1;
        else  
            line6[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line7 = 0;
    else begin
        if (array[219:216] == 1 || array[223:220] == 1 || array[227:224] == 1  || 
            array[231:228] == 1 || array[235:232] == 1 || array[239:236] == 1    ||
            array[243:240] == 1 || array[247:244] == 1 || array[251:248] == 1)  
            line7[1] = 1;
        else  
            line7[1] = 0; 

        if (array[219:216] == 2 || array[223:220] == 2 || array[227:224] == 2  || 
            array[231:228] == 2 || array[235:232] == 2 || array[239:236] == 2    ||
            array[243:240] == 2 || array[247:244] == 2 || array[251:248] == 2)  
            line7[2] = 1;
        else  
            line7[2] = 0; 

        if (array[219:216] == 3 || array[223:220] == 3 || array[227:224] == 3  || 
            array[231:228] == 3 || array[235:232] == 3 || array[239:236] == 3    ||
            array[243:240] == 3 || array[247:244] == 3 || array[251:248] == 3)  
            line7[3] = 1;
        else  
            line7[3] = 0;  


        if (array[219:216] == 4 || array[223:220] == 4 || array[227:224] == 4  || 
            array[231:228] == 4 || array[235:232] == 4 || array[239:236] == 4    ||
            array[243:240] == 4 || array[247:244] == 4 || array[251:248] == 4)  
            line7[4] = 1;
        else  
            line7[4] = 0; 

        if (array[219:216] == 5 || array[223:220] == 5 || array[227:224] == 5  || 
            array[231:228] == 5 || array[235:232] == 5 || array[239:236] == 5    ||
            array[243:240] == 5 || array[247:244] == 5 || array[251:248] == 5)  
            line7[5] = 1;
        else  
            line7[5] = 0; 

        if (array[219:216] == 6 || array[223:220] == 6 || array[227:224] == 6  || 
            array[231:228] == 6 || array[235:232] == 6 || array[239:236] == 6    ||
            array[243:240] == 6 || array[247:244] == 6 || array[251:248] == 6)  
            line7[6] = 1;
        else  
            line7[6] = 0; 

        if (array[219:216] == 7 || array[223:220] == 7 || array[227:224] == 7  || 
            array[231:228] == 7 || array[235:232] == 7 || array[239:236] == 7    ||
            array[243:240] == 7 || array[247:244] == 7 || array[251:248] == 7)  
            line7[7] = 1;
        else  
            line7[7] = 0; 

        if (array[219:216] == 8 || array[223:220] == 8 || array[227:224] == 8  || 
            array[231:228] == 8 || array[235:232] == 8 || array[239:236] == 8    ||
            array[243:240] == 8 || array[247:244] == 8 || array[251:248] == 8)  
            line7[8] = 1;
        else  
            line7[8] = 0; 

        if (array[219:216] == 9 || array[223:220] == 9 || array[227:224] == 9  || 
            array[231:228] == 9 || array[235:232] == 9 || array[239:236] == 9    ||
            array[243:240] == 9 || array[247:244] == 9 || array[251:248] == 9)  
            line7[9] = 1;
        else  
            line7[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line8 = 0;
    else begin
        if (array[255:252] == 1 || array[259:256] == 1 || array[263:260] == 1  || 
            array[267:264] == 1 || array[271:268] == 1 || array[275:272] == 1    ||
            array[279:276] == 1 || array[283:280] == 1 || array[287:284] == 1)  
            line8[1] = 1;
        else  
            line8[1] = 0; 

        if (array[255:252] == 2 || array[259:256] == 2 || array[263:260] == 2  || 
            array[267:264] == 2 || array[271:268] == 2 || array[275:272] == 2    ||
            array[279:276] == 2 || array[283:280] == 2 || array[287:284] == 2)  
            line8[2] = 1;
        else  
            line8[2] = 0; 

        if (array[255:252] == 3 || array[259:256] == 3 || array[263:260] == 3  || 
            array[267:264] == 3 || array[271:268] == 3 || array[275:272] == 3    ||
            array[279:276] == 3 || array[283:280] == 3 || array[287:284] == 3)  
            line8[3] = 1;
        else  
            line8[3] = 0;  


        if (array[255:252] == 4 || array[259:256] == 4 || array[263:260] == 4  || 
            array[267:264] == 4 || array[271:268] == 4 || array[275:272] == 4    ||
            array[279:276] == 4 || array[283:280] == 4 || array[287:284] == 4)  
            line8[4] = 1;
        else  
            line8[4] = 0; 

        if (array[255:252] == 5 || array[259:256] == 5 || array[263:260] == 5  || 
            array[267:264] == 5 || array[271:268] == 5 || array[275:272] == 5    ||
            array[279:276] == 5 || array[283:280] == 5 || array[287:284] == 5)  
            line8[5] = 1;
        else  
            line8[5] = 0; 

        if (array[255:252] == 6 || array[259:256] == 6 || array[263:260] == 6  || 
            array[267:264] == 6 || array[271:268] == 6 || array[275:272] == 6    ||
            array[279:276] == 6 || array[283:280] == 6 || array[287:284] == 6)  
            line8[6] = 1;
        else  
            line8[6] = 0; 

        if (array[255:252] == 7 || array[259:256] == 7 || array[263:260] == 7  || 
            array[267:264] == 7 || array[271:268] == 7 || array[275:272] == 7    ||
            array[279:276] == 7 || array[283:280] == 7 || array[287:284] == 7)  
            line8[7] = 1;
        else  
            line8[7] = 0; 

        if (array[255:252] == 8 || array[259:256] == 8 || array[263:260] == 8  || 
            array[267:264] == 8 || array[271:268] == 8 || array[275:272] == 8    ||
            array[279:276] == 8 || array[283:280] == 8 || array[287:284] == 8)  
            line8[8] = 1;
        else  
            line8[8] = 0; 

        if (array[255:252] == 9 || array[259:256] == 9 || array[263:260] == 9  || 
            array[267:264] == 9 || array[271:268] == 9 || array[275:272] == 9    ||
            array[279:276] == 9 || array[283:280] == 9 || array[287:284] == 9)  
            line8[9] = 1;
        else  
            line8[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line9 = 0;
    else begin
        if (array[291:288] == 1 || array[295:292] == 1 || array[299:296] == 1  || 
            array[303:300] == 1 || array[307:304] == 1 || array[311:308] == 1    ||
            array[315:312] == 1 || array[319:316] == 1 || array[323:320] == 1)  
            line9[1] = 1;
        else  
            line9[1] = 0; 

        if (array[291:288] == 2 || array[295:292] == 2 || array[299:296] == 2  || 
            array[303:300] == 2 || array[307:304] == 2 || array[311:308] == 2    ||
            array[315:312] == 2 || array[319:316] == 2 || array[323:320] == 2)  
            line9[2] = 1;
        else  
            line9[2] = 0; 

        if (array[291:288] == 3 || array[295:292] == 3 || array[299:296] == 3  || 
            array[303:300] == 3 || array[307:304] == 3 || array[311:308] == 3    ||
            array[315:312] == 3 || array[319:316] == 3 || array[323:320] == 3)  
            line9[3] = 1;
        else  
            line9[3] = 0;  


        if (array[291:288] == 4 || array[295:292] == 4 || array[299:296] == 4  || 
            array[303:300] == 4 || array[307:304] == 4 || array[311:308] == 4    ||
            array[315:312] == 4 || array[319:316] == 4 || array[323:320] == 4)  
            line9[4] = 1;
        else  
            line9[4] = 0; 

        if (array[291:288] == 5 || array[295:292] == 5 || array[299:296] == 5  || 
            array[303:300] == 5 || array[307:304] == 5 || array[311:308] == 5    ||
            array[315:312] == 5 || array[319:316] == 5 || array[323:320] == 5)  
            line9[5] = 1;
        else  
            line9[5] = 0; 

        if (array[291:288] == 6 || array[295:292] == 6 || array[299:296] == 6  || 
            array[303:300] == 6 || array[307:304] == 6 || array[311:308] == 6    ||
            array[315:312] == 6 || array[319:316] == 6 || array[323:320] == 6)  
            line9[6] = 1;
        else  
            line9[6] = 0; 

        if (array[291:288] == 7 || array[295:292] == 7 || array[299:296] == 7  || 
            array[303:300] == 7 || array[307:304] == 7 || array[311:308] == 7    ||
            array[315:312] == 7 || array[319:316] == 7 || array[323:320] == 7)  
            line9[7] = 1;
        else  
            line9[7] = 0; 

        if (array[291:288] == 8 || array[295:292] == 8 || array[299:296] == 8  || 
            array[303:300] == 8 || array[307:304] == 8 || array[311:308] == 8    ||
            array[315:312] == 8 || array[319:316] == 8 || array[323:320] == 8)  
            line9[8] = 1;
        else  
            line9[8] = 0; 

        if (array[291:288] == 9 || array[295:292] == 9 || array[299:296] == 9  || 
            array[303:300] == 9 || array[307:304] == 9 || array[311:308] == 9    ||
            array[315:312] == 9 || array[319:316] == 9 || array[323:320] == 9)  
            line9[9] = 1;
        else  
            line9[9] = 0;
    end
end


always@(*) begin
    if(rst) 
        line10 = 0;
    else begin
        if (array[3:0] == 1 || array[39:36] == 1 || array[75:72] == 1  || 
            array[111:108] == 1 || array[147:144] == 1 || array[183:180] == 1    ||
            array[219:216] == 1 || array[255:252] == 1 || array[291:288] == 1)  
            line10[1] = 1;
        else  
            line10[1] = 0; 

        if (array[3:0] == 2 || array[39:36] == 2 || array[75:72] == 2  || 
            array[111:108] == 2 || array[147:144] == 2 || array[183:180] == 2    ||
            array[219:216] == 2 || array[255:252] == 2 || array[291:288] == 2)  
            line10[2] = 1;
        else  
            line10[2] = 0; 

        if (array[3:0] == 3 || array[39:36] == 3 || array[75:72] == 3  || 
            array[111:108] == 3 || array[147:144] == 3 || array[183:180] == 3    ||
            array[219:216] == 3 || array[255:252] == 3 || array[291:288] == 3)  
            line10[3] = 1;
        else  
            line10[3] = 0;  

        if (array[3:0] == 4 || array[39:36] == 4 || array[75:72] == 4  || 
            array[111:108] == 4 || array[147:144] == 4 || array[183:180] == 4    ||
            array[219:216] == 4 || array[255:252] == 4 || array[291:288] == 4)  
            line10[4] = 1;
        else  
            line10[4] = 0; 

        if (array[3:0] == 5 || array[39:36] == 5 || array[75:72] == 5  || 
            array[111:108] == 5 || array[147:144] == 5 || array[183:180] == 5    ||
            array[219:216] == 5 || array[255:252] == 5 || array[291:288] == 5)  
            line10[5] = 1;
        else  
            line10[5] = 0; 

        if (array[3:0] == 6 || array[39:36] == 6 || array[75:72] == 6  || 
            array[111:108] == 6 || array[147:144] == 6 || array[183:180] == 6    ||
            array[219:216] == 6 || array[255:252] == 6 || array[291:288] == 6)  
            line10[6] = 1;
        else  
            line10[6] = 0; 

        if (array[3:0] == 7 || array[39:36] == 7 || array[75:72] == 7  || 
            array[111:108] == 7 || array[147:144] == 7 || array[183:180] == 7    ||
            array[219:216] == 7 || array[255:252] == 7 || array[291:288] == 7)  
            line10[7] = 1;
        else  
            line10[7] = 0; 

        if (array[3:0] == 8 || array[39:36] == 8 || array[75:72] == 8  || 
            array[111:108] == 8 || array[147:144] == 8 || array[183:180] == 8    ||
            array[219:216] == 8 || array[255:252] == 8 || array[291:288] == 8)  
            line10[8] = 1;
        else  
            line10[8] = 0; 

        if (array[3:0] == 9 || array[39:36] == 9 || array[75:72] == 9  || 
            array[111:108] == 9 || array[147:144] == 9 || array[183:180] == 9    ||
            array[219:216] == 9 || array[255:252] == 9 || array[291:288] == 9)  
            line10[9] = 1;
        else  
            line10[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line11 = 0;
    else begin
        if (array[7:4] == 1 || array[43:40] == 1 || array[79:76] == 1  || 
            array[115:112] == 1 || array[151:148] == 1 || array[187:184] == 1    ||
            array[223:220] == 1 || array[259:256] == 1 || array[295:292] == 1)  
            line11[1] = 1;
        else  
            line11[1] = 0; 

        if (array[7:4] == 2 || array[43:40] == 2 || array[79:76] == 2  || 
            array[115:112] == 2 || array[151:148] == 2 || array[187:184] == 2    ||
            array[223:220] == 2 || array[259:256] == 2 || array[295:292] == 2)  
            line11[2] = 1;
        else  
            line11[2] = 0; 

        if (array[7:4] == 3 || array[43:40] == 3 || array[79:76] == 3  || 
            array[115:112] == 3 || array[151:148] == 3 || array[187:184] == 3    ||
            array[223:220] == 3 || array[259:256] == 3 || array[295:292] == 3)  
            line11[3] = 1;
        else  
            line11[3] = 0;  

        if (array[7:4] == 4 || array[43:40] == 4 || array[79:76] == 4  || 
            array[115:112] == 4 || array[151:148] == 4 || array[187:184] == 4    ||
            array[223:220] == 4 || array[259:256] == 4 || array[295:292] == 4)  
            line11[4] = 1;
        else  
            line11[4] = 0; 

        if (array[7:4] == 5 || array[43:40] == 5 || array[79:76] == 5  || 
            array[115:112] == 5 || array[151:148] == 5 || array[187:184] == 5    ||
            array[223:220] == 5 || array[259:256] == 5 || array[295:292] == 5)  
            line11[5] = 1;
        else  
            line11[5] = 0; 

        if (array[7:4] == 6 || array[43:40] == 6 || array[79:76] == 6  || 
            array[115:112] == 6 || array[151:148] == 6 || array[187:184] == 6    ||
            array[223:220] == 6 || array[259:256] == 6 || array[295:292] == 6)  
            line11[6] = 1;
        else  
            line11[6] = 0; 

        if (array[7:4] == 7 || array[43:40] == 7 || array[79:76] == 7  || 
            array[115:112] == 7 || array[151:148] == 7 || array[187:184] == 7    ||
            array[223:220] == 7 || array[259:256] == 7 || array[295:292] == 7)  
            line11[7] = 1;
        else  
            line11[7] = 0; 

        if (array[7:4] == 8 || array[43:40] == 8 || array[79:76] == 8  || 
            array[115:112] == 8 || array[151:148] == 8 || array[187:184] == 8    ||
            array[223:220] == 8 || array[259:256] == 8 || array[295:292] == 8)  
            line11[8] = 1;
        else  
            line11[8] = 0; 

        if (array[7:4] == 9 || array[43:40] == 9 || array[79:76] == 9  || 
            array[115:112] == 9 || array[151:148] == 9 || array[187:184] == 9    ||
            array[223:220] == 9 || array[259:256] == 9 || array[295:292] == 9)  
            line11[9] = 1;
        else  
            line11[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line12 = 0;
    else begin
        if (array[11:8] == 1 || array[47:44] == 1 || array[83:80] == 1  || 
            array[119:116] == 1 || array[155:152] == 1 || array[191:188] == 1    ||
            array[227:224] == 1 || array[263:260] == 1 || array[299:296] == 1)  
            line12[1] = 1;
        else  
            line12[1] = 0; 

        if (array[11:8] == 2 || array[47:44] == 2 || array[83:80] == 2  || 
            array[119:116] == 2 || array[155:152] == 2 || array[191:188] == 2    ||
            array[227:224] == 2 || array[263:260] == 2 || array[299:296] == 2)  
            line12[2] = 1;
        else  
            line12[2] = 0; 

        if (array[11:8] == 3 || array[47:44] == 3 || array[83:80] == 3  || 
            array[119:116] == 3 || array[155:152] == 3 || array[191:188] == 3    ||
            array[227:224] == 3 || array[263:260] == 3 || array[299:296] == 3)  
            line12[3] = 1;
        else  
            line12[3] = 0;  

        if (array[11:8] == 4 || array[47:44] == 4 || array[83:80] == 4  || 
            array[119:116] == 4 || array[155:152] == 4 || array[191:188] == 4    ||
            array[227:224] == 4 || array[263:260] == 4 || array[299:296] == 4)  
            line12[4] = 1;
        else  
            line12[4] = 0; 

        if (array[11:8] == 5 || array[47:44] == 5 || array[83:80] == 5  || 
            array[119:116] == 5 || array[155:152] == 5 || array[191:188] == 5    ||
            array[227:224] == 5 || array[263:260] == 5 || array[299:296] == 5)  
            line12[5] = 1;
        else  
            line12[5] = 0; 

        if (array[11:8] == 6 || array[47:44] == 6 || array[83:80] == 6  || 
            array[119:116] == 6 || array[155:152] == 6 || array[191:188] == 6    ||
            array[227:224] == 6 || array[263:260] == 6 || array[299:296] == 6)  
            line12[6] = 1;
        else  
            line12[6] = 0; 

        if (array[11:8] == 7 || array[47:44] == 7 || array[83:80] == 7  || 
            array[119:116] == 7 || array[155:152] == 7 || array[191:188] == 7    ||
            array[227:224] == 7 || array[263:260] == 7 || array[299:296] == 7)  
            line12[7] = 1;
        else  
            line12[7] = 0; 

        if (array[11:8] == 8 || array[47:44] == 8 || array[83:80] == 8  || 
            array[119:116] == 8 || array[155:152] == 8 || array[191:188] == 8    ||
            array[227:224] == 8 || array[263:260] == 8 || array[299:296] == 8)  
            line12[8] = 1;
        else  
            line12[8] = 0; 

        if (array[11:8] == 9 || array[47:44] == 9 || array[83:80] == 9  || 
            array[119:116] == 9 || array[155:152] == 9 || array[191:188] == 9    ||
            array[227:224] == 9 || array[263:260] == 9 || array[299:296] == 9)  
            line12[9] = 1;
        else  
            line12[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line13 = 0;
    else begin
        if (array[15:12] == 1 || array[51:48] == 1 || array[87:84] == 1  || 
            array[123:120] == 1 || array[159:156] == 1 || array[195:192] == 1    ||
            array[231:228] == 1 || array[267:264] == 1 || array[303:300] == 1)  
            line13[1] = 1;
        else  
            line13[1] = 0; 

        if (array[15:12] == 2 || array[51:48] == 2 || array[87:84] == 2  || 
            array[123:120] == 2 || array[159:156] == 2 || array[195:192] == 2    ||
            array[231:228] == 2 || array[267:264] == 2 || array[303:300] == 2)  
            line13[2] = 1;
        else  
            line13[2] = 0; 

        if (array[15:12] == 3 || array[51:48] == 3 || array[87:84] == 3  || 
            array[123:120] == 3 || array[159:156] == 3 || array[195:192] == 3    ||
            array[231:228] == 3 || array[267:264] == 3 || array[303:300] == 3)  
            line13[3] = 1;
        else  
            line13[3] = 0;  

        if (array[15:12] == 4 || array[51:48] == 4 || array[87:84] == 4  || 
            array[123:120] == 4 || array[159:156] == 4 || array[195:192] == 4    ||
            array[231:228] == 4 || array[267:264] == 4 || array[303:300] == 4)  
            line13[4] = 1;
        else  
            line13[4] = 0; 

        if (array[15:12] == 5 || array[51:48] == 5 || array[87:84] == 5  || 
            array[123:120] == 5 || array[159:156] == 5 || array[195:192] == 5    ||
            array[231:228] == 5 || array[267:264] == 5 || array[303:300] == 5)  
            line13[5] = 1;
        else  
            line13[5] = 0; 

        if (array[15:12] == 6 || array[51:48] == 6 || array[87:84] == 6  || 
            array[123:120] == 6 || array[159:156] == 6 || array[195:192] == 6    ||
            array[231:228] == 6 || array[267:264] == 6 || array[303:300] == 6)  
            line13[6] = 1;
        else  
            line13[6] = 0; 

        if (array[15:12] == 7 || array[51:48] == 7 || array[87:84] == 7  || 
            array[123:120] == 7 || array[159:156] == 7 || array[195:192] == 7    ||
            array[231:228] == 7 || array[267:264] == 7 || array[303:300] == 7)  
            line13[7] = 1;
        else  
            line13[7] = 0; 

        if (array[15:12] == 8 || array[51:48] == 8 || array[87:84] == 8  || 
            array[123:120] == 8 || array[159:156] == 8 || array[195:192] == 8    ||
            array[231:228] == 8 || array[267:264] == 8 || array[303:300] == 8)  
            line13[8] = 1;
        else  
            line13[8] = 0; 

        if (array[15:12] == 9 || array[51:48] == 9 || array[87:84] == 9  || 
            array[123:120] == 9 || array[159:156] == 9 || array[195:192] == 9    ||
            array[231:228] == 9 || array[267:264] == 9 || array[303:300] == 9)  
            line13[9] = 1;
        else  
            line13[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line14 = 0;
    else begin
        if (array[19:16] == 1 || array[55:52] == 1 || array[91:88] == 1  || 
            array[127:124] == 1 || array[163:160] == 1 || array[199:196] == 1    ||
            array[235:232] == 1 || array[271:268] == 1 || array[307:304] == 1)  
            line14[1] = 1;
        else  
            line14[1] = 0; 

        if (array[19:16] == 2 || array[55:52] == 2 || array[91:88] == 2  || 
            array[127:124] == 2 || array[163:160] == 2 || array[199:196] == 2    ||
            array[235:232] == 2 || array[271:268] == 2 || array[307:304] == 2)  
            line14[2] = 1;
        else  
            line14[2] = 0; 

        if (array[19:16] == 3 || array[55:52] == 3 || array[91:88] == 3  || 
            array[127:124] == 3 || array[163:160] == 3 || array[199:196] == 3    ||
            array[235:232] == 3 || array[271:268] == 3 || array[307:304] == 3)  
            line14[3] = 1;
        else  
            line14[3] = 0;  

        if (array[19:16] == 4 || array[55:52] == 4 || array[91:88] == 4  || 
            array[127:124] == 4 || array[163:160] == 4 || array[199:196] == 4    ||
            array[235:232] == 4 || array[271:268] == 4 || array[307:304] == 4)  
            line14[4] = 1;
        else  
            line14[4] = 0; 

        if (array[19:16] == 5 || array[55:52] == 5 || array[91:88] == 5  || 
            array[127:124] == 5 || array[163:160] == 5 || array[199:196] == 5    ||
            array[235:232] == 5 || array[271:268] == 5 || array[307:304] == 5)  
            line14[5] = 1;
        else  
            line14[5] = 0; 

        if (array[19:16] == 6 || array[55:52] == 6 || array[91:88] == 6  || 
            array[127:124] == 6 || array[163:160] == 6 || array[199:196] == 6    ||
            array[235:232] == 6 || array[271:268] == 6 || array[307:304] == 6)  
            line14[6] = 1;
        else  
            line14[6] = 0; 

        if (array[19:16] == 7 || array[55:52] == 7 || array[91:88] == 7  || 
            array[127:124] == 7 || array[163:160] == 7 || array[199:196] == 7    ||
            array[235:232] == 7 || array[271:268] == 7 || array[307:304] == 7)  
            line14[7] = 1;
        else  
            line14[7] = 0; 

        if (array[19:16] == 8 || array[55:52] == 8 || array[91:88] == 8  || 
            array[127:124] == 8 || array[163:160] == 8 || array[199:196] == 8    ||
            array[235:232] == 8 || array[271:268] == 8 || array[307:304] == 8)  
            line14[8] = 1;
        else  
            line14[8] = 0; 

        if (array[19:16] == 9 || array[55:52] == 9 || array[91:88] == 9  || 
            array[127:124] == 9 || array[163:160] == 9 || array[199:196] == 9    ||
            array[235:232] == 9 || array[271:268] == 9 || array[307:304] == 9)  
            line14[9] = 1;
        else  
            line14[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line15 = 0;
    else begin
        if (array[23:20] == 1 || array[59:56] == 1 || array[95:92] == 1  || 
            array[131:128] == 1 || array[167:164] == 1 || array[203:200] == 1    ||
            array[239:236] == 1 || array[275:272] == 1 || array[311:308] == 1)  
            line15[1] = 1;
        else  
            line15[1] = 0; 

        if (array[23:20] == 2 || array[59:56] == 2 || array[95:92] == 2  || 
            array[131:128] == 2 || array[167:164] == 2 || array[203:200] == 2    ||
            array[239:236] == 2 || array[275:272] == 2 || array[311:308] == 2)  
            line15[2] = 1;
        else  
            line15[2] = 0; 

        if (array[23:20] == 3 || array[59:56] == 3 || array[95:92] == 3  || 
            array[131:128] == 3 || array[167:164] == 3 || array[203:200] == 3    ||
            array[239:236] == 3 || array[275:272] == 3 || array[311:308] == 3)  
            line15[3] = 1;
        else  
            line15[3] = 0;  

        if (array[23:20] == 4 || array[59:56] == 4 || array[95:92] == 4  || 
            array[131:128] == 4 || array[167:164] == 4 || array[203:200] == 4    ||
            array[239:236] == 4 || array[275:272] == 4 || array[311:308] == 4)  
            line15[4] = 1;
        else  
            line15[4] = 0; 

        if (array[23:20] == 5 || array[59:56] == 5 || array[95:92] == 5  || 
            array[131:128] == 5 || array[167:164] == 5 || array[203:200] == 5    ||
            array[239:236] == 5 || array[275:272] == 5 || array[311:308] == 5)  
            line15[5] = 1;
        else  
            line15[5] = 0; 

        if (array[23:20] == 6 || array[59:56] == 6 || array[95:92] == 6  || 
            array[131:128] == 6 || array[167:164] == 6 || array[203:200] == 6    ||
            array[239:236] == 6 || array[275:272] == 6 || array[311:308] == 6)  
            line15[6] = 1;
        else  
            line15[6] = 0; 

        if (array[23:20] == 7 || array[59:56] == 7 || array[95:92] == 7  || 
            array[131:128] == 7 || array[167:164] == 7 || array[203:200] == 7    ||
            array[239:236] == 7 || array[275:272] == 7 || array[311:308] == 7)  
            line15[7] = 1;
        else  
            line15[7] = 0; 

        if (array[23:20] == 8 || array[59:56] == 8 || array[95:92] == 8  || 
            array[131:128] == 8 || array[167:164] == 8 || array[203:200] == 8    ||
            array[239:236] == 8 || array[275:272] == 8 || array[311:308] == 8)  
            line15[8] = 1;
        else  
            line15[8] = 0; 

        if (array[23:20] == 9 || array[59:56] == 9 || array[95:92] == 9  || 
            array[131:128] == 9 || array[167:164] == 9 || array[203:200] == 9    ||
            array[239:236] == 9 || array[275:272] == 9 || array[311:308] == 9)  
            line15[9] = 1;
        else  
            line15[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line16 = 0;
    else begin
        if (array[27:24] == 1 || array[63:60] == 1 || array[99:96] == 1  || 
            array[135:132] == 1 || array[171:168] == 1 || array[207:204] == 1    ||
            array[243:240] == 1 || array[279:276] == 1 || array[315:312] == 1)  
            line16[1] = 1;
        else  
            line16[1] = 0; 

        if (array[27:24] == 2 || array[63:60] == 2 || array[99:96] == 2  || 
            array[135:132] == 2 || array[171:168] == 2 || array[207:204] == 2    ||
            array[243:240] == 2 || array[279:276] == 2 || array[315:312] == 2)  
            line16[2] = 1;
        else  
            line16[2] = 0; 

        if (array[27:24] == 3 || array[63:60] == 3 || array[99:96] == 3  || 
            array[135:132] == 3 || array[171:168] == 3 || array[207:204] == 3    ||
            array[243:240] == 3 || array[279:276] == 3 || array[315:312] == 3)  
            line16[3] = 1;
        else  
            line16[3] = 0;  

        if (array[27:24] == 4 || array[63:60] == 4 || array[99:96] == 4  || 
            array[135:132] == 4 || array[171:168] == 4 || array[207:204] == 4    ||
            array[243:240] == 4 || array[279:276] == 4 || array[315:312] == 4)  
            line16[4] = 1;
        else  
            line16[4] = 0; 

        if (array[27:24] == 5 || array[63:60] == 5 || array[99:96] == 5  || 
            array[135:132] == 5 || array[171:168] == 5 || array[207:204] == 5    ||
            array[243:240] == 5 || array[279:276] == 5 || array[315:312] == 5)  
            line16[5] = 1;
        else  
            line16[5] = 0; 

        if (array[27:24] == 6 || array[63:60] == 6 || array[99:96] == 6  || 
            array[135:132] == 6 || array[171:168] == 6 || array[207:204] == 6    ||
            array[243:240] == 6 || array[279:276] == 6 || array[315:312] == 6)  
            line16[6] = 1;
        else  
            line16[6] = 0; 

        if (array[27:24] == 7 || array[63:60] == 7 || array[99:96] == 7  || 
            array[135:132] == 7 || array[171:168] == 7 || array[207:204] == 7    ||
            array[243:240] == 7 || array[279:276] == 7 || array[315:312] == 7)  
            line16[7] = 1;
        else  
            line16[7] = 0; 

        if (array[27:24] == 8 || array[63:60] == 8 || array[99:96] == 8  || 
            array[135:132] == 8 || array[171:168] == 8 || array[207:204] == 8    ||
            array[243:240] == 8 || array[279:276] == 8 || array[315:312] == 8)  
            line16[8] = 1;
        else  
            line16[8] = 0; 

        if (array[27:24] == 9 || array[63:60] == 9 || array[99:96] == 9  || 
            array[135:132] == 9 || array[171:168] == 9 || array[207:204] == 9    ||
            array[243:240] == 9 || array[279:276] == 9 || array[315:312] == 9)  
            line16[9] = 1;
        else  
            line16[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line17 = 0;
    else begin
        if (array[31:28] == 1 || array[67:64] == 1 || array[103:100] == 1  || 
            array[139:136] == 1 || array[175:172] == 1 || array[211:208] == 1    ||
            array[247:244] == 1 || array[283:280] == 1 || array[319:316] == 1)  
            line17[1] = 1;
        else  
            line17[1] = 0; 

        if (array[31:28] == 2 || array[67:64] == 2 || array[103:100] == 2  || 
            array[139:136] == 2 || array[175:172] == 2 || array[211:208] == 2    ||
            array[247:244] == 2 || array[283:280] == 2 || array[319:316] == 2)  
            line17[2] = 1;
        else  
            line17[2] = 0; 

        if (array[31:28] == 3 || array[67:64] == 3 || array[103:100] == 3  || 
            array[139:136] == 3 || array[175:172] == 3 || array[211:208] == 3    ||
            array[247:244] == 3 || array[283:280] == 3 || array[319:316] == 3)  
            line17[3] = 1;
        else  
            line17[3] = 0;  

        if (array[31:28] == 4 || array[67:64] == 4 || array[103:100] == 4  || 
            array[139:136] == 4 || array[175:172] == 4 || array[211:208] == 4    ||
            array[247:244] == 4 || array[283:280] == 4 || array[319:316] == 4)  
            line17[4] = 1;
        else  
            line17[4] = 0; 

        if (array[31:28] == 5 || array[67:64] == 5 || array[103:100] == 5  || 
            array[139:136] == 5 || array[175:172] == 5 || array[211:208] == 5    ||
            array[247:244] == 5 || array[283:280] == 5 || array[319:316] == 5)  
            line17[5] = 1;
        else  
            line17[5] = 0; 

        if (array[31:28] == 6 || array[67:64] == 6 || array[103:100] == 6  || 
            array[139:136] == 6 || array[175:172] == 6 || array[211:208] == 6    ||
            array[247:244] == 6 || array[283:280] == 6 || array[319:316] == 6)  
            line17[6] = 1;
        else  
            line17[6] = 0; 

        if (array[31:28] == 7 || array[67:64] == 7 || array[103:100] == 7  || 
            array[139:136] == 7 || array[175:172] == 7 || array[211:208] == 7    ||
            array[247:244] == 7 || array[283:280] == 7 || array[319:316] == 7)  
            line17[7] = 1;
        else  
            line17[7] = 0; 

        if (array[31:28] == 8 || array[67:64] == 8 || array[103:100] == 8  || 
            array[139:136] == 8 || array[175:172] == 8 || array[211:208] == 8    ||
            array[247:244] == 8 || array[283:280] == 8 || array[319:316] == 8)  
            line17[8] = 1;
        else  
            line17[8] = 0; 

        if (array[31:28] == 9 || array[67:64] == 9 || array[103:100] == 9  || 
            array[139:136] == 9 || array[175:172] == 9 || array[211:208] == 9    ||
            array[247:244] == 9 || array[283:280] == 9 || array[319:316] == 9)  
            line17[9] = 1;
        else  
            line17[9] = 0;
    end
end

always@(*) begin
    if(rst) 
        line18 = 0;
    else begin
        if (array[35:32] == 1 || array[71:68] == 1 || array[107:104] == 1  || 
            array[143:140] == 1 || array[179:176] == 1 || array[215:212] == 1    ||
            array[251:248] == 1 || array[287:284] == 1 || array[323:320] == 1)  
            line18[1] = 1;
        else  
            line18[1] = 0; 

        if (array[35:32] == 2 || array[71:68] == 2 || array[107:104] == 2  || 
            array[143:140] == 2 || array[179:176] == 2 || array[215:212] == 2    ||
            array[251:248] == 2 || array[287:284] == 2 || array[323:320] == 2)  
            line18[2] = 1;
        else  
            line18[2] = 0; 

        if (array[35:32] == 3 || array[71:68] == 3 || array[107:104] == 3  || 
            array[143:140] == 3 || array[179:176] == 3 || array[215:212] == 3    ||
            array[251:248] == 3 || array[287:284] == 3 || array[323:320] == 3)  
            line18[3] = 1;
        else  
            line18[3] = 0;  

        if (array[35:32] == 4 || array[71:68] == 4 || array[107:104] == 4  || 
            array[143:140] == 4 || array[179:176] == 4 || array[215:212] == 4    ||
            array[251:248] == 4 || array[287:284] == 4 || array[323:320] == 4)  
            line18[4] = 1;
        else  
            line18[4] = 0; 

        if (array[35:32] == 5 || array[71:68] == 5 || array[107:104] == 5  || 
            array[143:140] == 5 || array[179:176] == 5 || array[215:212] == 5    ||
            array[251:248] == 5 || array[287:284] == 5 || array[323:320] == 5)  
            line18[5] = 1;
        else  
            line18[5] = 0; 

        if (array[35:32] == 6 || array[71:68] == 6 || array[107:104] == 6  || 
            array[143:140] == 6 || array[179:176] == 6 || array[215:212] == 6    ||
            array[251:248] == 6 || array[287:284] == 6 || array[323:320] == 6)  
            line18[6] = 1;
        else  
            line18[6] = 0; 

        if (array[35:32] == 7 || array[71:68] == 7 || array[107:104] == 7  || 
            array[143:140] == 7 || array[179:176] == 7 || array[215:212] == 7    ||
            array[251:248] == 7 || array[287:284] == 7 || array[323:320] == 7)  
            line18[7] = 1;
        else  
            line18[7] = 0; 

        if (array[35:32] == 8 || array[71:68] == 8 || array[107:104] == 8  || 
            array[143:140] == 8 || array[179:176] == 8 || array[215:212] == 8    ||
            array[251:248] == 8 || array[287:284] == 8 || array[323:320] == 8)  
            line18[8] = 1;
        else  
            line18[8] = 0; 

        if (array[35:32] == 9 || array[71:68] == 9 || array[107:104] == 9  || 
            array[143:140] == 9 || array[179:176] == 9 || array[215:212] == 9    ||
            array[251:248] == 9 || array[287:284] == 9 || array[323:320] == 9)  
            line18[9] = 1;
        else  
            line18[9] = 0;
    end
end


//////////////////////////squre ÃÊ±âÈ­///////////////////////////
always @(*) begin
    if (rst) squre1 = 0;
    else begin
        if (array[3:0] == 1 || array[7:4] == 1 || array[11:8] == 1 ||
            array[39:36] == 1 || array[43:40] == 1 || array[47:44] == 1 ||
            array[75:72] == 1 || array[79:76] == 1 || array[83:80] == 1)
            
            squre1[1] = 1;
        else 
            squre1[1] = 0;

        if (array[3:0] == 2 || array[7:4] == 2 || array[11:8] == 2 ||
            array[39:36] == 2 || array[43:40] == 2 || array[47:44] == 2 ||
            array[75:72] == 2 || array[79:76] == 2 || array[83:80] == 2)
            
            squre1[2] = 1;
        else 
            squre1[2] = 0;

        if (array[3:0] == 3 || array[7:4] == 3 || array[11:8] == 3 ||
            array[39:36] == 3 || array[43:40] == 3 || array[47:44] == 3 ||
            array[75:72] == 3 || array[79:76] == 3 || array[83:80] == 3)
            
            squre1[3] = 1;
        else 
            squre1[3] = 0;

        if (array[3:0] == 4 || array[7:4] == 4 || array[11:8] == 4 ||
            array[39:36] == 4 || array[43:40] == 4 || array[47:44] == 4 ||
            array[75:72] == 4 || array[79:76] == 4 || array[83:80] == 4)
            
            squre1[4] = 1;
        else 
            squre1[4] = 0;

        if (array[3:0] == 5 || array[7:4] == 5 || array[11:8] == 5 ||
            array[39:36] == 5 || array[43:40] == 5 || array[47:44] == 5 ||
            array[75:72] == 5 || array[79:76] == 5 || array[83:80] == 5)
            
            squre1[5] = 1;
        else 
            squre1[5] = 0;

        if (array[3:0] == 6 || array[7:4] == 6 || array[11:8] == 6 ||
            array[39:36] == 6 || array[43:40] == 6 || array[47:44] == 6 ||
            array[75:72] == 6 || array[79:76] == 6 || array[83:80] == 6)
            
            squre1[6] = 1;
        else 
            squre1[6] = 0;

        if (array[3:0] == 7 || array[7:4] == 7 || array[11:8] == 7 ||
            array[39:36] == 7 || array[43:40] == 7 || array[47:44] == 7 ||
            array[75:72] == 7 || array[79:76] == 7 || array[83:80] == 7)
            
            squre1[7] = 1;
        else 
            squre1[7] = 0;

        if (array[3:0] == 8 || array[7:4] == 8 || array[11:8] == 8 ||
            array[39:36] == 8 || array[43:40] == 8 || array[47:44] == 8 ||
            array[75:72] == 8 || array[79:76] == 8 || array[83:80] == 8)
            
            squre1[8] = 1;
        else 
            squre1[8] = 0;

        if (array[3:0] == 9 || array[7:4] == 9 || array[11:8] == 9 ||
            array[39:36] == 9 || array[43:40] == 9 || array[47:44] == 9 ||
            array[75:72] == 9 || array[79:76] == 9 || array[83:80] == 9)
            
            squre1[9] = 1;
        else 
            squre1[9] = 0;
    end
end



always @(*) begin
    if (rst) squre2 = 0;
    else begin
        if (array[15:12] == 1 || array[19:16] == 1 || array[23:20] == 1 ||
            array[51:48] == 1 || array[55:52] == 1 || array[59:56] == 1 ||
            array[87:84] == 1 || array[91:88] == 1 || array[95:92] == 1)
            
            squre2[1] = 1;
        else 
            squre2[1] = 0;

        if (array[15:12] == 2 || array[19:16] == 2 || array[23:20] == 2 ||
            array[51:48] == 2 || array[55:52] == 2 || array[59:56] == 2 ||
            array[87:84] == 2 || array[91:88] == 2 || array[95:92] == 2)
            
            squre2[2] = 1;
        else 
            squre2[2] = 0;

        if (array[15:12] == 3 || array[19:16] == 3 || array[23:20] == 3 ||
            array[51:48] == 3 || array[55:52] == 3 || array[59:56] == 3 ||
            array[87:84] == 3 || array[91:88] == 3 || array[95:92] == 3)
            
            squre2[3] = 1;
        else 
            squre2[3] = 0;

        if (array[15:12] == 4 || array[19:16] == 4 || array[23:20] == 4 ||
            array[51:48] == 4 || array[55:52] == 4 || array[59:56] == 4 ||
            array[87:84] == 4 || array[91:88] == 4 || array[95:92] == 4)
            
            squre2[4] = 1;
        else 
            squre2[4] = 0;

        if (array[15:12] == 5 || array[19:16] == 5 || array[23:20] == 5 ||
            array[51:48] == 5 || array[55:52] == 5 || array[59:56] == 5 ||
            array[87:84] == 5 || array[91:88] == 5 || array[95:92] == 5)
            
            squre2[5] = 1;
        else 
            squre2[5] = 0;

        if (array[15:12] == 6 || array[19:16] == 6 || array[23:20] == 6 ||
            array[51:48] == 6 || array[55:52] == 6 || array[59:56] == 6 ||
            array[87:84] == 6 || array[91:88] == 6 || array[95:92] == 6)
            
            squre2[6] = 1;
        else 
            squre2[6] = 0;

        if (array[15:12] == 7 || array[19:16] == 7 || array[23:20] == 7 ||
            array[51:48] == 7 || array[55:52] == 7 || array[59:56] == 7 ||
            array[87:84] == 7 || array[91:88] == 7 || array[95:92] == 7)
            
            squre2[7] = 1;
        else 
            squre2[7] = 0;

        if (array[15:12] == 8 || array[19:16] == 8 || array[23:20] == 8 ||
            array[51:48] == 8 || array[55:52] == 8 || array[59:56] == 8 ||
            array[87:84] == 8 || array[91:88] == 8 || array[95:92] == 8)
            
            squre2[8] = 1;
        else 
            squre2[8] = 0;

        if (array[15:12] == 9 || array[19:16] == 9 || array[23:20] == 9 ||
            array[51:48] == 9 || array[55:52] == 9 || array[59:56] == 9 ||
            array[87:84] == 9 || array[91:88] == 9 || array[95:92] == 9)
            
            squre2[9] = 1;
        else 
            squre2[9] = 0;
    end
end

always @(*) begin
    if (rst) squre3 = 0;
    else begin
        if (array[27:24] == 1 || array[31:28] == 1 || array[35:32] == 1 ||
            array[63:60] == 1 || array[67:64] == 1 || array[71:68] == 1 ||
            array[99:96] == 1 || array[103:100] == 1 || array[107:104] == 1)
            
            squre3[1] = 1;
        else 
            squre3[1] = 0;

        if (array[27:24] == 2 || array[31:28] == 2 || array[35:32] == 2 ||
            array[63:60] == 2 || array[67:64] == 2 || array[71:68] == 2 ||
            array[99:96] == 2 || array[103:100] == 2 || array[107:104] == 2)
            
            squre3[2] = 1;
        else 
            squre3[2] = 0;

        if (array[27:24] == 3 || array[31:28] == 3 || array[35:32] == 3 ||
            array[63:60] == 3 || array[67:64] == 3 || array[71:68] == 3 ||
            array[99:96] == 3 || array[103:100] == 3 || array[107:104] == 3)
            
            squre3[3] = 1;
        else 
            squre3[3] = 0;

        if (array[27:24] == 4 || array[31:28] == 4 || array[35:32] == 4 ||
            array[63:60] == 4 || array[67:64] == 4 || array[71:68] == 4 ||
            array[99:96] == 4 || array[103:100] == 4 || array[107:104] == 4)
            
            squre3[4] = 1;
        else 
            squre3[4] = 0;

        if (array[27:24] == 5 || array[31:28] == 5 || array[35:32] == 5 ||
            array[63:60] == 5 || array[67:64] == 5 || array[71:68] == 5 ||
            array[99:96] == 5 || array[103:100] == 5 || array[107:104] == 5)
            
            squre3[5] = 1;
        else 
            squre3[5] = 0;

        if (array[27:24] == 6 || array[31:28] == 6 || array[35:32] == 6 ||
            array[63:60] == 6 || array[67:64] == 6 || array[71:68] == 6 ||
            array[99:96] == 6 || array[103:100] == 6 || array[107:104] == 6)
            
            squre3[6] = 1;
        else 
            squre3[6] = 0;

        if (array[27:24] == 7 || array[31:28] == 7 || array[35:32] == 7 ||
            array[63:60] == 7 || array[67:64] == 7 || array[71:68] == 7 ||
            array[99:96] == 7 || array[103:100] == 7 || array[107:104] == 7)
            
            squre3[7] = 1;
        else 
            squre3[7] = 0;

        if (array[27:24] == 8 || array[31:28] == 8 || array[35:32] == 8 ||
            array[63:60] == 8 || array[67:64] == 8 || array[71:68] == 8 ||
            array[99:96] == 8 || array[103:100] == 8 || array[107:104] == 8)
            
            squre3[8] = 1;
        else 
            squre3[8] = 0;

        if (array[27:24] == 9 || array[31:28] == 9 || array[35:32] == 9 ||
            array[63:60] == 9 || array[67:64] == 9 || array[71:68] == 9 ||
            array[99:96] == 9 || array[103:100] == 9 || array[107:104] == 9)
            
            squre3[9] = 1;
        else 
            squre3[9] = 0;
    end
end


always @(*) begin
    if (rst) squre4 = 0;
    else begin
        if (array[111:108] == 1 || array[115:112] == 1 || array[119:116] == 1 ||
            array[147:144] == 1 || array[151:148] == 1 || array[155:152] == 1 ||
            array[183:180] == 1 || array[187:184] == 1 || array[191:188] == 1)
            
            squre4[1] = 1;
        else 
            squre4[1] = 0;

        if (array[111:108] == 2 || array[115:112] == 2 || array[119:116] == 2 ||
            array[147:144] == 2 || array[151:148] == 2 || array[155:152] == 2 ||
            array[183:180] == 2 || array[187:184] == 2 || array[191:188] == 2)
            
            squre4[2] = 1;
        else 
            squre4[2] = 0;

        if (array[111:108] == 3 || array[115:112] == 3 || array[119:116] == 3 ||
            array[147:144] == 3 || array[151:148] == 3 || array[155:152] == 3 ||
            array[183:180] == 3 || array[187:184] == 3 || array[191:188] == 3)
            
            squre4[3] = 1;
        else 
            squre4[3] = 0;

        if (array[111:108] == 4 || array[115:112] == 4 || array[119:116] == 4 ||
            array[147:144] == 4 || array[151:148] == 4 || array[155:152] == 4 ||
            array[183:180] == 4 || array[187:184] == 4 || array[191:188] == 4)
            
            squre4[4] = 1;
        else 
            squre4[4] = 0;

        if (array[111:108] == 5 || array[115:112] == 5 || array[119:116] == 5 ||
            array[147:144] == 5 || array[151:148] == 5 || array[155:152] == 5 ||
            array[183:180] == 5 || array[187:184] == 5 || array[191:188] == 5)
            
            squre4[5] = 1;
        else 
            squre4[5] = 0;

        if (array[111:108] == 6 || array[115:112] == 6 || array[119:116] == 6 ||
            array[147:144] == 6 || array[151:148] == 6 || array[155:152] == 6 ||
            array[183:180] == 6 || array[187:184] == 6 || array[191:188] == 6)
            
            squre4[6] = 1;
        else 
            squre4[6] = 0;

        if (array[111:108] == 7 || array[115:112] == 7 || array[119:116] == 7 ||
            array[147:144] == 7 || array[151:148] == 7 || array[155:152] == 7 ||
            array[183:180] == 7 || array[187:184] == 7 || array[191:188] == 7)
            
            squre4[7] = 1;
        else 
            squre4[7] = 0;

        if (array[111:108] == 8 || array[115:112] == 8 || array[119:116] == 8 ||
            array[147:144] == 8 || array[151:148] == 8 || array[155:152] == 8 ||
            array[183:180] == 8 || array[187:184] == 8 || array[191:188] == 8)
            
            squre4[8] = 1;
        else 
            squre4[8] = 0;

        if (array[111:108] == 9 || array[115:112] == 9 || array[119:116] == 9 ||
            array[147:144] == 9 || array[151:148] == 9 || array[155:152] == 9 ||
            array[183:180] == 9 || array[187:184] == 9 || array[191:188] == 9)
            
            squre4[9] = 1;
        else 
            squre4[9] = 0;
    end
end


always @(*) begin
    if (rst) squre5 = 0;
    else begin
        if (array[123:120] == 1 || array[127:124] == 1 || array[131:128] == 1 ||
            array[159:156] == 1 || array[163:160] == 1 || array[167:164] == 1 ||
            array[195:192] == 1 || array[199:196] == 1 || array[203:200] == 1)
            
            squre5[1] = 1;
        else 
            squre5[1] = 0;

        if (array[123:120] == 2 || array[127:124] == 2 || array[131:128] == 2 ||
            array[159:156] == 2 || array[163:160] == 2 || array[167:164] == 2 ||
            array[195:192] == 2 || array[199:196] == 2 || array[203:200] == 2)
            
            squre5[2] = 1;
        else 
            squre5[2] = 0;

        if (array[123:120] == 3 || array[127:124] == 3 || array[131:128] == 3 ||
            array[159:156] == 3 || array[163:160] == 3 || array[167:164] == 3 ||
            array[195:192] == 3 || array[199:196] == 3 || array[203:200] == 3)
            
            squre5[3] = 1;
        else 
            squre5[3] = 0;

        if (array[123:120] == 4 || array[127:124] == 4 || array[131:128] == 4 ||
            array[159:156] == 4 || array[163:160] == 4 || array[167:164] == 4 ||
            array[195:192] == 4 || array[199:196] == 4 || array[203:200] == 4)
            
            squre5[4] = 1;
        else 
            squre5[4] = 0;

        if (array[123:120] == 5 || array[127:124] == 5 || array[131:128] == 5 ||
            array[159:156] == 5 || array[163:160] == 5 || array[167:164] == 5 ||
            array[195:192] == 5 || array[199:196] == 5 || array[203:200] == 5)
            
            squre5[5] = 1;
        else 
            squre5[5] = 0;

        if (array[123:120] == 6 || array[127:124] == 6 || array[131:128] == 6 ||
            array[159:156] == 6 || array[163:160] == 6 || array[167:164] == 6 ||
            array[195:192] == 6 || array[199:196] == 6 || array[203:200] == 6)
            
            squre5[6] = 1;
        else 
            squre5[6] = 0;

        if (array[123:120] == 7 || array[127:124] == 7 || array[131:128] == 7 ||
            array[159:156] == 7 || array[163:160] == 7 || array[167:164] == 7 ||
            array[195:192] == 7 || array[199:196] == 7 || array[203:200] == 7)
            
            squre5[7] = 1;
        else 
            squre5[7] = 0;

        if (array[123:120] == 8 || array[127:124] == 8 || array[131:128] == 8 ||
            array[159:156] == 8 || array[163:160] == 8 || array[167:164] == 8 ||
            array[195:192] == 8 || array[199:196] == 8 || array[203:200] == 8)
            
            squre5[8] = 1;
        else 
            squre5[8] = 0;

        if (array[123:120] == 9 || array[127:124] == 9 || array[131:128] == 9 ||
            array[159:156] == 9 || array[163:160] == 9 || array[167:164] == 9 ||
            array[195:192] == 9 || array[199:196] == 9 || array[203:200] == 9)
            
            squre5[9] = 1;
        else 
            squre5[9] = 0;
    end
end


always @(*) begin
    if (rst) squre6 = 0;
    else begin
        if (array[135:132] == 1 || array[139:136] == 1 || array[143:140] == 1 ||
            array[171:168] == 1 || array[175:172] == 1 || array[179:176] == 1 ||
            array[207:204] == 1 || array[211:208] == 1 || array[215:212] == 1)
            
            squre6[1] = 1;
        else 
            squre6[1] = 0;

        if (array[135:132] == 2 || array[139:136] == 2 || array[143:140] == 2 ||
            array[171:168] == 2 || array[175:172] == 2 || array[179:176] == 2 ||
            array[207:204] == 2 || array[211:208] == 2 || array[215:212] == 2)
            
            squre6[2] = 1;
        else 
            squre6[2] = 0;

        if (array[135:132] == 3 || array[139:136] == 3 || array[143:140] == 3 ||
            array[171:168] == 3 || array[175:172] == 3 || array[179:176] == 3 ||
            array[207:204] == 3 || array[211:208] == 3 || array[215:212] == 3)
            
            squre6[3] = 1;
        else 
            squre6[3] = 0;

        if (array[135:132] == 4 || array[139:136] == 4 || array[143:140] == 4 ||
            array[171:168] == 4 || array[175:172] == 4 || array[179:176] == 4 ||
            array[207:204] == 4 || array[211:208] == 4 || array[215:212] == 4)
            
            squre6[4] = 1;
        else 
            squre6[4] = 0;

        if (array[135:132] == 5 || array[139:136] == 5 || array[143:140] == 5 ||
            array[171:168] == 5 || array[175:172] == 5 || array[179:176] == 5 ||
            array[207:204] == 5 || array[211:208] == 5 || array[215:212] == 5)
            
            squre6[5] = 1;
        else 
            squre6[5] = 0;

        if (array[135:132] == 6 || array[139:136] == 6 || array[143:140] == 6 ||
            array[171:168] == 6 || array[175:172] == 6 || array[179:176] == 6 ||
            array[207:204] == 6 || array[211:208] == 6 || array[215:212] == 6)
            
            squre6[6] = 1;
        else 
            squre6[6] = 0;

        if (array[135:132] == 7 || array[139:136] == 7 || array[143:140] == 7 ||
            array[171:168] == 7 || array[175:172] == 7 || array[179:176] == 7 ||
            array[207:204] == 7 || array[211:208] == 7 || array[215:212] == 7)
            
            squre6[7] = 1;
        else 
            squre6[7] = 0;

        if (array[135:132] == 8 || array[139:136] == 8 || array[143:140] == 8 ||
            array[171:168] == 8 || array[175:172] == 8 || array[179:176] == 8 ||
            array[207:204] == 8 || array[211:208] == 8 || array[215:212] == 8)
            
            squre6[8] = 1;
        else 
            squre6[8] = 0;

        if (array[135:132] == 9 || array[139:136] == 9 || array[143:140] == 9 ||
            array[171:168] == 9 || array[175:172] == 9 || array[179:176] == 9 ||
            array[207:204] == 9 || array[211:208] == 9 || array[215:212] == 9)
            
            squre6[9] = 1;
        else 
            squre6[9] = 0;
    end
end


always @(*) begin
    if (rst) squre7 = 0;
    else begin
        if (array[219:216] == 1 || array[223:220] == 1 || array[227:224] == 1 ||
            array[255:252] == 1 || array[259:256] == 1 || array[263:260] == 1 ||
            array[291:288] == 1 || array[295:292] == 1 || array[299:296] == 1)
            
            squre7[1] = 1;
        else 
            squre7[1] = 0;

        if (array[219:216] == 2 || array[223:220] == 2 || array[227:224] == 2 ||
            array[255:252] == 2 || array[259:256] == 2 || array[263:260] == 2 ||
            array[291:288] == 2 || array[295:292] == 2 || array[299:296] == 2)
            
            squre7[2] = 1;
        else 
            squre7[2] = 0;

        if (array[219:216] == 3 || array[223:220] == 3 || array[227:224] == 3 ||
            array[255:252] == 3 || array[259:256] == 3 || array[263:260] == 3 ||
            array[291:288] == 3 || array[295:292] == 3 || array[299:296] == 3)
            
            squre7[3] = 1;
        else 
            squre7[3] = 0;

        if (array[219:216] == 4 || array[223:220] == 4 || array[227:224] == 4 ||
            array[255:252] == 4 || array[259:256] == 4 || array[263:260] == 4 ||
            array[291:288] == 4 || array[295:292] == 4 || array[299:296] == 4)
            
            squre7[4] = 1;
        else 
            squre7[4] = 0;

        if (array[219:216] == 5 || array[223:220] == 5 || array[227:224] == 5 ||
            array[255:252] == 5 || array[259:256] == 5 || array[263:260] == 5 ||
            array[291:288] == 5 || array[295:292] == 5 || array[299:296] == 5)
            
            squre7[5] = 1;
        else 
            squre7[5] = 0;

        if (array[219:216] == 6 || array[223:220] == 6 || array[227:224] == 6 ||
            array[255:252] == 6 || array[259:256] == 6 || array[263:260] == 6 ||
            array[291:288] == 6 || array[295:292] == 6 || array[299:296] == 6)
            
            squre7[6] = 1;
        else 
            squre7[6] = 0;

        if (array[219:216] == 7 || array[223:220] == 7 || array[227:224] == 7 ||
            array[255:252] == 7 || array[259:256] == 7 || array[263:260] == 7 ||
            array[291:288] == 7 || array[295:292] == 7 || array[299:296] == 7)
            
            squre7[7] = 1;
        else 
            squre7[7] = 0;

        if (array[219:216] == 8 || array[223:220] == 8 || array[227:224] == 8 ||
            array[255:252] == 8 || array[259:256] == 8 || array[263:260] == 8 ||
            array[291:288] == 8 || array[295:292] == 8 || array[299:296] == 8)
            
            squre7[8] = 1;
        else 
            squre7[8] = 0;

        if (array[219:216] == 9 || array[223:220] == 9 || array[227:224] == 9 ||
            array[255:252] == 9 || array[259:256] == 9 || array[263:260] == 9 ||
            array[291:288] == 9 || array[295:292] == 9 || array[299:296] == 9)
            
            squre7[9] = 1;
        else 
            squre7[9] = 0;
    end
end


always @(*) begin
    if (rst) squre8 = 0;
    else begin
        if (array[231:228] == 1 || array[235:232] == 1 || array[239:236] == 1 ||
            array[267:264] == 1 || array[271:268] == 1 || array[275:272] == 1 ||
            array[303:300] == 1 || array[307:304] == 1 || array[311:308] == 1)
            
            squre8[1] = 1;
        else 
            squre8[1] = 0;

        if (array[231:228] == 2 || array[235:232] == 2 || array[239:236] == 2 ||
            array[267:264] == 2 || array[271:268] == 2 || array[275:272] == 2 ||
            array[303:300] == 2 || array[307:304] == 2 || array[311:308] == 2)
            
            squre8[2] = 1;
        else 
            squre8[2] = 0;

        if (array[231:228] == 3 || array[235:232] == 3 || array[239:236] == 3 ||
            array[267:264] == 3 || array[271:268] == 3 || array[275:272] == 3 ||
            array[303:300] == 3 || array[307:304] == 3 || array[311:308] == 3)
            
            squre8[3] = 1;
        else 
            squre8[3] = 0;

        if (array[231:228] == 4 || array[235:232] == 4 || array[239:236] == 4 ||
            array[267:264] == 4 || array[271:268] == 4 || array[275:272] == 4 ||
            array[303:300] == 4 || array[307:304] == 4 || array[311:308] == 4)
            
            squre8[4] = 1;
        else 
            squre8[4] = 0;

        if (array[231:228] == 5 || array[235:232] == 5 || array[239:236] == 5 ||
            array[267:264] == 5 || array[271:268] == 5 || array[275:272] == 5 ||
            array[303:300] == 5 || array[307:304] == 5 || array[311:308] == 5)
            
            squre8[5] = 1;
        else 
            squre8[5] = 0;

        if (array[231:228] == 6 || array[235:232] == 6 || array[239:236] == 6 ||
            array[267:264] == 6 || array[271:268] == 6 || array[275:272] == 6 ||
            array[303:300] == 6 || array[307:304] == 6 || array[311:308] == 6)
            
            squre8[6] = 1;
        else 
            squre8[6] = 0;

        if (array[231:228] == 7 || array[235:232] == 7 || array[239:236] == 7 ||
            array[267:264] == 7 || array[271:268] == 7 || array[275:272] == 7 ||
            array[303:300] == 7 || array[307:304] == 7 || array[311:308] == 7)
            
            squre8[7] = 1;
        else 
            squre8[7] = 0;

        if (array[231:228] == 8 || array[235:232] == 8 || array[239:236] == 8 ||
            array[267:264] == 8 || array[271:268] == 8 || array[275:272] == 8 ||
            array[303:300] == 8 || array[307:304] == 8 || array[311:308] == 8)
            
            squre8[8] = 1;
        else 
            squre8[8] = 0;

        if (array[231:228] == 9 || array[235:232] == 9 || array[239:236] == 9 ||
            array[267:264] == 9 || array[271:268] == 9 || array[275:272] == 9 ||
            array[303:300] == 9 || array[307:304] == 9 || array[311:308] == 9)
            
            squre8[9] = 1;
        else 
            squre8[9] = 0;
    end
end


always @(*) begin
    if (rst) squre9 = 0;
    else begin
        if (array[243:240] == 1 || array[247:244] == 1 || array[251:248] == 1 ||
            array[279:276] == 1 || array[283:280] == 1 || array[287:284] == 1 ||
            array[315:312] == 1 || array[319:316] == 1 || array[323:320] == 1)
            
            squre9[1] = 1;
        else 
            squre9[1] = 0;

        if (array[243:240] == 2 || array[247:244] == 2 || array[251:248] == 2 ||
            array[279:276] == 2 || array[283:280] == 2 || array[287:284] == 2 ||
            array[315:312] == 2 || array[319:316] == 2 || array[323:320] == 2)
            
            squre9[2] = 1;
        else 
            squre9[2] = 0;

        if (array[243:240] == 3 || array[247:244] == 3 || array[251:248] == 3 ||
            array[279:276] == 3 || array[283:280] == 3 || array[287:284] == 3 ||
            array[315:312] == 3 || array[319:316] == 3 || array[323:320] == 3)
            
            squre9[3] = 1;
        else 
            squre9[3] = 0;

        if (array[243:240] == 4 || array[247:244] == 4 || array[251:248] == 4 ||
            array[279:276] == 4 || array[283:280] == 4 || array[287:284] == 4 ||
            array[315:312] == 4 || array[319:316] == 4 || array[323:320] == 4)
            
            squre9[4] = 1;
        else 
            squre9[4] = 0;

        if (array[243:240] == 5 || array[247:244] == 5 || array[251:248] == 5 ||
            array[279:276] == 5 || array[283:280] == 5 || array[287:284] == 5 ||
            array[315:312] == 5 || array[319:316] == 5 || array[323:320] == 5)
            
            squre9[5] = 1;
        else 
            squre9[5] = 0;

        if (array[243:240] == 6 || array[247:244] == 6 || array[251:248] == 6 ||
            array[279:276] == 6 || array[283:280] == 6 || array[287:284] == 6 ||
            array[315:312] == 6 || array[319:316] == 6 || array[323:320] == 6)
            
            squre9[6] = 1;
        else 
            squre9[6] = 0;

        if (array[243:240] == 7 || array[247:244] == 7 || array[251:248] == 7 ||
            array[279:276] == 7 || array[283:280] == 7 || array[287:284] == 7 ||
            array[315:312] == 7 || array[319:316] == 7 || array[323:320] == 7)
            
            squre9[7] = 1;
        else 
            squre9[7] = 0;

        if (array[243:240] == 8 || array[247:244] == 8 || array[251:248] == 8 ||
            array[279:276] == 8 || array[283:280] == 8 || array[287:284] == 8 ||
            array[315:312] == 8 || array[319:316] == 8 || array[323:320] == 8)
            
            squre9[8] = 1;
        else 
            squre9[8] = 0;

        if (array[243:240] == 9 || array[247:244] == 9 || array[251:248] == 9 ||
            array[279:276] == 9 || array[283:280] == 9 || array[287:284] == 9 ||
            array[315:312] == 9 || array[319:316] == 9 || array[323:320] == 9)
            
            squre9[9] = 1;
        else 
            squre9[9] = 0;
    end
end

    
endmodule
