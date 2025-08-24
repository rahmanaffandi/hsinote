import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/note_model.dart';

class NoteCubit extends Cubit<List<NoteModel>> {
  final Box<NoteModel> box;
  NoteCubit(this.box) : super(const []);

  void load() {
    emit(box.values.toList());
  }

  void addNote(String title, String content) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final note = NoteModel(id: id, title: title, content: content);
    box.put(id, note);
    load();
  }

  void toggleFinished(String id) {
    final note = box.get(id);
    if (note != null) {
      note.isFinished = !note.isFinished;
      note.save();
      load();
    }
  }

  void deleteNote(String id) async {
    await box.delete(id);
    load();
  }
}
