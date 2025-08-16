-- 4 octaves if sines at the 4 outs
-- in 1: v/oct
-- in 2: fine tune

v = { 0, 0 }

function update()
                                                 --idk might just need to calibrate
    local voct = (v[1] + (v[2] / 10) + (3/12) +  0.0375)

    for i = 1,4 do
        output[i].dyn.freq = math.min(110 * 2^(voct + i - 1), 10000)
    end
end

for i = 1,2 do 
    input[i].mode('stream', 0.01)
    input[i].stream = function(vv)
        if vv ~= v[i] then
            v[i] = vv
            update()
        end
    end
end

for i = 1,4 do
    output[i](oscillate(dyn{ freq = 400 }))
end
