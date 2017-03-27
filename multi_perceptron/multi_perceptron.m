clear all;
close all;

err = 50;
alph = 0.5;
n = 4;

%入力データ
x = [0 0 -1; 0 1 -1; 1 0 -1; 1 1 -1];
%教師データ
d = [-1; 1; 1; -1];
%シナプス結合荷重の初期化
w1 = [rand() rand() rand(); rand() rand() rand(); rand() rand() rand()];
w2 = [rand(); rand(); rand()];

figure();
a = linspace(-0.5, 1.5);
%入力値プロット
for i=1:n
    if d(i) == -1
        plot(x(i,1), x(i, 2), 'r*');
    end
    if d(i) == 1
        plot(x(i,1), x(i, 2), 'b*');
    end
    hold on;
end

%学習前プロット
for i=1:2
p1 = plot(a, (-w1(1, i) * a + w1(3, i))/w1(2, i), 'b');
hold on;
end

%シナプス結合荷重の更新
while sum(err) > 0.001
    %[中間層] 出力
    z1 = output(x, w1).';
    %[出力層] 出力
    z2 = output(z1, w2).';
    y = z2;
    %二乗誤差
    err = 1/2 * (d - y).^2;
    %[出力層] シナプス結合荷重の更新
    delta2 = (d - y) .* (1 - y.^2) / 2;
    w2 = w2 + (alph * delta2.' * z1).';
    %[中間層]　シナプス結合荷重の更新
    for i=1:3
    delta1(i, :) = (delta2 * w2(i)) .* (1 - z1(:, i).^2)/2;
    w1(:,i) = w1(:,i) + (alph * delta1(i, :) * x).';
    end
end

%学習後プロット
for i=0:10
    for j=0:10
        data = [i/10 j/10 -1];
        r1 = output(data, w1).';
        r2 = r1 * w2;
        if r2 < 0
            plot(i/10, j/10, 'r*');
        else
            plot(i/10, j/10, 'b*');
        end;
        hold on;
    end
end
for i=1:2
    p2 = plot(a, (-w1(1, i) * a + w1(3, i))/w1(2, i), 'r');
end
legend([p1  p2], '学習前','学習後');
