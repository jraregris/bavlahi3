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
      [playlistitem] -> playlistitem.contentDetails.videoId
    end
  end

  @doc ~S"""
  Prepend string with url-prefix that results in a video url

  ## Examples

    iex> Bavlahi.youtube_id_to_embed_url("RQGa0DPwes0")
    "https://www.youtube.com/embed/RQGa0DPwes0"
  """
  @spec youtube_id_to_video_url(String.t()) :: String.t()
  def youtube_id_to_video_url(video_id) do
    "https://www.youtube.com/watch?v=" <> video_id
  end

  @doc ~S"""
  Prepend string with url-prefix that results in an embed url

  ## Examples

    iex> Bavlahi.youtube_id_to_embed_url("RQGa0DPwes0")
    "https://www.youtube.com/embed/RQGa0DPwes0"
  """
  @spec youtube_id_to_embed_url(String.t()) :: String.t()
  def youtube_id_to_embed_url(video_id) do
    "https://www.youtube.com/embed/" <> video_id
  end
end
