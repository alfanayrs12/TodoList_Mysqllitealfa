import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_mysqllitealfa/Models/catatan_oprasi.dart';
import 'package:todolist_mysqllitealfa/Models/catatan.dart';
import 'package:todolist_mysqllitealfa/helpers/dbhelper.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    late String titleText;
    late String descriptionText;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 194, 207),
      appBar: AppBar(
        title: const Text('Catatan Harian'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: 80,
        ),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              onChanged: (value) {
                titleText = value;
              },
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                onChanged: (value) {
                  descriptionText = value;
                },
              ),
            ),
            TextButton(
              onPressed: () async {
                Note note = Note(
                  title: titleText,
                  description: descriptionText,
                );
                await dbhelper.instance.insert(note);
                Provider.of<NotesOperation>(context, listen: false)
                    .getNotesFromDatabase();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                backgroundColor: Colors.white,
              ),
              child: const Text('Add Note',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 194, 207),
                  )),
            )
          ],
        ),
      ),
    );
  }
}