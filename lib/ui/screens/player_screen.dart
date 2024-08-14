import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../bloc/music_bloc.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My best playlist'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          if (state is MusicPlaying || state is MusicPaused) {
            final song = state is MusicPlaying
                ? state.currentSong
                : (state as MusicPaused).currentSong;
            final position = state is MusicPlaying
                ? state.currentPosition
                : (state as MusicPaused).currentPosition;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  child: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(Icons.abc),
                  ),
                ),
                const SizedBox(height: 20),
                Text(song.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                Text(song.artist ?? 'Unknown Artist',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                Text(position.toString().split('.').first,
                    style: const TextStyle(fontSize: 16)),
                Slider(
                  min: 0,
                  max: song.duration!.toDouble(),
                  value: position.inMilliseconds.toDouble(),
                  onChanged: (value) {
                    // Slider value change handler
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: () {
                        BlocProvider.of<MusicBloc>(context)
                            .add(PreviousMusic());
                      },
                    ),
                    IconButton(
                      icon: Icon(state is MusicPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        if (state is MusicPlaying) {
                          BlocProvider.of<MusicBloc>(context).add(PauseMusic());
                        } else {
                          BlocProvider.of<MusicBloc>(context)
                              .add(ResumeMusic());
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: () {
                        BlocProvider.of<MusicBloc>(context).add(NextMusic());
                      },
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: Text('No music playing.'));
          }
        },
      ),
    );
  }
}
