dt = [];
for p1 = 0.1: 0.2: 2
    for p2 = p1: 0.2: 2
        dt = [dt; p1, p2, simulation1(p1, p2)];
    end
end

[min, idx] = min(dt(:, 3));
p1 = dt(idx, 1)
p2 = dt(idx, 2)