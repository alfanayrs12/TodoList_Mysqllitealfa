import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Models/notes_operation.dart';
import 'package:todo_list/Models/note.dart';
import 'package:todo_list/screen/add_screen.dart';
import 'package:todo_list/screen/edit_screen.dart';
import 'package:todo_list/screen/notes_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Provider.of<NotesOperation>(context, listen: false).getNotesFromDatabase();

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, size: 30, color: Colors.blueGrey),
      ),
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<NotesOperation>(
        builder: (context, data, child) {
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(note: data.getNotes[index]),
                    ),
                  );
                },
                child: NotesCard(note: data.getNotes[index]),
                
              );
            },
          );
        },
      ),
    );
  }
}