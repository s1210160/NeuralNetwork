clear all;
close all;

err = 50;
alph = 0.5;
n = 4;

%���̓f�[�^
x = [0 0 -1; 0 1 -1; 1 0 -1; 1 1 -1];
%���t�f�[�^
d = [-1 -1 -1 1];
%�V�i�v�X�����׏d�̏�����
w = [rand(); rand(); rand()];

figure();
a = linspace(-0.5, 1.5);
%���̓f�[�^�v���b�g
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
p1 = plot(a, (-w(1) * a + w(3))/w(2));

%�V�i�v�X�����׏d�̍X�V
while err > 0.001
    y = output(x, w);
    err = (d-y).^2 * 0.5 * ones(n, 1);
    delta = (d-y) .* (1-y.^2)/2;
    w = w + (alph * delta * x).';
end

%�w�K��v���b�g
for i=0:10
    for j=0:10
        data = [i/10 j/10 -1];
        r1 = data * w
        if r1 < 0
            plot(i/10, j/10, 'r*');
        else
            plot(i/10, j/10, 'b*');
        end;
        hold on;
    end
end

p2 = plot(a, (-w(1) * a + w(3))/w(2));
legend([p1  p2], '�w�K�O','�w�K��');