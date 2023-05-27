import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app_hive/controller/notes_provider.dart';
import 'package:note_app_hive/view/add_notes_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Color> colorCard = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellowAccent,
    Colors.orange
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<NotesProvider>(context).getAllNotes();
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            addNote(context);
          },
          label: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<NotesProvider>(
                builder: (context, value, child) {
                  return value.notesList.isEmpty
                      ? Center(
                          child: Text("Note is empty..."),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 2
                                          : 3),
                          itemBuilder: ((context, index) {
                            final color = colorCard[index % colorCard.length];
                            final data = value.notesList[index];
                            return SizedBox(
                              height: 100.h,
                              width: 170.w,
                              child: Card(
                                color: color,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.title,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              if (data.id != null) {
                                                value.deleteNotesDB(data.id!);
                                              } else {
                                                if (kDebugMode) {
                                                  print("your id is null");
                                                }
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data.description,
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                ),
                              ),
                            );
                          }),
                          itemCount: value.notesList.length,
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
