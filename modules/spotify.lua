-- -----------------------------------------------------------------------
--                             ** Spotify **                            --
-- -----------------------------------------------------------------------


local function module_init()

  -- Send a notification to display the current track
  -- Clicking the notification will toggle play/pause
  local function notifyTrack()

    if hs.application.get("Spotify") == nil then return end

    local spotify = hs.spotify
    local notify = hs.notify

    local function notificationClicked()
      spotify.playpause()
    end

    local track = hs.spotify.getCurrentTrack()
    local artist = hs.spotify.getCurrentArtist()
    -- local album = hs.spotify.getCurrentAlbum()

    local notification = notify.new(notificationClicked, {
      title=track,
      subTitle=artist
    })

    notification:send()
  end

  hs.hotkey.bind({"cmd", "alt", "shift"}, "D", notifyTrack)

end

return {
  init = module_init
}