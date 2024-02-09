--&private--
local BASE = (...) .. "."
local motiongalax =  {
    typewrite = require(BASE .. "typewrite"),
    fade = require(BASE .. "fade"),
    resize = require(BASE .. "resize"),
    pushLeft = require(BASE .. "pushLeft"),
    pushTop = require(BASE .. "pushTop"),
    slideBar = require(BASE .. "slideBar"),
    blink = require(BASE .. "blink")
}
--motiongalax.__index = motiongalax

--&public&--
function motiongalax.newEffect(_effect, _duration, _mode, _loop)
--@                            ^        ^          ^      ^
--@                           str      numb       str    bool
    --%error tratament%--
    --$if nil
    if _mode == nil then _mode = "in" end
    if _loop == nil then _loop = false end
    --$verify var type
    assert(type(_effect) == "string", "bad argument #1 to 'newEffect' (string expected, got " .. type(_effect) .. ")")
    assert(type(_duration) == "number", "bad argument #2 to 'newEffect' (string expected, got " .. type(_duration) .. ")")
    assert(type(_mode) == "string", "bad argument #3 to 'newEffect' (string expected, got " .. type(_mode) .. ")")
    assert(type(_loop) == "boolean", "bad argument #4 to 'newEffect' (string expected, got " .. type(_loop) .. ")")
    --$exepctions
    if not motiongalax[_effect] then
        error("bad argument #1 to 'newEffect' (invalid effect)")
    end
    if _mode ~= "in" and _mode ~= "out" then
        error("bad argument #3 to 'newEffect' (invalid mode)")
    end
    --%function%--
--    setmetatable(motiongalax, {
--        __index = motiongalax[_effect]
--    })
    return setmetatable(motiongalax[_effect].new(_duration, _mode, _loop), {
        --motiongalax
        __index = motiongalax[_effect]
    })
end

return motiongalax