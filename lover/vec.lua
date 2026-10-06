local T = {}

local function vec(...)
    local t = {...} ---@class vec
    t.len = #t
    setmetatable(t,T.m)

    t.le2 = function ()
        local l = 0
        for v = 1,t.len do
            l = l + t[v]^2
        end
        return l
    end

    t.le = function ()
        return math.sqrt(t.le2())
    end

    t.un = function ()
        local le = math.sqrt(t.le2())
        if le == 0 then
            return vec(1,0)
        end
        return (1/le)*t
    end

    t.lo = function (f)
        for v = 1,t.len do
            f(v,t[v])
        end
    end

    t.rot = function (theta,i1,i2)
        if i1 == nil then i1 = 1 end
        if i2 == nil then i2 = 2 end
        return vec(t[i1]*math.cos(theta)-t[i2]*math.sin(theta),t[i1]*math.sin(theta)+t[i2]*math.cos(theta))
    end

    return t
end

T.n = vec

T.l = {"x","y","z","w","v","u","t","s","r","q","p","o","n","m","l","k","j","i","h","g","f","e","d","c","b","a"}

T.m = {
    ["__add"] = function (t1, t2)
        local f = T.z(t1.len)
        for v = 1,t1.len do
            f[v] = t1[v] + t2[v]
        end
        return f
    end,
    ["__sub"] = function (t1, t2)
        local f = T.z(t1.len)
            for v = 1,t1.len do
            f[v] = t1[v] - t2[v]
        end
        return f
    end,
    ["__unm"] = function (t1)
        return -1*t1
    end,
    ["__mul"] = function (t1, t2)
        if type(t1) == "table" and type(t2) == "table" then
            local f = 0
            for v = 1,t1.len do
                f = f + (t1[v] * t2[v])
            end
            return f
        elseif type(t1) == "number" then
            local f = T.z(t2.len)
            for v = 1,t2.len do
                f[v] = t1 * t2[v]
            end
            return f
        else
            local f = T.z(t1.len)
            for v = 1,t1.len do
                f[v] = t1[v] * t2
            end
            return f
        end
    end,
    ["__div"] = function (t1, t2)
        if type(t1) == "number" then
            local f = T.z(t2.len)
            for v = 1,t2.len do
                f[v] = t1 / t2[v]
            end
            return f
        else
            local f = T.z(t1.len)
            for v = 1,t1.len do
                f[v] = t1[v] / t2
            end
            return f
        end
    end,
    ["__eq"] = function (t1, t2)
        if t1.len ~= t2.len then
            return false
        end
        for v = 1,t1.len do
            if t1[v] ~= t2[v] then
                return false
            end
        end
        return true
    end,
    ["__tostring"] = function (t1)
        local s = "vec"..t1.len.."("
        for v = 1,t1.len-1 do
            s = s..t1[v]..", "
        end
        return s..t1[t1.len]..")"
    end,
    ["__len"] = function (t1)
        return t1.len
    end,
    ["__index"] = function (t1,v1)
        for v,o in pairs(T.l) do
            if o == v1 then
                if v <= #t1 then
                    return t1[v]
                end
                return 0
            end
        end
        return rawget(t1,v1)
    end,
    ["__newindex"] = function (t1,v1,o1)
        for v,o in pairs(T.l) do
            if o == v1 then
                if v <= #t1 then
                    t1[v] = o1
                end
                return 0
            end
        end
        return rawset(t1,v1,o1)
    end
}

function T.z(dim)
    local t = {}
    for v = 1,dim do
        t[v] = 0
    end
    return T.n(unpack(t))
end

return T