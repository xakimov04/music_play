part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object> get props => [];
}

class MusicInitial extends MusicState {}

class MusicLoading extends MusicState {}

class MusicLoaded extends MusicState {
  final List<SongModel> musicFiles;

  const MusicLoaded({required this.musicFiles});

  @override
  List<Object> get props => [musicFiles];
}

class MusicPlaying extends MusicState {
  final SongModel currentSong;
  final Duration currentPosition;

  const MusicPlaying({required this.currentSong, required this.currentPosition});

  @override
  List<Object> get props => [currentSong, currentPosition];
}

class MusicPaused extends MusicState {
  final SongModel currentSong;
  final Duration currentPosition;

  const MusicPaused({required this.currentSong, required this.currentPosition});

  @override
  List<Object> get props => [currentSong, currentPosition];
}

class MusicError extends MusicState {
  final String message;

  const MusicError({required this.message});

  @override
  List<Object> get props => [message];
}
