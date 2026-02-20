hs.loadSpoon('Hyper')
hs.loadSpoon('Split')
hs.loadSpoon('ElgatoKey'):start()

Config = {}
Config.applications = require('configApplications')

Hyper = spoon.Hyper

Hyper:bindHotKeys({
    hyperKey = {{}, 'F19'}
})

hs.fnutils.each(Config.applications, function(appConfig)
    if appConfig.hyperKey then
        Hyper:bind({}, appConfig.hyperKey, function()
            hs.application.launchOrFocusByBundleID(appConfig.bundleID)
        end)
    end
    if appConfig.localBindings then
        hs.fnutils.each(appConfig.localBindings, function(key)
            Hyper:bindPassThrough(key, appConfig.bundleID)
        end)
    end
end)

local brave = require('brave')
brave.start(Config)

-- Random bindings
Hyper:bind({}, 'r', nil, function()
    hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
end)
Hyper:bind({'shift'}, 'r', nil, function()
    hs.reload()
end)

local hyperGroup = function(key, tag)
    Hyper:bind({}, key, nil, function()
        hs.application.launchOrFocusByBundleID(hs.settings.get("group." .. tag))
    end)
    Hyper:bind({'option'}, key, nil, function()
        local group = hs.fnutils.filter(Config.applications, function(app)
            return app.tags and hs.fnutils.contains(app.tags, tag) and app.bundleID ~= hs.settings.get("group." .. tag)
        end)

        local choices = {}
        hs.fnutils.each(group, function(app)
            table.insert(choices, {
                text = hs.application.nameForBundleID(app.bundleID),
                image = hs.image.imageFromAppBundle(app.bundleID),
                bundleID = app.bundleID
            })
        end)

        if #choices == 1 then
            local app = choices[1]

            hs.notify.new(nil):title("Switching hyper+" .. key .. " to " .. hs.application.nameForBundleID(app.bundleID))
                :contentImage(hs.image.imageFromAppBundle(app.bundleID)):send()

            hs.settings.set("group." .. tag, app.bundleID)
            hs.application.launchOrFocusByBundleID(app.bundleID)
        else
            hs.chooser.new(function(app)
                if app then
                    hs.settings.set("group." .. tag, app.bundleID)
                    hs.application.launchOrFocusByBundleID(app.bundleID)
                end
            end):placeholderText("Choose an application for hyper+" .. key .. ":"):choices(choices):show()
        end
    end)
end

hyperGroup('q', 'personal')
hyperGroup('k', 'browsers')
hyperGroup('i', 'chat')

-- Jump to google hangout or zoom
Z_count = 0
Hyper:bind({}, 'z', nil, function()
    Z_count = Z_count + 1

    hs.timer.doAfter(0.5, function()
        Z_count = 0
    end)

    if Z_count == 2 then
        spoon.ElgatoKey:toggle()
    else
        -- start a timer
        -- if not pressed again then
        if hs.application.find('us.zoom.xos') then
            hs.application.launchOrFocusByBundleID('us.zoom.xos')
        elseif hs.application.find('com.microsoft.teams') then
            local call = spoon.Teamz.callWindow()
            if call then
                call:focus()
            end
        else
            brave.jump("meet.google.com|hangouts.google.com.call")
        end
    end
end)

-- Run or raise
hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "N", function()
    hs.application.launchOrFocusByBundleID('com.brave.Browser')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "T", function()
    hs.application.launchOrFocusByBundleID('com.microsoft.VSCode')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "I", function()
    hs.application.launchOrFocusByBundleID('com.googlecode.iterm2')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "S", function()
    hs.application.launchOrFocusByBundleID('com.tinyspeck.slackmacgap')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "D", function()
    hs.application.launchOrFocusByBundleID('com.hnc.Discord')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "M", function()
    hs.application.launchOrFocusByBundleID('com.apple.mail')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "F", function()
    hs.application.launchOrFocusByBundleID('com.apple.finder')
end)

-- hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "P", function()
--     hs.application.launchOrFocusByBundleID('com.postmanlabs.mac')
-- end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "X", function()
    hs.application.launchOrFocusByBundleID('com.spotify.client')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "Z", function()
    hs.application.launchOrFocusByBundleID('us.zoom.xos')
end)

-- hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "B", function()
--     hs.application.launchOrFocusByBundleID('com.obsproject.obs-studio')
-- end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "L", function()
    hs.application.launchOrFocusByBundleID('com.electron.logseq')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "W", function()
    hs.application.launchOrFocusByBundleID('net.whatsapp.WhatsApp')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "G", function()
    hs.application.launchOrFocusByBundleID('com.jetbrains.datagrip')
end)

hs.hotkey.bind({"shift", "cmd", "alt", "ctrl"}, "U", function()
    hs.application.launchOrFocusByBundleID('notion.id')
end)

-- local hyper = {"ctrl", "alt", "cmd"}

-- hs.loadSpoon("MiroWindowsManager")

-- hs.window.animationDuration = 0.3
-- spoon.MiroWindowsManager:bindHotkeys({
--     right = {hyper, "up"},
--     down = {hyper, "down"},
--     left = {hyper, "down"},
--     fullscreen = {hyper, "f"},
--     nextscreen = {hyper, "n"}
-- })
