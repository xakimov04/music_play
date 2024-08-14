import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  MusicBloc() : super(MusicInitial()) {
    on<LoadMusicFiles>(_onLoadMusicFiles);
    on<PlayMusic>(_onPlayMusic);
    on<PauseMusic>(_onPauseMusic);
    on<ResumeMusic>(_onResumeMusic);
    on<PreviousMusic>(_onPreviousMusic);
    on<NextMusic>(_onNextMusic);
  }

  void _onLoadMusicFiles(LoadMusicFiles event, Emitter<MusicState> emit) async {
    try {
      emit(MusicLoading());
      List<SongModel> musicFiles = await _audioQuery.querySongs();
      emit(MusicLoaded(musicFiles: musicFiles));
    } catch (e) {
      emit(MusicError(message: e.toString()));
    }
  }

  void _onPlayMusic(PlayMusic event, Emitter<MusicState> emit) {
    emit(MusicPlaying(currentSong: event.song, currentPosition: Duration.zero));
  }

  void _onPauseMusic(PauseMusic event, Emitter<MusicState> emit) {
    if (state is MusicPlaying) {
      final currentState = state as MusicPlaying;
      emit(MusicPaused(currentSong: currentState.currentSong, currentPosition: currentState.currentPosition));
    }
  }

  void _onResumeMusic(ResumeMusic event, Emitter<MusicState> emit) {
    if (state is MusicPaused) {
      final currentState = state as MusicPaused;
      emit(MusicPlaying(currentSong: currentState.currentSong, currentPosition: currentState.currentPosition));
    }
  }

  void _onPreviousMusic(PreviousMusic event, Emitter<MusicState> emit) {
    // Implement logic to play previous song
  }

  void _onNextMusic(NextMusic event, Emitter<MusicState> emit) {
    // Implement logic to play next song
  }
}
