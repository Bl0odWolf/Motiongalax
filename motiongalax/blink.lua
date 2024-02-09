local blink = {}
blink.index = blink

function blink.new(_duration, _mode, _loop)
    local _animetion = setmetatable({
        mode = _mode,
        loop = _loop,
        duration = _duration,
        count = 0,
        timer = 0,
        blink = false
    }, blink)
    if _mode == "out" then
        _animetion.blink = true
    end
    return _animetion
end

function blink:print(_inputStr, _x, _y, _r,  _sx, _sy, _ox, _oy)
--@                      ^       ^  ^   ^    ^    ^    ^    ^
--@                     str    numb numb numb numb numb numb numb
    --%error tratament%--
    --#if nil
    if _x == nil then _x = 0 end
    if _y == nil then _y = 0 end
    if _r == nil then _r = 0 end
    if _sx == nil then _sx = 1 end
    if _sy == nil then _sy = 1 end
    if _ox == nil then _ox = 0 end
    if _oy == nil then _oy = 0 end
    --#verify type
    assert(type(_inputStr) == "string", "bad argument #1 to 'print' (string expected. got " .. type(_inputStr) .. ")")
    assert(type(_x) == "number", "bad argument #2 to 'print' (number expected. got " .. type(_x) .. ")")
    assert(type(_y) == "number", "bad argument #3 to 'print' (number expected. got " .. type(_r) .. ")")
    assert(type(_r) == "number", "bad argument #4 to 'print' (number expected. got " .. type(_y) .. ")")
    assert(type(_sx) == "number", "bad argument #5 to 'print' (number expected. got " .. type(_sx) .. ")")
    assert(type(_sy) == "number", "bad argument #6 to 'print' (number expected. got " .. type(_sy) .. ")")
    assert(type(_ox) == "number", "bad argument #7 to 'print' (number expected. got " .. type(_ox) .. ")")
    assert(type(_oy) == "number", "bad argument #8 to 'print' (number expected. got " .. type(_oy) .. ")")
    --%function%--
    if self.blink then
        love.graphics.print(_inputStr, _x, _y, _r, _sx, _sy, _ox, _ou)
    end
end

function blink:update(_elapsed, _speed)
    --%error tratament%--
    --#if nil
    if _speed == nil then
        _speed = 1
    end
    --#verify type
    assert(type(_elapsed) == "number", "bad argument #1 to 'update' (number expected got " .. type(_elapsed) .. ")")
    assert(type(_speed) == "number", "bad argument #2 to 'update' (numner expected got " .. type(_speed) .. ")")
    --%function%--
    --#timer
    self.timer = (self.timer + _elapsed) * _speed
    if self.count >= 0 then
        self.count = self.count - self.timer
        self.timer = 0
    else
        if self.mode == "in" then
            self.blink = true
            if self.loop then 
                self.mode = "out"
            end
        else
            self.blink = false
            if self.loop then 
                self.mode = "in"
            end
        end
        self.count = self.duration
        self.timer = 0
    end
end

return blink