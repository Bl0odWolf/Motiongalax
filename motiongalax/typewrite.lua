--&private&--
local typewrite = {}
typewrite.__index = typewrite

--&public&--
function typewrite.new(_duration, _mode, _loop)
--@                    ^          ^      ^
--@                   numb       str    bool
    local _animetion = setmetatable({
        duration = _duration,
        mode = _mode,
        loop = _loop,
        textTbl = {},
        text = "",
        toPrint = nil,
        timer = 0,
        count = 0
    }, typewrite)
    if _mode == "in" then
        _animetion.index = 1
    end
    return _animetion
end

function typewrite:print(_inputStr, _x, _y, _r, _sx, _sy, _ox, _oy)
--@                      ^          ^   ^   ^    ^    ^    ^    ^
--@                     str      numb numb numb numb numb numb numb
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
    self.text = _inputStr
    if self.mode == "in" then
        if self.toPrint == nil then
            self.toPrint = ""
        end
    else
        if self.toPrint == nil then
            self.toPrint = _inputStr
        end
    end
    love.graphics.print(self.toPrint, _x, _y, _r, _sx, _sy, _ox, _oy)
end

function typewrite:update(_elapsed, _speed)
--@                       ^         ^
--@                      numb      numb
    --%error tratament%--
    --#if nil
    if _speed == nil then _speed = 1 end
    --#verify type
    assert(type(_elapsed) == "number", "bad argument #1 to 'update' (number expected got " .. type(_elapsed) .. ")")
    assert(type(_speed) == "number", "bad argument #2 to 'update' (numner expected got " .. type(_speed) .. ")")
    --%function%--
    --#get all string chars
    if self.text ~= table.concat(self.textTbl, "") then
        self.textTbl = {}
        for c in string.gmatch(self.text, ".") do
            table.insert(self.textTbl, c)
        end
        self.count = self.duration/#self.textTbl
        if self.mode == "in" then
            self.toPrint = ""
            self.index = 1
        else
            self.toPrint = self.text
        end
    end
    --#timer
    self.timer = (self.timer + _elapsed) * _speed
    if self.count >= 0 then
        self.count = self.count - self.timer
        self.timer = 0
    else
        if self.mode == "in" then
            if self.toPrint ~= self.text then
                self.toPrint = self.toPrint .. self.textTbl[self.index]
                self.index = self.index + 1
            elseif self.loop then
                self.toPrint = ""
                self.index = 1
            end
        else
            if self.toPrint ~= "" then
                self.toPrint = string.sub(self.toPrint, 1, -2)
            elseif self.loop then
                self.toPrint = self.text
            end
        end
        self.count = self.duration/#self.textTbl
        self.timer = 0
    end
end

return typewrite