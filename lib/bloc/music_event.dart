part of 'music_bloc.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class LoadMusicFiles extends MusicEvent {}

class PlayMusic extends MusicEvent {
  final SongModel song;

  const PlayMusic(this.song);

  @override
  List<Object> get props => [song];
}

class PauseMusic extends MusicEvent {}

class ResumeMusic extends MusicEvent {}

class PreviousMusic extends MusicEvent {}

class NextMusic extends MusicEvent {}
