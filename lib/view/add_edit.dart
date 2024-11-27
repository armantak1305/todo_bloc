import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/todo_model.dart';

import '../bloc/todo_event.dart';

class AddEditPage extends StatelessWidget{
  bool isUpdate;
  String title,desc;
  int sno;
  AddEditPage({this.sno=0,this.title="",this.desc="",this.isUpdate=false});
  TextEditingController titleController =TextEditingController();
  TextEditingController descController =TextEditingController();
  @override

  Widget build(BuildContext context) {
    if(isUpdate){
      titleController.text =title;
      descController.text=desc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate?"Update":"Add"),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: "Enter THe Title"
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: descController,
            decoration: InputDecoration(
                hintText: "Enter The Description"
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                if(isUpdate){
                  context.read<TodoBloc>().add(TodoUpdateEvent(updatetodo: TodoModel(title: titleController.text, desc: descController.text, create_at: DateTime.now().millisecondsSinceEpoch.toString()), sno: sno));
                }
                else{
                  context.read<TodoBloc>().add(TodoAddEvent(addtodo: TodoModel(title: titleController.text, desc: descController.text, create_at: DateTime.now().millisecondsSinceEpoch.toString())));
                }
                Navigator.pop(context);
              }, child: Text(isUpdate?"update":"Add")),
              ElevatedButton(onPressed: (){}, child: Text("Cancel"))
            ],
          )
        ],
      ),
    );
  }

}