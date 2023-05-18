dt = [];
for p1 = 100: 20: 500
    for p2 = p1: 20: 500
        dt = [dt; p1, p2, simulation2(p1, p2)];
    end
end

[min, idx] = min(dt(:, 3));
p1 = dt(idx, 1)
p2 = dt(idx, 2)