dt = [];
for g1 = 1: 1: 10
    for g2 = g1: 1: 10
        dt = [dt; g1, g2, simulation(g1, g2)];
    end
end

[min, idx] = min(dt(:, 3));
g1 = dt(idx, 1)
g2 = dt(idx, 2)