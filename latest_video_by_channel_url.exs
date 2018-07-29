[channel_id | _] = System.argv()

{:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/youtube")
conn = GoogleApi.YouTube.V3.Connection.new(token.token)

{:ok, channels_list} =
  GoogleApi.YouTube.V3.Api.Channels.youtube_channels_list(
    conn,
    "contentDetails",
    id: channel_id
  )

uploads_id =
  case channels_list.items do
    [channel] ->
      channel.contentDetails.relatedPlaylists.uploads

    _ ->
      exit(1)
  end

{:ok, playlistitem_list} =
  GoogleApi.YouTube.V3.Api.PlaylistItems.youtube_playlist_items_list(
    conn,
    "contentDetails",
    playlistId: uploads_id,
    maxResults: 1
  )

video_id =
  case playlistitem_list.items do
    [playlistitem] -> playlistitem.contentDetails.videoId
    _ -> exit(1)
  end

IO.puts("https://www.youtube.com/watch?v=#{video_id}")
