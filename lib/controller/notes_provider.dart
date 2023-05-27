import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_hive/model/note_model.dart';

class NotesProvider extends ChangeNotifier {
  List<NoteModel> notesList = [];

  addNotes(NoteModel model) async {
    final notesDB = await Hive.openBox<NoteModel>("notesDB");
    final id = await notesDB.add(model);
    model.id = id;
    notesList.add(model);
    notifyListeners();
  }

  Future<void> getAllNotes() async {
    final notesDB = await Hive.openBox<NoteModel>("notesDB");
    notesList.clear();
    notesList.addAll(notesDB.values);
    notifyListeners();
  }

  Future<void> deleteNotesDB(int id) async {
    final notesDB = await Hive.openBox<NoteModel>("notesDB");
    await notesDB.delete(id);
    getAllNotes();
    notifyListeners();
  }
}
