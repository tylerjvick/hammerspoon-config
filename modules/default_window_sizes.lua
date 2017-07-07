-- -----------------------------------------------------------------------
--                       ** Default Window Sizes **                     --
-- -----------------------------------------------------------------------

local function module_init()
  local function defaultWindowSize()
    local win = hs.window.frontmostWindow()
    local name = win:application():name()
    local curFrame = win:frame()

    local function setWindowSize(width, height)
      local geo = hs.geometry(curFrame["_x"], curFrame["_y"], width, height)
      win:setFrame(geo)
    end
    -- Debug
    -- inspectToConsole(curFrame)
    -- 

    local function shortenAppName(longName)
      return longName:gsub("%s+", "_")
    end

    local shortName = shortenAppName(name)

    local function saveWindowSize()
      -- local shortName = shortenAppName(name)
      -- inspectToConsole(shortName)

      curSettings = hs.settings.get("window_sizes")
      -- curSettings will be nil at start
      if curSettings == nil then 
        curSettings = {}
      end

      curSettings[shortName] = {
        _h = curFrame["_h"],
        _w = curFrame["_w"]
      }

      hs.settings.set("window_sizes", curSettings)
    end

    local windowSizes = hs.settings.get("window_sizes")
    
    local function promptSave()
      if firstTime == nil or (os.time() - firstTime) >= 10 then
        hs.alert.show('No window size configured for this application')
        hs.alert.show('Enter hotkey again in 10 seconds to set current dimensions')
        -- inspectToConsole("setting firstTime")
        firstTime = os.time()
      elseif (os.time() - firstTime) < 10 then
        -- inspectToConsole("calling saveWindowSize, less than 10 seconds")
        saveWindowSize()
        firstTime = nil
      end
    end


    if windowSizes ~= nil then
      local appDimensions = windowSizes[shortName]
      -- inspectToConsole(name .. " found!")
      if appDimensions == nil then
        promptSave()
      else
        setWindowSize(appDimensions["_w"], appDimensions["_h"])
      end
    else
      -- inspectToConsole(name .. " not found!")
      promptSave()
    end


    -- if name == "Google Chrome" then setWindowSize(1060.0, 760.0)
    -- elseif name == "Sublime Text" then setWindowSize(740.0, 860.0)
    -- elseif name == "Terminal" then setWindowSize(570.0, 366.0)
    -- elseif name == "Microsoft Outlook" then setWindowSize(1350.0, 768.0)
    -- elseif name == "Finder" then setWindowSize(770.0, 428.0)
    -- end

  end

  hs.hotkey.bind({"cmd", "alt"}, "R", defaultWindowSize)
end

return {
  init = module_init
}