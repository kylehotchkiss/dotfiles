require("hs.ipc") -- enables the `hs` command-line tool

hs.window.animationDuration = 0

local hyper = { "alt" }

-- Placements: given the screen's usable frame (excluding menu bar and Dock)
-- and a window size, return the top-left point for the window
local function center(s, w, h)
  return s.x + (s.w - w) / 2, s.y + (s.h - h) / 2
end

local function topLeft(s, w, h)
  return s.x, s.y
end

-- Resize to a fixed size (in points) and place it, as a single frame change.
-- Doing both at once avoids macOS clamping the size against the window's old
-- position. If the app enforces its own min/max size, re-place using the size
-- it actually accepted so the placement still holds.
local function sizeAndPlace(w, h, place)
  return function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local s = win:screen():frame()
    local tw, th = math.min(w, s.w), math.min(h, s.h)
    local x, y = place(s, tw, th)
    win:setFrame(hs.geometry.rect(x, y, tw, th))

    local f = win:frame()
    if f.w ~= tw or f.h ~= th then
      f.x, f.y = place(s, f.w, f.h)
      win:setFrame(f)
    end
  end
end

-- Option-1 (Large Window Size): 1800x1040, centered (fills smaller screens)
hs.hotkey.bind(hyper, "1", sizeAndPlace(1800, 1040, center))

-- Option-2 (Standard Window Size): 1280x740, centered
hs.hotkey.bind(hyper, "2", sizeAndPlace(1280, 740, center))

-- Option-3 (Feed Window Size): 460x500, top-left corner
hs.hotkey.bind(hyper, "3", sizeAndPlace(460, 500, topLeft))

-- Option-4 (Terminal Window Size): 710x375, centered
hs.hotkey.bind(hyper, "4", sizeAndPlace(710, 375, center))

-- App shortcuts: launch the app, or focus it if it's already running
local apps = {
  b = "Brave Browser",
  c = "ChatGPT",
  f = "Fantastical",
  g = "Music",
  i = "Messages",
  m = "Mimestream",
  n = "Notes",
  p = "1Password",
  s = "Safari",
  t = "Ghostty",
  v = "Visual Studio Code",
}

for key, app in pairs(apps) do
  hs.hotkey.bind(hyper, key, function() hs.application.launchOrFocus(app) end)
end

-- Site shortcuts: switch to an open Safari tab for the site if there is one,
-- otherwise open it in a new tab
local sites = {
  h = "hotchkissmade.com",
  k = "kylehotchkiss.com",
  y = "news.ycombinator.com",
}

local function safariSite(domain)
  hs.osascript.applescript(string.format([[
    tell application "Safari"
      activate
      repeat with w in windows
        repeat with t in tabs of w
          if URL of t contains "%s" then
            set current tab of w to t
            set index of w to 1
            return
          end if
        end repeat
      end repeat
      if (count of windows) is 0 then
        make new document with properties {URL:"https://%s"}
      else
        tell front window to set current tab to (make new tab with properties {URL:"https://%s"})
      end if
    end tell
  ]], domain, domain, domain))
end

for key, domain in pairs(sites) do
  hs.hotkey.bind(hyper, key, function() safariSite(domain) end)
end

-- Option-5 (Move to Right): move to the next display, looping around.
-- This control has no hot key assigned in Moom; uncomment to bind it to Option-5.
-- hs.hotkey.bind(hyper, "5", function()
--   local win = hs.window.focusedWindow()
--   if win then win:moveToScreen(win:screen():next(), false, true) end
-- end)
