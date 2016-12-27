close all;
clear all;

size = 3;
pos = [0.5 0.5 -1];
n = 1;

%�V�i�v�X�����׏d
w1 = [1.8542 -2.1499 -1.3665;
    -0.1016 8.6173 9.9020;
    4.5174 12.3631 7.7143];
w2 = [10.0484 -15.9198;
    -13.5588 5.5450;
    10.0489 -10.4867];

figure;
% ���H�̘g�̃v���b�g
hold on;
plot([0 size], [0 0], 'k', 'LineWidth', 2.0);
plot([0 size], [size size], 'k', 'LineWidth', 2.0);
plot([0 0], [0 size], 'k', 'LineWidth', 2.0);
plot([size size], [size 0], 'k', 'LineWidth', 2.0);

ax = gca;
ax.XTick = [0:1:size];
ax.YTick = [0:1:size];
ax.GridAlpha = 0.8;
grid on;

for i=1:size
    if mod(i, 2) == 1
        plot([0, size-1], [i, i], 'k', 'LineWidth', 2.0);
    else
        plot([1, size], [i, i], 'k', 'LineWidth', 2.0);
    end
end

%�A�j���[�V���������ꂽ���C���̍쐬
h = animatedline('Color', 'r', 'Marker', '*');

while(1)
    z1 = output(pos(n,:), w1).';
    z2 = output(z1, w2).';
    y = z2;
    
    if y(1) > 0
        if y(2) > 0
            %�O�i
            pos = pos + [0 rand() 0];
        else
            %������
            pos = pos + [-rand() 0 0];
        end
    else
        if y(2) > 0
            %�E����
            pos = pos + [rand() 0 0];
        else
            %��~
            break;
        end
    end
    %�A�j���[�V����
    addpoints(h, pos(1), pos(2));
    drawnow;
end

%�O�i�A������A�E����A��~�A���ꂼ��̗̈�̃v���b�g
figure;
hold on;
for i=1:30
    for j=1:30
        p = [i/10 j/10 -1];
        z1 = output(p, w1).';
        z2 = output(z1, w2).';
        y = z2;
        
        if y(1) > 0
            if y(2) > 0
                %�O�i
                plot(p(1), p(2), 'r*');
            else
                %������
                plot(p(1), p(2), 'b*');
            end
        else
            if y(2) > 0
                %�E����
                plot(p(1), p(2), 'g*');
            else
                %��~
                plot(p(1), p(2), 'k*');
            end
        end
    end
    ax = gca;
    ax.XTick = [0:1:size];
    ax.YTick = [0:1:size];
    ax.GridAlpha = 0.8;
    grid on;
end
