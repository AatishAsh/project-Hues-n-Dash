extends AudioStreamPlayer

func play_music(new_stream: AudioStream):
	if stream == new_stream and playing:
		return 
	
	stream = new_stream
	play()

func stop_music():
	stop()
