# [playlist_id | _] = System.argv()

{:ok, token} = Goth.Token.for_scope("https://www.googleapis.com/auth/youtube")
conn = GoogleApi.YouTube.V3.Connection.new(token.token)

{:ok, playlistitems} =
  GoogleApi.YouTube.V3.Api.PlaylistItems.youtube_playlist_items_list(
    conn,
    "id",
    playlistId: "UUnbfRvqQcfw3eL71HfjROOQ",
    # playlistId: playlist_id,
    maxResults: 3
  )

playlistitems.items
|> IO.inspect()

# |> Enum.map(fn x ->
#  "#{x.snippet.publishedAt} -- #{x.snippet.title} -- https://www.youtube.com/watch?v=#{x.id}"
# end)
# |> Enum.join("\n")
# |> IO.puts()

IO.puts(
  "#{playlistitems.pageInfo.totalResults} total (#{playlistitems.pageInfo.resultsPerPage} per page)"
)
