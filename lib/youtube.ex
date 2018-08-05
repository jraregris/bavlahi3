defmodule Youtube do
  @spec get_connection() :: Tesla.Client.t()
  def get_connection do
    {:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/youtube")
    GoogleApi.YouTube.V3.Connection.new(token.token)
  end

  def get_one_playlist_items(playlist_id) do
    GoogleApi.YouTube.V3.Api.PlaylistItems.youtube_playlist_items_list(
      Youtube.get_connection(),
      "contentDetails",
      playlistId: playlist_id,
      maxResults: 1
    )
  end
end
