import 'package:flutter/material.dart';
import 'package:note_app_hive/controller/notes_provider.dart';
import 'package:note_app_hive/model/note_model.dart';
import 'package:provider/provider.dart';

final tittleController = TextEditingController();
final descriptionController = TextEditingController();

Future<void> addNote(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        final provider = Provider<NoteModel>;
        return AlertDialog(
          title: const Text("Add note"),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: tittleController,
                decoration: const InputDecoration(
                  hintText: "Enter tittle",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Enter description",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            Consumer<NotesProvider>(
              builder: (context, value, child) => TextButton(
                  onPressed: () {
                    final data = NoteModel(
                        title: tittleController.text,
                        description: descriptionController.text);
                    value.addNotes(data);

                    tittleController.clear();
                    descriptionController.clear();

                    Navigator.pop(context);
                  },
                  child: const Text("Add")),
            ),
          ],
        );
      });
}
