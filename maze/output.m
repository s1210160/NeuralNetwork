function [z] = output(x, w)
%   output(x, w)
%   �j���[�����̏o�͂̌v�Z

u = x * w;
%-1<=y<=1�ɔ͈͂�ύX
z =  (2 * sigmoid(u) - 1).';

end

