clear all;
close all;

err = 50;
alph = 0.1;
size = 3;

%ファイル読み込み
input = csvread('input.csv');
%入力データ
x = input(:, 1:3);
%教師データ
d = input(:, 5:6);

%シナプス結合荷重の初期化
w1 = [rand() rand() rand(); rand() rand() rand(); rand() rand() rand()];
w2 = [rand() rand(); rand() rand(); rand() rand()];

figure();
hold on;
axis([0 3 0 3]);
%入力値プロット
%[1,1]->forward [1,-1]->left, [-1,1]->right, [-1,-1]->stop
for i=1:length(x)
    if d(i, 1) == 1
        if d(i, 2) == 1
            plot(x(i,1), x(i, 2), 'r*');
        else
            plot(x(i,1), x(i, 2), 'b*');
        end
    else
        if d(i, 2) == 1
            plot(x(i,1), x(i, 2), 'g*');
        else
            plot(x(i,1), x(i, 2), 'k*');
        end
    end
end

%シナプス結合荷重の更新
while sum(err(:)) > 0.01
    %[中間層] 出力
    z1 = output(x, w1).';
    %[出力層] 出力
    z2 = output(z1, w2).';
    y = z2;
    %二乗誤差
    err = 1/2 * (d - y).^2
    %[出力層] シナプス結合荷重の更新
    delta2 = (d - y) .* (1 - y.^2) / 2;
    w2 = w2 + (alph * delta2.' * z1).';
    %[中間層]　シナプス結合荷重の更新
    for i=1:3
    delta1(i, :) = (delta2 * w2(i, :).') .* (1 - z1(:, i).^2)/2;
    w1(:,i) = w1(:,i) + (alph * delta1(i, :) * x).';
    end
end

%学習後プロット
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
