-- -----------------------------------------------------------------------
--                           ** Outlook Keys **                         --
-- -----------------------------------------------------------------------

local function module_init()
  -- Move message to Archive
  function archiveMail() 
    local outlook = hs.application.get("Microsoft Outlook")
    outlook:selectMenuItem({"Message","Move","Archive (Epic)"})
    outlookModal:exit()
  end

  -- Mark mail with category
  function categorizeMail(category)
    local outlook = hs.application.get("Microsoft Outlook")
    outlook:selectMenuItem({"Message", "Categorize", category})
    outlookModal:exit()
  end

  outlookModal = hs.hotkey.modal.new({"ctrl", "cmd"}, "C")

  -- Outlook hotkeys
  function outlookModal:entered()
    local outlook = hs.application.get("Microsoft Outlook")
    
    if not outlook:isFrontmost() then
      outlookModal:exit()
      return
    end
  end

  -- Bind hotkeys to mail categories 
  outlookModal:bind('', 'escape', function() outlookModal:exit() end)
  outlookModal:bind('', 'L', function() categorizeMail("LCMC") end)
  outlookModal:bind('', 'B', function() categorizeMail("Baltimore") end)
  outlookModal:bind('', 'M', function() categorizeMail("Mercy") end)
  outlookModal:bind('', 'R', function() categorizeMail("Rockford") end)
  hs.hotkey.bind({"cmd","alt","shift"}, 'A', archiveMail)
  -- outlookModal:bind('','A', archiveMail)
end

return {
  init = module_init
}