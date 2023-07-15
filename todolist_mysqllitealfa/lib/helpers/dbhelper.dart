import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_mysqllitealfa/Models/catatan.dart';

class dbhelper {
  static final dbhelper instance = dbhelper._();
  static Database? _database;

  dbhelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String pathString = path.join(documentsDirectory.path, 'latihan');

    return await openDatabase(
      pathString,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE note_app(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)',
        );
      },
    );
  }

  Future<int> insert(Note note) async {
    final db = await database;
    return await db.insert('note_app', note.toMap());
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('note_app');
    return List.generate(maps.length, (index) {
      return Note.fromMap(maps[index]);
    });
  }

  Future<int> update(Note note) async {
    final db = await database;
    return await db.update(
      'note_app',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(Note note) async {
    final db = await database;
    return await db.delete(
      'note_app',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}