local slideBar = {}
slideBar.index = slideBar

function slideBar.new(_duration, _mode, _loop)
    local _animetion = setmetatable({
        mode = _mode,
        loop = _loop,
        duration = _duration,
        rect = {
            x = 0,
            y = 0,
            h = nil
        },
        x = 0, 
        sx = 0,
        alph = 0,
        text = ""
    }, slideBar)
    if _mode == "out" then _animetion.alph = 1 end
    return _animetion
end

function slideBar:print(_inputStr, _x, _y, _r, _sx, _sy, _ox, _oy)
--@                      ^         ^   ^   ^    ^    ^    ^   ^
--@                     str     numb numb numb numb numb numb numb
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
    local _r, _g, _b, _a = love.graphics.getColor()
    self.text = _inputStr
    self.x = _x - _ox * _sx
    if self.rect.y == 0 then
        self.rect.y = _y - _oy * _sy
    end
    if self.rect.x == 0 then
        self.rect.x = self.x
    end
    self.sx = _sx
    if self.rect.h == nil then
        self.rect.h = love.graphics.getFont():getHeight() * _sy
    end
    love.graphics.rectangle("fill", self.rect.x - 16, self.rect.y, 16, self.rect.h)
    love.graphics.setColor(_r, _g, _b, self.alph)
    love.graphics.print(_inputStr, _x, _y, nil, _sx, _sy, _ox, _oy)
    love.graphics.setColor(_r, _g, _b, _a)
end

function slideBar:update(_elapsed, _speed)
    if _speed == nil then _speed = 1 end
    --#verify type
    assert(type(_elapsed) == "number", "bad argument #1 to 'update' (number expected got " .. type(_elapsed) .. ")")
    assert(type(_speed) == "number", "bad argument #2 to 'update' (numner expected got " .. type(_speed) .. ")")
    --%function%--
    local _tweenX, _tweenA = ((love.graphics.getFont():getWidth(self.text) - self.x) / (self.duration * 100)) * _speed, 1 / (self.duration * 100) * _speed
    if self.mode == "in" then
        if self.rect.x - 16 <= self.x + (love.graphics.getFont():getWidth(self.text) * self.sx) then
            self.rect.x = self.rect.x - _tweenX
        else
            if self.rect.h > 0 then
                self.rect.y = self.rect.y + .5
                self.rect.h = self.rect.h - .5
            end
        end
        if self.alph < 1 then 
            self.alph = self.alph + _tweenA
        elseif self.loop then
            self.mode = "out"
        end
    else
        if self.rect.x >= self.x then
            self.rect.x = self.rect.x + _tweenX
        else
            if self.rect.h > 0 then
                self.rect.y = self.rect.y + .05
                self.rect.h = self.rect.h - .05
            end
        end
        if self.alph > 0 then 
            self.alph = self.alph - _tweenA
        elseif self.loop then
            self.mode = "in"
        end
    end
end

return slideBar 