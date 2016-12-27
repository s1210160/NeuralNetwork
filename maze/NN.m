clear all;
close all;

err = 50;
alph = 0.1;
n = 4;
size = 3;

%���̓f�[�^
x = [0.5 0.5 -1; 1.5 0.5 -1; 2.5 0.5 -1;
     2.5 1.5 -1; 1.5 1.5 -1; 0.5 1.5 -1;
     0.5 2.5 -1; 1.5 2.5 -1; 2.5 2.5 -1];
%���t�f�[�^
d = [-1 1; -1 1; 1 1;
     1 -1; 1 -1; 1 1;
     -1 1; -1 1; -1 -1];
%�V�i�v�X�����׏d�̏�����
w1 = [rand() rand() rand(); rand() rand() rand(); rand() rand() rand()];
w2 = [rand() rand(); rand() rand(); rand() rand()];

figure();
a = linspace(-0.5, 1.5);
%���͒l�v���b�g
for i=1:n
    if d(i) == -1
        plot(x(i,1), x(i, 2), 'r*');
    end
    if d(i) == 1
        plot(x(i,1), x(i, 2), 'b*');
    end
    hold on;
end

%�w�K�O�v���b�g
%{
for i=1:2
p1 = plot(a, (-w1(1, i) * a + w1(3, i))/w1(2, i), 'b');
hold on;
end
%}

%�V�i�v�X�����׏d�̍X�V
while sum(err(:)) > 0.01
    %[���ԑw] �o��
    z1 = output(x, w1).';
    %[�o�͑w] �o��
    z2 = output(z1, w2).';
    y = z2;
    %���덷
    err = 1/2 * (d - y).^2
    %[�o�͑w] �V�i�v�X�����׏d�̍X�V
    delta2 = (d - y) .* (1 - y.^2) / 2;
    w2 = w2 + (alph * delta2.' * z1).';
    %[���ԑw]�@�V�i�v�X�����׏d�̍X�V
    for i=1:3
    delta1(i, :) = (delta2 * w2(i, :).') .* (1 - z1(:, i).^2)/2;
    w1(:,i) = w1(:,i) + (alph * delta1(i, :) * x).';
    end
end

%�w�K��v���b�g
figure;
hold on;
for i=1:size*10
    for j=1:size*10
        p = [i/10 j/10 -1];
        z1 = output(p, w1).';
        z2 = output(z1, w2).';
        y = z2;
        
        if y(1) > 0
            if y(2) > 0
                result(i) = 'f';
                plot(p(1), p(2), 'r*');
            else
                result(i) = 'l';
                plot(p(1), p(2), 'b*');
            end
        else
            if y(2) > 0
                result(i) = 'r';
                plot(p(1), p(2), 'g*');
            else
                result(i) = 's';
                plot(p(1), p(2), 'k*');
            end
        end
    end
end
