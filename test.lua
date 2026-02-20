hs.loadSpoon('Hyper')
hs.loadSpoon('Split')

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

-- Jump to figma
Hyper:bind({}, 'v', nil, function()
    if hs.application.find('com.figma.Desktop') then
        hs.application.launchOrFocusByBundleID('com.figma.Desktop')
    elseif hs.application.find('com.electron.realtimeboard') then
        hs.application.launchOrFocusByBundleID('com.electron.realtimeboard')
    elseif hs.application.find('com.adobe.LightroomClassicCC7') then
        hs.application.launchOrFocusByBundleID('com.adobe.LightroomClassicCC7')
    else
        brave.jump("lucidchart.com|figma.com")
    end
end)

Hyper:bind({}, 'p', nil, function()
    local _success, projects, _output = hs.osascript.javascript([[
    (function() {
      var Things = Application("Things");
      var divider = /## Resources/;

      Things.launch();

      let getUrls = function(proj) {
        if (proj.notes() && proj.notes().match(divider)) {
          return proj.notes()
                     .split(divider)[1]
                     .replace(divider, "")
                     .split("\n")
                     .map(str => str.replace(/^- /, ""))
                     .filter(s => s != "")
        }
        else {
          return false;
        }
      }

      let projects =
        Things
        .projects()
        .filter(t => t.status() == "open")
        .map(function(proj) {
          return {
            text: proj.name(),
            subText: proj.area().name(),
            urls: getUrls(proj),
            id: proj.id()
          }
        })
        .filter(function(proj) {
          return proj.urls
        });

      return projects;
    })();
  ]])

    hs.chooser.new(function(choice)
        hs.fnutils.each(choice.urls, hs.urlevent.openURL)
        hs.urlevent.openURL("things:///show?id=" .. choice.id)
    end):placeholderText("Choose a project…"):choices(projects):show()
end)

require('browserSnip')
