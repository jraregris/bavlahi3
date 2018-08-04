defmodule Bavlahi do
  @moduledoc """
  Documentation for Bavlahi.
  """

  def get_connection do
    {:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/youtube")
    GoogleApi.YouTube.V3.Connection.new(token.token)
  end

  def get_latest_video_for_channel(conn, channel_id) do
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
      end

    {:ok, playlistitem_list} =
      GoogleApi.YouTube.V3.Api.PlaylistItems.youtube_playlist_items_list(
        conn,
        "contentDetails",
        playlistId: uploads_id,
        maxResults: 1
      )

    case playlistitem_list.items do
      [playlistitem] -> %Video{id: playlistitem.contentDetails.videoId}
    end
  end
end
