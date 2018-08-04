[channel_id | _] = System.argv()

Bavlahi.get_connection()
|> Bavlahi.get_latest_video_for_channel(channel_id)
|> Video.to_embed_url()
|> IO.puts()
