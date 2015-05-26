package kha.audio2;

import haxe.ds.Vector;
import kha.audio1.MusicChannel;
import kha.audio1.SoundChannel;

class Audio1 {
	private static inline var channelCount: Int = 16;
	private static var soundChannels: Vector<SoundChannel>;
	private static var musicChannels: Vector<MusicChannel>;
	
	@:noCompletion
	public static function _init(): Void {
		soundChannels = new Vector<SoundChannel>(channelCount);
		musicChannels = new Vector<MusicChannel>(channelCount);
		Audio.audioCallback = _mix;
	}
	
	private static function _mix(samples: Int, buffer: Buffer): Void {
		for (i1 in 0...samples) {
			var value: Float = 0;
			
			for (i2 in 0...channelCount) {
				if (soundChannels[i2] != null) {
					var channel = soundChannels[i2];
					value += channel.nextSample() * channel.volume;
					value = Math.max(Math.min(value, 1.0), -1.0);
					if (channel.ended()) soundChannels[i2] = null;
				}
			}
			for (i2 in 0...channelCount) {
				if (musicChannels[i2] != null) {
					var channel = musicChannels[i2];
					value += channel.nextSample() * channel.volume;
					value = Math.max(Math.min(value, 1.0), -1.0);
					if (channel.ended()) musicChannels[i2] = null;
				}
			}
			
			buffer.data.set(buffer.writeLocation, value);
			buffer.writeLocation += 1;
			if (buffer.writeLocation >= buffer.size) {
				buffer.writeLocation = 0;
			}
		}
	}
	
	public static function playSound(sound: Sound): kha.audio1.SoundChannel {
		for (i in 0...channelCount) {
			if (soundChannels[i] == null) {
				var channel = new SoundChannel();
				channel.data = sound.data;
				soundChannels[i] = channel;
				return channel;
			}
		}
		return null;
	}
	
	public static function playMusic(music: Music, loop: Bool = false): kha.audio1.MusicChannel {
		for (i in 0...channelCount) {
			if (musicChannels[i] == null) {
				var channel = new MusicChannel(music.data, loop);
				musicChannels[i] = channel;
				return channel;
			}
		}
		return null;
	}
}
