hs.hotkey.bind({"cmd", "alt", "ctrl"}, "U", function()
    hs.alert.show("Hello World!")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "t", function()
    hs.notify.new({
        title = "Hammerspoon",
        informativeText = "Hello World"
    }):send()
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.x = f.x - 10
    win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", function()
    hs.application.launchOrFocusByBundleID('com.brave.Browser')
end)
