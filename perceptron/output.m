function [z] = output(x, w)
%   output(x, w)
%   ニューロンの出力の計算

u = x * w;
%-1<=y<=1に範囲を変更
z =  (2 * sigmoid(u) - 1).';

end

