defmodule Playlist do
  @type t :: %__MODULE__{id: String.t()}
  @enforce_keys [:id]
  defstruct [:id]

  @spec from_id(String.t()) :: Playlist.t()
  def from_id(id) do
    %Playlist{id: id}
  end

  @spec get_newest(Playlist.t()) :: Video.t()
  def get_newest(playlist) do
    {:ok, playlistitem_list} =
      GoogleApi.YouTube.V3.Api.PlaylistItems.youtube_playlist_items_list(
        Youtube.get_connection(),
        "contentDetails",
        playlistId: playlist.id,
        maxResults: 1
      )

    case playlistitem_list.items do
      [playlistitem] -> %Video{id: playlistitem.contentDetails.videoId}
    end
  end
end
