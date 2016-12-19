function [y] = sigmoid(u)
%   シグモイド関数
%   0<=y<=1

y = 1 ./ (1 + exp(-u));

end

