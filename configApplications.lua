return {
    ['com.runningwithcrayons.Alfred'] = {
        bundleID = 'com.runningwithcrayons.Alfred',
        localBindings = {'c', 'space', 'o', 'l'}
    },
    ['com.brave.Browser'] = {
        bundleID = 'com.brave.Browser',
        hyperKey = 's',
        tags = {'browsers'},
        layouts = {{nil, 1, hs.layout.maximized}, {"Confluence", 1, hs.layout.maximized},
                   {"Meet - ", 2, hs.layout.maximized}}
    },
    ['com.apple.Safari'] = {
        bundleID = 'com.apple.Safari',
        tags = {'browsers'},
        layouts = {{nil, 1, hs.layout.maximized}}
    },
    ['com.kapeli.dashdoc'] = {
        bundleID = 'com.kapeli.dashdoc',
        hyperKey = 'h',
        tags = {'coding'}
    },
    ['com.microsoft.teams'] = {
        bundleID = 'com.microsoft.teams',
        tags = {'communication', 'chat'},
        layouts = {{nil, 2, hs.layout.maximized}}
    },
    ['com.apple.mail'] = {
        bundleID = 'com.apple.mail',
        hyperKey = 'e',
        tags = {'communication', 'distraction'},
        layouts = {{nil, 2, hs.layout.maximized}}
    },
    ['com.flexibits.fantastical2.mac'] = {
        bundleID = 'com.flexibits.fantastical2.mac',
        hyperKey = 'y',
        localBindings = {'/'},
        tags = {'planning', 'review', 'calendar'},
        whitelisted = true,
        layouts = {{nil, 2, hs.layout.maximized}}
    },
    ['com.apple.finder'] = {
        bundleID = 'com.apple.finder',
        hyperKey = 'f'
    },
    ['com.hnc.Discord'] = {
        bundleID = 'com.hnc.Discord',
        tags = {'distraction', 'chat'},
        layouts = {{nil, 2, hs.layout.maximized}}
    },
    ['com.tinyspeck.slackmacgap'] = {
        bundleID = 'com.tinyspeck.slackmacgap',
        tags = {'distraction', 'communication', 'chat'},
        layouts = {{nil, 2, hs.layout.maximized}}
    },
    ['com.agiletortoise.Drafts-OSX'] = {
        bundleID = 'com.agiletortoise.Drafts-OSX',
        hyperKey = 'd',
        tags = {'review', 'writing', 'research', 'notes'},
        whitelisted = true,
        localBindings = {'x', ';'}
    },
    ['com.joehribar.toggl'] = {
        bundleID = 'com.joehribar.toggl',
        hyperKey = 'n'
    },
    ['com.apple.MobileSMS'] = {
        bundleID = 'com.apple.MobileSMS',
        tags = {'communication', 'distraction', 'personal'},
        layouts = {{nil, 2, hs.layout.right30}}
    },
    ['com.spotify.client'] = {
        bundleID = 'com.spotify.client'
    },
    ['com.roam-research.desktop-app'] = {
        bundleID = 'com.roam-research.desktop-app',
        hyperKey = 'g',
        tags = {'research', 'notes'},
        layouts = {{nil, 1, hs.layout.maximized}}
    },
    ['us.zoom.xos'] = {
        bundleID = 'us.zoom.xos',
        layouts = {{"Zoom Meeting", 2, hs.layout.maximized}}
    },
    ['org.whispersystems.signal-desktop'] = {
        bundleID = 'org.whispersystems.signal-desktop',
        tags = {'distraction', 'communication', 'personal'}
    },
    ['com.surteesstudios.Bartender'] = {
        bundleID = 'com.surteesstudios.Bartender',
        localBindings = {'b', 'u'}
    }
}
