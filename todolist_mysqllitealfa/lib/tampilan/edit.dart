import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_mysqllitealfa/Models/catatan_oprasi.dart';
import 'package:todolist_mysqllitealfa/Models/catatan.dart';
import 'package:todolist_mysqllitealfa/helpers/dbhelper.dart';

class EditScreen extends StatefulWidget {
  final Note note;
  const EditScreen({Key? key, required this.note});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController = TextEditingController(text: widget.note.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 194, 207),
      appBar: AppBar(
        title: const Text('Edit Note'),
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
              controller: _titleController,
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
            ),
            Expanded(
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Description',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                String updatedTitle = _titleController.text;
                String updatedDescription = _descriptionController.text;
                Note updatedNote = Note(
                  id: widget.note.id,
                  title: updatedTitle,
                  description: updatedDescription,
                );
                await dbhelper.instance.update(updatedNote);
                Provider.of<NotesOperation>(context, listen: false)
                    .getNotesFromDatabase();
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                backgroundColor: Colors.white,
              ),
              child: const Text('Update Note',
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