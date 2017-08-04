import = require('utils/import')
import.clear_cache()

config = import('config')

function config:get(key_path, default)
  local root = self
  for part in string.gmatch(key_path, "[^\\.]+") do
    root = root[part]
    if root == nil then
      return default
    end
  end
  return root
end

-- -----------------------------------------------------------------------
--                         ** Extra Requires **                         --
-- -----------------------------------------------------------------------

require "window_manager"
-- require "outlook"
require "debug"
-- require "modules/safari_inspector"



local modules = {}

for _, v in ipairs(config.modules) do
  local module_name = 'modules/' .. v
  local module = import(module_name)

  if type(module.init) == "function" then
    module.init()
  end

  table.insert(modules, module)
end


-- -----------------------------------------------------------------------
--                         ** Debug Utilities **                        --
-- -----------------------------------------------------------------------

function reloadConfig(files)
    local doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


-- Helper function to inspect a given item to the console
function inspectToConsole(object)
  hs.console.printStyledtext(hs.inspect(object))
end

-- TESTING hotkey bind override to check for conflicting keycombos
local oldBind = hs.hotkey.bind
local registeredHotkeys = {}
hs.hotkey.bind = function(...)
  local mods = select(1, ...)
  local key = select(2, ...)
  table.insert(registeredHotkeys, { mods, key })
  inspectToConsole(registeredHotkeys)
  oldBind(...)
end


-- -----------------------------------------------------------------------
--                         ** Hotkey Bindings **                        --
-- -----------------------------------------------------------------------

-- hs.hotkey.bind({"cmd", "shift"}, "M", toggleChromeProfile)


-- Stuff that shouldn't be here
hs.loadSpoon("RoundedCorners")
spoon.RoundedCorners:start()

hs.application.watcher.new(function(appName, event, application)
    if appName == "HipChat" and event == hs.application.watcher.launched then
        hs.alert.show("HipChat launched!")
    end
end):start()