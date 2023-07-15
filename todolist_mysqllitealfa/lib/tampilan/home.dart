import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_mysqllitealfa/Models/catatan_oprasi.dart';
import 'package:todolist_mysqllitealfa/Models/catatan.dart';
import 'package:todolist_mysqllitealfa/tampilan/add.dart';
import 'package:todolist_mysqllitealfa/tampilan/edit.dart';
import 'package:todolist_mysqllitealfa/tampilan/kartu_catatan.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Provider.of<NotesOperation>(context, listen: false).getNotesFromDatabase();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 194, 207),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 235, 0, 0),
        child: const Icon(Icons.add, size: 30, color: Color.fromARGB(255, 218, 241, 3)),
      ),
      appBar: AppBar(
        title: const Text(
          'Catatan Harian',
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