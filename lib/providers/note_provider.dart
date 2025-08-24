import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  final Box<Note> _noteBox = Hive.box<Note>('notes');

  List<Note> get notes => _noteBox.values.toList();

  void addNote(Note note) {
    _noteBox.add(note);
    notifyListeners();
  }

  void toggleFinished(int index) {
    final note = _noteBox.getAt(index);
    if (note != null) {
      note.isFinished = !note.isFinished;
      note.save();
      notifyListeners();
    }
  }

  void deleteNote(int index) {
    _noteBox.deleteAt(index);
    notifyListeners();
  }
}
