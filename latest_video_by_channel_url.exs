[channel_id | _] = System.argv()

conn = Bavlahi.get_connection()

video_id = Bavlahi.get_latest_video_for_channel(conn, channel_id)

IO.puts("https://www.youtube.com/watch?v=#{video_id}")
