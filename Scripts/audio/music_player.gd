extends AudioStreamPlayer

# A simple function to switch tracks smoothly
func play_music(new_stream: AudioStream):
	if stream == new_stream and playing:
		return # Don't restart if it's already playing the same song
	
	stream = new_stream
	play()

func stop_music():
	stop()
