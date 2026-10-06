local net = require("enet")

return function (ip)
    local M = {}
    if ip == nil then
        ip = "147.185.221.19:9501"
    end
    local clie = net.host_create()
    local serv = clie:connect(ip)
    local msgs = {}
    local subs = {}
    M.connect = false
    M.tick = function ()
        local msg = clie:service()
        if msg then
            if msg.type == "connect" then
                if M.connect then
                    M.connect()
                end
            end
            if msg.type == "receive" then
                local tag = string.sub(msg.data,1,4)+0
                local data = string.sub(msg.data,5)
                if msgs[tag] then
                    msgs[tag](data)
                    msgs[tag] = nil
                elseif tag == 0 then
                    local sub = subs[string.sub(data,1,8)]
                    if sub then
                        sub.onMsg(string.sub(data,9))
                    end
                end
            end
        end 
    end
    local send = function (msg,func)
        local id = 1000
        while msgs[id] do
            id = love.math.random(1000,9999)
        end
        msgs[id] = func
        serv:send(id..msg)
    end
    M.ping = function (func)
        local t1 = love.timer.getTime()
        send("p",function (t)
            func(love.timer.getTime()-t1)
        end)
    end
    local newSub = function (name)
        local s = {}
        s.msg = function (msg)
            send("m"..name..msg,s.onMsg)
        end
        s.onMsg = print

        subs[name] = s
        return s
    end
    local hashes = {}
    local formatSub = function (raw)
        if hashes[raw] then
            return hashes[raw]
        end
        local hash = string.sub(love.data.hash("sha256",raw),1,8)
        hashes[raw] = hash
        print(raw.." -> "..hash)
        return hash
    end
    M.isSub = function (name,func)
        name = formatSub(name)
        send("i"..name,function (num)
            func((num+0)==1)
        end)
    end
    M.joinSub = function (name,pass,func)
        name = formatSub(name)
        send("s"..name..pass,function (isIn)
            isIn = (isIn+0)==1
            if isIn then
                func(newSub(name))
            else
                func(nil)
            end
        end)
    end
    return M
end