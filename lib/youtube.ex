defmodule Youtube do
  @spec get_connection() :: Tesla.Client.t()
  def get_connection do
    {:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/youtube")
    GoogleApi.YouTube.V3.Connection.new(token.token)
  end
end
