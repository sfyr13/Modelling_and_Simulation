dt = [];
for theta = 1: 1: 10
    for g1 = 1: 1: 10
        for g2 = g1:1:10
        dt = [dt; theta, g1, g2 simulation(theta, g1, g2)];
        end
    end
end

[min, idx] = min(dt(:, 4));
theta = dt(idx, 1);
g1 = dt(idx, 2)
am = dt(idx, 3)