
local function module_init()

  local mash = {"cmd", "alt", "shift"}
  local key = "I"

  function openWebInspector(path)
    local safari = hs.application.get('Safari')
    safari:selectMenuItem(path)
  end

  hs.hotkey.bind(mash, key, function()
    openWebInspector({"Develop","Simulator","com.tylervick.BetterYT"})
  end)

end

return {
    init = module_init
}