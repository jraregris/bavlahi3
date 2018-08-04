[channel_id | _] = System.argv()

Channel.from_id(channel_id)
|> Channel.get_uploads()
|> Playlist.get_newest()
|> Video.to_embed_url()
|> IO.puts()
