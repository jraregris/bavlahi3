defmodule Bavlahi do
  @moduledoc """
  Documentation for Bavlahi.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Bavlahi.hello
      :world

  """
  def hello do
    :world
  end

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

  def youtube_id_to_video_url(video_id) do
    "https://www.youtube.com/watch?v=" <> video_id
  end

  @doc """
  Prepend string with url-prefix that results in an embed url
  """
  @spec youtube_id_to_embed_url(String.t()) :: String.t()
  def youtube_id_to_embed_url(video_id) do
    "https://www.youtube.com/embed/" <> video_id
  end
end
