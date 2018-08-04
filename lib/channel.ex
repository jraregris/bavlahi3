defmodule Channel do
  @type t :: %__MODULE__{id: String.t()}
  @enforce_keys [:id]
  defstruct [:id]

  @spec from_id(String.t()) :: Channel.t()
  def from_id(id) do
    %Channel{id: id}
  end

  @spec get_uploads(Channel.t()) :: Playlist.t()
  def get_uploads(channel) do
    {:ok, channels_list} =
      GoogleApi.YouTube.V3.Api.Channels.youtube_channels_list(
        Youtube.get_connection(),
        "contentDetails",
        id: channel.id
      )

    uploads_id =
      case channels_list.items do
        [channel] ->
          channel.contentDetails.relatedPlaylists.uploads
      end

    Playlist.from_id(uploads_id)
  end
end
