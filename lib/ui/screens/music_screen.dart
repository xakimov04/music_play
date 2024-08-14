import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/music_bloc.dart';
import 'player_screen.dart'; // Ensure this path is correct

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My best playlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // User profile action
            },
          ),
        ],
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          if (state is MusicLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MusicLoaded) {
            return ListView.builder(
              itemCount: state.musicFiles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.musicFiles[index].title),
                  subtitle: Text(state.musicFiles[index].artist ?? 'Unknown Artist'),
                  trailing: Text(state.musicFiles[index].duration.toString()),
                  onTap: () {
                    BlocProvider.of<MusicBloc>(context).add(PlayMusic(state.musicFiles[index]));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayerScreen(),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Failed to load music files.'));
          }
        },
      ),
    );
  }
}
