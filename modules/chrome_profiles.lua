-- -----------------------------------------------------------------------
--                        ** Control Functions **                       --
-- -----------------------------------------------------------------------

local function module_init()
  -- Toggle Chrome profiles 
  local function toggleChromeProfile()
    local profileOne = "Tyler Epic"
    local profileTwo = "Tyler"

    local function selectedChromeProfile(menuItems)
      for k, v in pairs(menuItems) do
        if v["AXTitle"] == "People" then
          for a, i in pairs(v["AXChildren"][1]) do
            if i["AXMenuItemMarkChar"] ~= "" then
              return i["AXTitle"]
            end
          end
        end
      end
      return nil
    end

    local selected = nil
    local chrome = hs.application.get("Google Chrome")
    if chrome:isFrontmost() then
      local menuItems = chrome:getMenuItems()
      local selectedChromeProfile = selectedChromeProfile(menuItems)
      if selectedChromeProfile == profileOne then
        chrome:selectMenuItem({"People", profileTwo})
      else
        chrome:selectMenuItem({"People", profileOne})
      end
    end
  end
end

return {
  init = module_init
}