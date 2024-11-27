import 'package:todo_bloc/data/dbhelper.dart';

class TodoModel{
  int?sno;
  String title,desc,create_at;
  int iscompleted;
  TodoModel({this.sno,required this.title,required this.desc,required this.create_at,this.iscompleted=0});

  ///from Map to Model..
  factory TodoModel.fromMap(Map<String,dynamic> map){
    return TodoModel(
        sno: map[DBhelper.COLUMN_SNO],
        title: map[DBhelper.COLUMN_TITLE],
        desc: map[DBhelper.COLUMN_DESC],
        create_at: map[DBhelper.COLUMN_CREATED_AT],
        iscompleted: map[DBhelper.COLUMN_ISCOMPLETED]
    );
  }
  ///from model toMap..
  Map<String,dynamic> toMap(){
    return {
      DBhelper.COLUMN_TITLE:title,
      DBhelper.COLUMN_DESC:desc,
      DBhelper.COLUMN_CREATED_AT:create_at,
      DBhelper.COLUMN_ISCOMPLETED:iscompleted
    };
  }
}