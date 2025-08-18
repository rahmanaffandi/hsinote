import 'package:flutter_bloc/flutter_bloc.dart';

// Model sederhana untuk Note
class Note {
  final String title;
  final String content;
  final bool isFinished;

  Note({
    required this.title,
    required this.content,
    this.isFinished = false,
  });

  Note copyWith({String? title, String? content, bool? isFinished}) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

// State berupa daftar note
class NoteCubit extends Cubit<List<Note>> {
  NoteCubit() : super([]);

  void addNote(Note note) {
    emit([...state, note]);
  }

  void deleteNote(int index) {
    final newList = List<Note>.from(state)..removeAt(index);
    emit(newList);
  }

  void toggleFinished(int index) {
    final note = state[index];
    final updated = note.copyWith(isFinished: !note.isFinished);
    final newList = List<Note>.from(state)..[index] = updated;
    emit(newList);
  }
}
