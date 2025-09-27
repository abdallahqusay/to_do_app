import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';


class SqfliteHelper {
  late Database db;

  void initDB()async{ // create database
    await openDatabase('tasks.db',version: 1,onCreate: (db, version) async{
      await db.execute('''
         CREATE TABLE Tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT ,
        title TEXT,
        note TEXT,
        date TEXT,
        startTime TEXT,
        endTime TEXT,
        color INTEGER,
        isCompleted INTEGER )
      ''').then(
          (value) => print('DB created successfully'),
        );
      },
      onOpen: (db) => print('Database opened'), // database etfhat
    ).then((value) => db = value);
  }
   Future<List<Map<String, dynamic>>> getFromDB() async {
    return await db.rawQuery('SELECT * FROM Tasks');
  }

  Future<int>insertToDB(TaskModel model)async{
    return await db.rawInsert('''
      INSERT INTO Tasks( 
      title ,note ,date ,startTime ,endTime ,color ,isCompleted )
         VALUES
         ('${model.title}','${model.note}','${model.date}','${model.startTime}',
       '${model.endTime}','${model.color}','${model.isCompleted}')''');
  }
  Future<int> updatedDB(int id) async {
    return await db.rawUpdate('''
    UPDATE Tasks
    SET isCompleted = ? // 1
    WHERE id = ? // id
   ''', [1, id]);
  }

  //! delete
  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete(
      '''DELETE FROM Tasks WHERE id = ?''',
      [id],
    );
  }
}