function [encrypt,decrypt]=aes_simple(msg,key)
%AES_DEMO  Demonstration of AES-components.
%
%   AES_DEMO
%   runs a demonstration of all components of 
%   the Advanced Encryption Standard (AES) toolbox.
%
%   In the initialization step the S-boxes, the round constants,
%   and the polynomial matrices are created and
%   an example cipher key is expanded into 
%   the round key schedule.
%   Step two and three finally convert 
%   an example plaintext to ciphertext and back to plaintext.

%   Copyright 2001-2005, J. J. Buchholz, Hochschule Bremen, buchholz@hs-bremen.de
%plaintext_hexs ='x2';
%plain=dec2hex(plaintext_hexs)
%plain=hex2dec(plain)
%length(plain)
%plain(3)=0
%length(plain)
%plain(3)
%   Version 1.0     30.05.2001
tic
global keydec
% Initialization
%key='sdffvbr5';
[s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init(key);

% Define an arbitrary series of 16 plaintext bytes 
% in hexadecimal (string) representation
% The following two specific plaintexts are used as examples 
% in the AES-Specification (draft)
%plaintext_hex = {'00' '11' '22' '33' '44' '55' '66' '77' ...
 %                '88' '99' 'aa' 'bb' 'cc' 'dd' 'ee' 'ff'};
% disp('plaintext')
%msg='efghiegfdgdf45yug'
msg_hex=dec2hex(msg);


%plaintext_hex = {'32' '43' 'f6' 'a8' '88' '5a' '30' '8d' ...
%                '31' '31' '98' 'a2' 'e0' '37' '07' '34'};

% Convert plaintext from hexadecimal (string) to decimal representation
plaintext = hex2dec(msg_hex);
plaintext_len=length(plaintext);
   if(mod(length(plaintext),16)~=0)
        for i=1:16-mod(length(plaintext),16)
            plaintext(plaintext_len+i)=0;
        end
   end
    
arr_size=length(plaintext)/16;
start=1;
stop=16;
plaintextarray=[];
for i=1:arr_size
    plaintextarray(i,1:16)=plaintext(start:stop);%16*n array
     start=stop+1;
     stop=stop+16;
end
plaintextarray;
 temp=[];
 temp1=[];
 keydes=[];
 aesdec=[];
 count=1;
 start=1;stop=8;

re_plaintextarray=[];
ciphertextarray=[];
for i=1:arr_size


   start1=1;stop1=8;

   
ciphertext = cipher (plaintextarray(i,:), w, s_box, poly_mat, 1);
disp(ciphertext);
ciphertextarray(i,:)=ciphertext(1,:);
%ciphertext
re_plaintext = inv_cipher (ciphertext, w, inv_s_box, inv_poly_mat, 1);
re_plaintextarray(i,1:16)=re_plaintext(1:16);
%re_plaintext
end
encrypt='';decrypt='';
for i=1:arr_size
    for j=1:16
        encrypt=horzcat(encrypt,char(ciphertextarray(i,j)));
        decrypt=horzcat(decrypt,char(re_plaintextarray(i,j)));
    end
end

t=toc
end