[channel_id | _] = System.argv()

conn = Bavlahi.get_connection()

video_id = Bavlahi.get_latest_video_for_channel(conn, channel_id)

video_id |> Bavlahi.youtube_id_to_embed_url() |> IO.puts()
