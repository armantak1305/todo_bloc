import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_bloc/todo_model.dart';

class DBhelper{
  ///single Instance..
  DBhelper._();
  static DBhelper getInstance()=>DBhelper._();

  static final String TODO_TABLE_NAME ="todo";
  static final String COLUMN_SNO ="sno";
  static final String COLUMN_TITLE ="title";
  static final String COLUMN_DESC ="desc";
  static final String COLUMN_CREATED_AT ="created_at";
  static final String COLUMN_ISCOMPLETED ="completed";
  ///global Db
  Database? mdb;

  ///getDB OpenDB..
  Future<Database> getDB()async{
    if(mdb!=null){
      return mdb!;
    }
    else{
      //openDB..
      mdb =await openDB();
      return mdb!;
    }
  }
  Future<Database> openDB()async{
    Directory appDirc =await getApplicationDocumentsDirectory();
    String dbPath =join(appDirc.path,"todos.db");
    return openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute('create table $TODO_TABLE_NAME ($COLUMN_SNO integer primary key autoincrement,$COLUMN_TITLE text,$COLUMN_DESC text,$COLUMN_CREATED_AT text,$COLUMN_ISCOMPLETED integer)');

    });
  }

  ///All queries..
  Future<bool>  insertTodo(TodoModel addTodo)async{
    var mDB =await getDB();
    int rowEffected = await mDB.insert(TODO_TABLE_NAME, addTodo.toMap());
    return rowEffected>0;
  }

  Future<List<TodoModel>> fetchTodo()async{
    var mDB =await getDB();
    var data =await mDB.query(TODO_TABLE_NAME);
    List<TodoModel> mTodo = [];
    for(Map<String,dynamic> eachdata in data){
      mTodo.add(TodoModel.fromMap(eachdata));
    }
    return mTodo;
  }

  Future<bool> updateTod(TodoModel updateTodo,int sno)async{
    var mDB=await getDB();
    int rowEffected =await mDB.update(TODO_TABLE_NAME, updateTodo.toMap(),where: "$COLUMN_SNO=$sno");
    return rowEffected>0;
  }

  Future<bool> deleteTodo(int sno)async{
    var mDB =await getDB();
    int rowEffected =await mDB.delete(TODO_TABLE_NAME,where:"$COLUMN_SNO=$sno");
    return rowEffected>0;
  }

}