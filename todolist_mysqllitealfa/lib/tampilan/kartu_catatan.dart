import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_mysqllitealfa/Models/catatan_oprasi.dart';
import 'package:todolist_mysqllitealfa/Models/catatan.dart';
import 'package:todolist_mysqllitealfa/tampilan/add.dart';
import 'package:todolist_mysqllitealfa/tampilan/edit.dart';
import 'package:todolist_mysqllitealfa/tampilan/kartu_catatan.dart';

class NotesCard extends StatelessWidget {
  final Note note;

  const NotesCard({required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(note.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(note: note),
                  ),
                );
              },
              icon: const Icon(Icons.edit, color: Colors.blueGrey),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content: const Text('Are you sure you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform delete operation
                            Provider.of<NotesOperation>(context, listen: false).deleteNote(note);
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

