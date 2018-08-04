defmodule Video do
  @type t :: %__MODULE__{id: String.t()}
  @enforce_keys [:id]
  defstruct [:id]

  @doc ~S"""
  Prepend string with url-prefix that results in a video url

  ## Examples

    iex> Video.to_url(%Video{id: "RQGa0DPwes0"})
    "https://www.youtube.com/watch?v=RQGa0DPwes0"
  """
  @spec to_url(Video.t()) :: String.t()
  def to_url(video) do
    "https://www.youtube.com/watch?v=" <> video.id
  end

  @doc ~S"""
  Prepend string with url-prefix that results in an embed url

  ## Examples

    iex> Video.to_embed_url(%Video{id: "RQGa0DPwes0"})
    "https://www.youtube.com/embed/RQGa0DPwes0"
  """
  @spec to_embed_url(Video.t()) :: String.t()
  def to_embed_url(video) do
    "https://www.youtube.com/embed/" <> video.id
  end
end
