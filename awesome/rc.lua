-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widget library
-- local vicious = require("vicious")
require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua") -- ORIGINAL
beautiful.init(awful.util.getdir("config") .. "/themes/robs/theme.lua")

-- This is used later as the default terminal and editor to run.
-- terminal = "xterm" ORIGINAL ENTRY
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags - ORIGINAL
---- Define a tag table which hold all screen tags.
--tags = {}
--for s = 1, screen.count() do
--    -- Each screen has its own tag table.
--    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
--end
---- }}}

-- {{{ Tags NEW from the "my first awesome" wiki page
-- Define a tag table which hold all screen tags.
tags = {
  names  = { "main", 2, 3, 4, 5, 6, 7, 8, 9 },
  layout = { layouts[1],  layouts[2], layouts[1], layouts[5], layouts[6], layouts[12], layouts[9], layouts[3], layouts[7]
}}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "lock", "xscreensaver-command --lock" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

myterminalmenu = {
  { "urxvt", "urxvt" }, 
  { "terminator", "terminator" }
}

myaccessorymenu = {
  { "KeePassX", "keepassx" },
  { "leafpad", "leafpad" },
  { "meld", "meld" },
  { "motion", terminal .. " -e motion -s" },
  { "thunar", "thunar" }
}

myinternetmenu = {
  { "chromium", "chromium" },
  { "firefox", "firefox" }
}

myofficemenu = {
  { "Libre calc", "libreoffice --calc" },
  { "Libre writer", "libreoffice --writer" }
}

mymediamenu = {
  { "alsamixer", terminal .. " -e alsamixer" },
  { "asunder", "asunder" },
  { "handbrake", "ghb" },
  { "vlc", "vlc" }
}

mygamesmenu = {
  { "aisleriot", "sol" },
  { "sauerbraten", "sauerbraten-client" },
  { "xmahjongg", "xmahjongg" },
  { "xonotic", "xonotic-glx" }
}

mygraphicsmenu = {
  { "darktable", "darktable" },
  { "digikam", "digikam" },
  { "hugin", "hugin" },
  { "luminance", "luminance-hdr" },
  { "mirage", "mirage" },
  { "nitrogen", "nitrogen" }
}

mypowermenu = {
  { "reboot", "sudo shutdown -r now" },
  { "shutdown", "sudo shutdown -h now" }
}

myscriptmenu = {
  { "dotfiles", "ruby /home/rob/scripts/Projects/dotfiles/copy_dotfiles.rb" }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "terminals", myterminalmenu },
                                    { "accessories", myaccessorymenu },
                                    { "internet", myinternetmenu },
                                    { "office", myofficemenu },
                                    { "media", mymediamenu },
                                    { "graphics", mygraphicsmenu },
                                    { "games", mygamesmenu },
                                    { "power", mypowermenu },
                                    { "scripts", myscriptmenu },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Calendar widget to attach to the textclock
require('calendar2')
calendar2.addCalendarToWidget(mytextclock)

-- Create a systray
mysystray = widget({ type = "systray" })

-- create a test icon widget
-- myicon = widget({ type = "imagebox" })
-- myicon.image = image(awful.util.getdir("config") .. "/myicon.png")

-- and a test text widget
-- mytextboxtest = widget({ type = "textbox" })
-- mytextboxtest.text = "hoot"

-- create a test graph widget
-- mygraph = awful.widget.graph()
-- mygraph:set_width(150)
-- mygraph:set_background_color('#494B4F')
-- mygraph:set_color('#FF5656')
-- mygraph:set_gradient_colors({ '#FF5656', '#88A175', '#ARCF96' })
-- mygraph:add_value(0.4)
-- mygraph:add_value(0.8)
    
-- network usage widget
-- initialise widget
netwidget = widget({ type = "textbox" })
-- register widget
vicious.register(netwidget, vicious.widgets.net, '<span color="#CC9393">${eth0 down_kb}</span> <span color="#7F9F7F">${eth0 up_kb}</span>', 3)
dnicon = widget({ type = "imagebox" })
upicon = widget({ type = "imagebox" })
dnicon.image = image(beautiful.widget_net)
upicon.image = image(beautiful.widget_netup)

-- Disk usage widget
diskwidget = widget({ type = 'imagebox' })
diskwidget.image = image("/home/rob/.config/awesome/themes/robs/icons/du.png")
disk = require("diskusage")
-- the first argument is the widget to trigger the diskusage
-- the second/third is the percentage at which a line gets orange/red
-- true = show only local filesystems
disk.addToWidget(diskwidget, 75, 90, false)

-- Date widget
-- datewidget = widget({ type = "textbox" })
-- vicious.register(datewidget, vicious.widgets.date, "%b %d, %R")

-- Memory widget (1)
memwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "$1% ($2MB/$3MB)", 13)

-- RAM usage widget (2)
-- memwidget = awful.widget.progressbar()
-- memwidget:set_width(15)
-- memwidget:set_height(30)
-- memwidget:set_vertical(true)
-- memwidget:set_background_color('#494B4F')
-- memwidget:set_color('#AECF96')
-- memwidget:set_gradient_colors({ '#AECF96', '#88A175', '#FF5656' })
-- memwidget:set_value(0.5)

-- RAM usage tooltip
-- memwidget_t = awful.tooltip({ objects = { memwidget.widget },})

-- vicious.cache(vicious.widgets.mem)
-- vicious.register(memwidget, vicious.widgets.mem,
--                 function (widget, args)
--                     memwidget_t:set_text(" RAM: " .. args[2] .. "MB / " .. args[3] .. "MB ")
--                     return args[1]
--                  end, 13)
--                  --update every 13 seconds

-- uptime widget
-- uptimewidget = widget({ type = "textbox" })
-- vicious.register(uptimewidget, vicious.widgets.uptime, "$1d $2h $3m ($4, $5, $6)", 5)

-- cpuwidget
-- cpuwidget = awful.widget.graph()
-- cpuwidget:set_width(50)
-- cpuwidget:set_background_color("#494B4F")
-- cpuwidget:set_color("#FF5656")
-- cpuwidget:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
-- vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 3)
-- cpuwidget = awful.widget.graph()
-- cpuwidget:set_width(50)
-- cpuwidget:set_background_color("#494B4F")
-- cpuwidget:set_color("#FF5656")
-- cpuwidget:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
-- vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 3)

-- separator
separator = widget({ type = "textbox" })
separator.text = " :: "

-- test calling bash script to ouptput as tooltip
-- script is /home/rob/scripts/test/git_status.sh
function get_gitstatus()
  local fd = io.popen("/usr/bin/ruby /home/rob/scripts/Projects/git_status/bin/get_git_status.rb /home/rob/scripts/Projects/dotfiles")
  local str = fd:read("*all")
  return str
end
-- set up icon
gsimg = widget({ type = "imagebox" })
gsimg.image = image(awful.util.getdir("config") .. "/themes/robs/icons/test.png")
-- set up tooltip
gsimg_t = awful.tooltip({ objects = { gsimg },})
mytimer = timer({ timeout = 3 })
mytimer:add_signal("timeout", function()
gsimg_t:set_text(get_gitstatus()) end )
mytimer:start()
-- gsimg_t:set_text(get_gitstatus())

-- git status for dotfiles widget
-- text box for repo name
mytextboxgsdotfiles = widget({ type = "textbox" })
mytextboxgsdotfiles.text = "dotfiles "
-- text box for repo status
mytextboxgs = widget({ type = "textbox" })
-- mytimer = timer({ timeout = 5 })
-- mytime:add_signal("timeout", mytextboxgs.text = get_gitstatus() )
mytextboxgs.text = get_gitstatus()
-- mytimer:start()

-- gmail widget and tooltip
-- mygmail = widget({ type = "textbox" })
-- gmail_t = awful.tooltip({ objects = { mygmail },})
-- mygmailimg = widget({ type = "imagebox" })
-- mygmailimg.image = image("/home/rob/.config/awesome/themes/robs/icons/mail.png")

-- Pacman Widget
-- pacwidget = widget({type = "textbox"})
-- pacwidget_t = awful.tooltip({ objects = { pacwidget},})
-- vicious.register(pacwidget, vicious.widgets.pkg,
--                function(widget,args)
--                     local io = { popen = io.popen }
--                     local s = io.popen("pacman -Qu")
--                     local str = ''
--
--                     for line in s:lines() do
--                         str = str .. line .. "\n"
--                     end
--                     pacwidget_t:set_text(str)
--                    s:close()
--                     return "UPDATES: " .. args[1]
--                 end, 1800, "Arch")

                --'1800' means check every 30 minutes

-- vicious.register(mygmail, vicious.widgets.gmail,
--                 function (widget, args)
--                     gmail_t:set_text(args["{subject}"])
--                     gmail_t:add_to_object(mygmailimg)
--                     return args["{count}"]
--                  end, 120) 
--                 --the '120' here means check every 2 minutes.

-- RAM usage widget
-- memwidget = awful.widget.progressbar()
-- memwidget:set_width(15)
-- memwidget:set_height(30)
-- memwidget:set_vertical(true)
-- memwidget:set_background_color('#494B4F')
-- memwidget:set_color('#AECF96')
-- memwidget:set_gradient_colors({ '#AECF96', '#88A175', '#FF5656' })

-- RAM usage tooltip
-- memwidget_t = awful.tooltip({ objects = { memwidget.widget },})

-- vicious.cache(vicious.widgets.mem)
-- vicious.register(memwidget, vicious.widgets.mem,
--                function (widget, args)
--                    memwidget_t:set_text(" RAM: " .. args[2] .. "MB / " .. args[3] .. "MB ")
--                    return args[1]
--                 end, 13)
--                 --update every 13 seconds

-- Create a wibox for each screen and add it
mywibox = {}
mywiboxbottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        separator, upicon, netwidget, dnicon, 
        separator, diskwidget,
        separator, gsimg,
        separator, mytextboxgs, mytextboxgsdotfiles,
        -- separator, mygmail, mygmailimg,
        -- separator, pacwidget,
        -- separator, memwidget.widget,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

    -- bottom wibox
    mywiboxbottom[s] = awful.wibox({ position = "bottom", screen = s })
    -- add widgets to the new wibox
    mywiboxbottom[s].widgets = {
      {
        -- myicon,
        -- mytextboxtest,
        -- datewidget,
        -- gsimg,
        -- mytextboxgsdotfiles, 
        -- memwidget,
        -- separator, uptimewidget,
        -- cpuwidget,
        -- netwidget,
        -- mygraph,
        layout = awful.widget.layout.horizontal.leftright
      }
    } 

end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "Gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- attempt to autostart apps; info from awesome arch wiki entry
do
  local cmds = 
  {
    -- "leafpad"
    "xscreensaver -no-splash"
  }

  for _,i in pairs(cmds) do
    awful.util.spawn(i)
  end
end
