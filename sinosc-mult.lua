-- 4 octaves if sines at the 4 outs
-- in 1: v/oct
-- in 2: fine tune

v = { 0, 0 }

function update()
                                                 --idk might just need to calibrate
    local voct = (v[1] + (v[2] / 10) + (3/12) +  0.0375)

    for i = 2,4 do
        output[i].dyn.freq = math.min(55 * 2^(voct + i - 1), 10000)
    end
end

-- for i = 1,2 do 
input[1].mode('stream', 0.01)
input[1].stream = function(vv)
    if vv ~= v[1] then
        v[1] = vv
        output[1].volts = vv
        update()
    end
end
input[2].mode('stream', 0.01)
input[2].stream = function(vv)
    if vv ~= v[2] then
        v[2] = vv
        -- output[1].volts = vv
        update()
    end
end
-- end

for i = 2,4 do
    output[i](oscillate(dyn{ freq = 400 }))
end
