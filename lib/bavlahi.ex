defmodule Bavlahi do
  @moduledoc """
  Documentation for Bavlahi.
  """

  @spec get_latest_video_for_channel(String.t()) :: Video.t()
  def get_latest_video_for_channel(channel_id) do
    {:ok, channels_list} =
      GoogleApi.YouTube.V3.Api.Channels.youtube_channels_list(
        get_connection(),
        "contentDetails",
        id: channel_id
      )

    uploads_id = get_uploads_playlist_from_only_channel_in_channel_list(channels_list)

    playlistitem_list = get_playlistitems_by_id(uploads_id)

    case playlistitem_list.items do
      [playlistitem] -> %Video{id: playlistitem.contentDetails.videoId}
    end
  end

  @spec get_connection() :: Tesla.Client.t()
  def get_connection do
    {:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/youtube")
    GoogleApi.YouTube.V3.Connection.new(token.token)
  end

  defp get_playlistitems_by_id(playlistId) do
    {:ok, playlistitem_list} =
      GoogleApi.YouTube.V3.Api.PlaylistItems.youtube_playlist_items_list(
        get_connection(),
        "contentDetails",
        playlistId: playlistId,
        maxResults: 1
      )

    playlistitem_list
  end

  defp get_uploads_playlist_from_only_channel_in_channel_list(channels_list) do
    case channels_list.items do
      [channel] ->
        channel.contentDetails.relatedPlaylists.uploads
    end
  end
end
