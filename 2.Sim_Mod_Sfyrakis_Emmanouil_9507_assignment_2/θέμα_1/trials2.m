dt = [];
for g = 1: 1: 50
    for am = 1: 0.5: 8
        dt = [dt; g, am, simulation_2(g, am)];
    end
end

[min, idx] = min(dt(:, 3));
g = dt(idx, 1)
am = dt(idx, 2)