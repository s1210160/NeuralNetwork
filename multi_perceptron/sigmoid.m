function [y] = sigmoid(u)
%   �V�O���C�h�֐�
%   0<=y<=1

y = 1 ./ (1 + exp(-u));

end

