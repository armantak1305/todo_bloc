import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/todo_model.dart';
import 'package:todo_bloc/bloc/todo_state.dart';


import '../bloc/todo_event.dart';
import 'add_edit.dart';

class HomePage extends StatelessWidget{
  DateFormat mFormat =DateFormat.yMMMd();
  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(TodoGetEvent());
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: BlocBuilder<TodoBloc,TodoState>(builder:(_,state){
        if(state is TodoLoadingState){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(state is TodoErrorState){
          return Center(child: Text("Error${state.errorMsg}"),);
        }
        if(state is TodoLoadedState){
          return state.mTodo.isNotEmpty?ListView.builder(
              itemCount: state.mTodo.length,
              itemBuilder: (ctx,index){
                var myTodo =state.mTodo[index];
                return CheckboxListTile(
                  value: myTodo.iscompleted==1,
                  onChanged: (value){
                    var checkupdate = TodoModel(title: myTodo.title, desc: myTodo.desc, create_at: myTodo.create_at,iscompleted: value!?1:0,sno: myTodo.sno);
                    context.read<TodoBloc>().add(TodoUpdateEvent(updatetodo: checkupdate, sno: myTodo.sno!));
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(myTodo.title),
                      Row(

                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPage(isUpdate: true,sno: myTodo.sno!,title: myTodo.title,desc: myTodo.desc,)));
                          }, icon: Icon(Icons.edit)),
                          IconButton(onPressed: (){
                            //ctx.read<TodoBloc>().add(TodoDeleteEvent(sno: myTodo.sno!));
                            context.read<TodoBloc>().add(TodoDeleteEvent(sno: myTodo.sno!));
                          }, icon: Icon(Icons.delete,color: Colors.red,)),
                        ],
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(myTodo.desc),
                      Text(mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(myTodo.create_at))))
                    ],

                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }):Center(child: Text("No todo yet!!"),);
        }
        return Container();
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditPage(),));
      },child: Icon(Icons.add),),
    );
  }

}